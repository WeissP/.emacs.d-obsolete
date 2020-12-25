;; -*- lexical-binding: t -*-
;; tramp

;; [[file:~/.emacs.d/config/emacs-config.org::*tramp][tramp:1]]
;; Tramp ivy interface
(setq remote-file-name-inhibit-cache nil)

(use-package sudo-edit)

(use-package counsel-tramp
  :bind (:map counsel-mode-map
              ("C-c c T" . counsel-tramp)))

(use-package docker-tramp)
;; tramp:1 ends here

;; recentf

;; [[file:~/.emacs.d/config/emacs-config.org::*recentf][recentf:1]]
;; Recent files
;; recentf-cleanup will update recentf-list
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :preface
  (defun snug/recentf-save-list-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-save-list))
        (recentf-save-list)))
    (message ""))
  (defun snug/recentf-cleanup-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-cleanup))
        (recentf-cleanup)))
    (message ""))
  :init
  (setq weiss-reduce-recentf-file-path-alist
        '(
          ("🅲🅻🅿" . "Compiler and Language-Processing Tools")
          ("🆂🅲" . "scientififc computing")
          ("🆅" . "Documents/Vorlesungen")
          ("🅥" . "Nutstore Files/Vorlesungen")
          ("🅹" . "src/main/java")
          ("🅙🅣" . "src/test/java")
          ))

  (defun weiss-reduce-file-path (filename &optional r)
    "replace long file paths with symbol"
    (interactive)
    (let ((search-str)
          (replace-str))
      (dolist (x weiss-reduce-recentf-file-path-alist)
        (if r
            (setq search-str (car x) 
                  replace-str (cdr x))
          (setq search-str (cdr x) 
                replace-str (car x)))      
        (setq filename (replace-regexp-in-string search-str replace-str filename t))
        )
      )  
    filename
    )

  (add-to-list 'recentf-filename-handlers 'abbreviate-file-name)
  (load (weiss--get-config-file-path "recentf"))
  (setq recentf-save-file (weiss--get-config-file-path "recentf"))
  :config
  (defun recentf-cleanup ()
    "Cleanup the recent list.
That is, remove duplicates, non-kept, and excluded files."
    (interactive)
    (message "Cleaning up the recentf list...")
    (let ((n 0)
          (ht (make-hash-table
               :size recentf-max-saved-items
               :test 'equal))
          newlist key)
      (dolist (f recentf-list)
        (setq f (weiss-reduce-file-path (recentf-expand-file-name f) t)
              key (if recentf-case-fold-search (downcase f) f))
        (if (and (recentf-include-p f)
                 (recentf-keep-p f)
                 (not (gethash key ht)))
            (progn
              (push (weiss-reduce-file-path f) newlist)
              (puthash key t ht))
          (setq n (1+ n))
          (message "File %s removed from the recentf list" f)))
      (message "Cleaning up the recentf list...done (%d removed)" n)
      (setq recentf-list (nreverse newlist))))
  (run-at-time nil (* 5 60) 'snug/recentf-save-list-silence)
  (run-at-time nil (* 5 60) 'snug/recentf-cleanup-silence)
  (setq
   recentf-max-menu-items 150
   recentf-max-saved-items 300
   ;; recentf-auto-cleanup '60
   ;; Recentf blacklist
   recentf-exclude '(
                     ".*autosave$"
                     "/ssh:"
                     ;; "/sudo:"
                     "recentf$"
                     ".*archive$"
                     ".*.jpg$"
                     ".*.png$"
                     ".*.gif$"
                     ".*.mp4$"
                     ".cache"
                     "cache"
                     "<none>.tex"
                     "frag-master.tex"
                     "_region_.tex"
                     ))
  )
(add-to-list 'recentf-filename-handlers 'weiss-reduce-file-path)
(load (weiss--get-config-file-path "recentf"))
;; recentf:1 ends here

;; misc

;; [[file:~/.emacs.d/config/emacs-config.org::*misc][misc:1]]
;; (require 'weiss-flycheck)
;; (require 'weiss_shell_or_terminal)
;; (require 'weiss_lang)
;; (require 'weiss_lsp)
;; (require 'weiss_eaf)
;; (require 'weiss_flyspell)
;; (require 'weiss_lang)
;; (require 'weiss_lsp)
;; (require 'weiss_read)
;; (require 'weiss_org)
;; (require 'weiss_latex

(bookmark-load "/home/weiss/.emacs.d/bookmarks" t t t)
(setq bookmark-save-flag 1)

(ignore-errors (savehist-mode 1))
(save-place-mode 1)

;; (dbus-init-bus :session)   ; for EAF DUMP

(setq weiss-left-top-window (selected-frame))
(setq weiss-right-top-window (make-frame-command))
(select-frame-set-input-focus weiss-left-top-window)

(setq gc-cons-threshold (* (expt 1024 2) 32)
      gc-cons-percentage 0.5)
;; misc:1 ends here

;; after dump

;; [[file:~/.emacs.d/config/emacs-config.org::*after dump][after dump:1]]
(use-package emacs-yakuake
  :load-path "/home/weiss/.emacs.d/local-package/dropdown-remote/"
  :ensure nil
  :config
  (defun weiss-dired-rsync ()
    "DOCSTRING"
    (interactive)
    (let ((marked-files (dired-get-marked-files))
          (target-path (or (car (dired-dwim-target-next)) "/home/weiss/Downloads/")))
      (cond
       ((string-prefix-p "/ssh:" (car marked-files))
        (dolist (x marked-files)
          (let ((file-paths (split-string x ":")))            
            (yakuake-run-command-in-session
             (yakuake-add-session)
             (format "rsync -PaAXv -e ssh \"%s:%s\" %s"
                     (nth 1 file-paths)
                     (nth 2 file-paths)
                     target-path)))          
          )
        )
       ((string-prefix-p "/docker:" (car marked-files))
        (dolist (x marked-files)
          (let ((file-paths (split-string x ":")))            
            (yakuake-run-command-in-session
             (yakuake-add-session)
             (format "docker cp \"%s:%s\" %s"
                     (nth 1 file-paths)
                     (nth 2 file-paths)
                     target-path)))          
          )
        )

       ((string-prefix-p "/docker:" target-path)
        (let* ((parse-path (split-string target-path ":"))
               (docker-path (format "%s:%s" (nth 1 parse-path) (nth 2 parse-path))))          
          (dolist (x marked-files)
            (yakuake-run-command-in-session (yakuake-add-session) (format "docker cp %s %s" (format "\"%s\"" x) docker-path))          
            ))        
        )
       (t (yakuake-run-command-in-session (yakuake-add-session) (format "rsync -aAXv %s %s" (format "\"%s\"" (mapconcat 'identity marked-files "\" \"")) target-path)))
       )      
      )
    (yakuake-toggle-window)        
    )

  (defun weiss-dired-git-clone ()
    "DOCSTRING"
    (interactive)
    (let* ((session (yakuake-add-session))
           (git-path (current-kill 0 t))
           (command (format "cd \"%s\" & git clone %s" (file-truename default-directory) git-path)))
      (if (string-prefix-p  "git@" git-path)
          (yakuake-run-command-in-session session command)
        (message "check your clipboard!" ))      
      ))
  )
;; after dump:1 ends here

;; ryo-bind-keys
;; Ryo-modal-mode can not bind void functions, so we bind keys at last.

;; [[file:~/.emacs.d/config/emacs-config.org::*ryo-bind-keys][ryo-bind-keys:1]]
(ryo-modal-keys
 (:mc-all t)
 ("RET" newline :first '(deactivate-mark) :mode 'prog-mode)
 ("'"  xah-cycle-hyphen-underscore-space)
 (","  xah-backward-left-bracket)
 ("-"  weiss-switch-to-same-side-frame)
 ("="  ryo-modal-repeat)
 ("."  xah-forward-right-bracket)
 (";"  rotate-text)
 ("/"  xah-goto-matching-bracket)
 ("\\"  nil)
 ;; ("["  origami-recursively-toggle-node)
 ;; ("]"  weiss-other-frame)
 ;; ("}"  hs-show-all)
 ;; ("`"  other-frame)

 ;; ("<backtab>"  weiss-indent)
 ("V"  weiss-paste-with-linebreak)
 ;;  ("!"  rotate-text)
 ;; ("#"  xah-backward-quote)
 ;; ("$"  xah-forward-punct)

 ("1"  scroll-down)
 ("2"  scroll-up)
 ("3"  weiss-delete-other-window)
 ("4"  split-window-below)
 ("5"  weiss-test)
 ("6"  mark-defun :then '(weiss-select-mode-turn-on))
 ("7"  weiss-select-sexp :then '(weiss-select-mode-turn-on))
 ("8"  xah-select-text-in-quote)
 ("9"  weiss-switch-to-otherside-top-frame)
 ("0"  weiss-switch-buffer-or-otherside-frame-without-top)

 ;; ("a"  weiss-open-line-and-indent :then '(weiss-indent-nearby-lines))
 ("a"  weiss-open-line-and-indent)
 ("b"  xah-toggle-letter-case)
 ("c"  xah-copy-line-or-region)
 ("d"  weiss-cut-line-or-delete-region)
 ("e"  weiss-delete-backward-with-region)
 ("f"  weiss-before-insert-mode :exit t)
 ;; ("g a"  universal-argument)
 ("g"  weiss-universal-argument)
 ;; ("g a"  ignore
 ;; :then '((lambda () (interactive) (weiss--execute-kbd-macro "C-u")))
 ;; :name "universal argument")
 ("h"  weiss-select-line-downward )
 ("i"  weiss-left-key)
 ("j"  weiss-down-key)
 ("k"  weiss-up-key)
 ("l"  weiss-right-key)
 ("m"  er/expand-region :then '(weiss-select-mode-turn-on))
 ("n"  swiper-isearch)
 ("o"  weiss-expand-region-by-word :first '(weiss-select-mode-turn-on))
 ("p"  weiss-insert-line :exit t)
 ("q"  weiss-temp-insert-mode :exit t)
 ("r"  weiss-delete-forward-with-region)
 ("s"  snails)
 ("t" (
       ("e" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-c")))
        :name "C-c C-c"
        )
       ("k" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-k")))
        :name "C-c C-k"
        )
       ("u" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c '")))
        :name "C-c '"
        )         
       ))
 ("u"  weiss-delete-or-add-parent-sexp :exit t)
 ("v"  xah-paste-or-paste-previous)
 ("w"  xah-shrink-whitespaces)
 ("x"  weiss-exange-point-or-beginning-of-line)
 ("y"  undo)
 ("z"  weiss-comment-dwim)
 ("<escape> ," previous-buffer)
 ("<escape> ." next-buffer)
 )

(ryo-modal-major-mode-keys
 'emacs-lisp-mode
 ("t t"  weiss-move-next-bracket-contents)
 )

(ryo-modal-major-mode-keys
 'lisp-interaction-mode
 ("t t"  weiss-move-next-bracket-contents)
 )

(ryo-modal-command-then-ryo "M-m" 'weiss-select-mode-disable weiss-select-mode-map)

(ryo-modal-keys
 ("SPC" (
         (","  (
                ("e"  weiss-excute-buffer)
                ("c"  quickrun-compile-only)
                ("d"  eval-defun)
                ("m"  weiss-eval-last-sexp-this-line)
                ("r"  eval-expression)
                ("f"  eval-region)
                ("x"  save-buffers-kill-terminal)
                ("5"  revert-buffer)
                ))
         ("." (
               ("p"  narrow-to-page)
               ("x"  widen)
               ("r"  narrow-to-region)
               ("d"  narrow-to-defun)                 
               ))
         ("-"  xah-cycle-hyphen-underscore-space)
         (";"  save-buffer)
         ("3"  delete-window)
         ("4"  split-window-right)
         ("5"  weiss-refresh)
         ;; ("6"  xah-upcase-sentence)
         ("9"  ignore
          :name "copy whole buffer"
          :then ((lambda () (interactive) (kill-new (buffer-substring)))))
         ("a"  mark-whole-buffer :then (weiss-select-mode-turn-on))
         ("b"  xah-toggle-previous-letter-case)
         ("c"  (
                ("k" save-buffers-kill-terminal)
                ("p" xah-copy-file-path)
                ("b" ignore
                 :name "copy whole buffer"
                 :then ((lambda () (interactive) (kill-new (buffer-string)))))
                ))
         ("d" (
               ;; ("a"  weiss-custom-daily-agenda)
               ("b"  weiss-save-current-content)
               ("c"  calendar)
               ;; ("d"  weiss-switch-and-bookmarks-search)
               ("j" yasdcv-translate-input)
               ("l"  list-buffers)
               ("m"  magit-status)
               ("n"  xah-new-empty-buffer)
               ("o"  xah-open-file-at-cursor)
               ("s" yasdcv-translate-at-point)
               ("t"  telega)
               ("w"  xah-open-in-external-app)
               ))
         ("e" (
               ("b"  org-babel-tangle)
               ("c"  org-capture)
               ("v"  ignore
                :then ((lambda () (interactive) (require 'dired-video-preview-mode)(dired-video-preview-mode)))
                :name "dired-video-preview-mode")
               ))
         ("f"  execute-extended-command)
         ("g"  kill-line)
         ("h"  beginning-of-buffer)
         ("i" (
               ("d"  weiss-insert-date)
               ("e"  find-file)
               ("f"  counsel-fzf)
               ("j"  yasdcv-translate-input)
               ("m"  all-the-icons-insert)
               ("p"  bookmark-set)
               ("s"  yasdcv-translate-at-point)
               ))
         ("j" (
               ("K"  Info-goto-emacs-key-command-node)
               ("a"  apropos-command)
               ("b"  describe-bindings)
               ("c"  describe-char)
               ("d"  apropos-documentation)
               ("e"  view-echo-area-messages)
               ("f"  describe-function)
               ("g"  info-lookup-symbol)
               ("h"  describe-face)
               ("i"  info)
               ("j"  man)
               ("k"  describe-key)
               ("l"  view-lossage)
               ("m"  describe-mode)
               ("n"  apropos-value)
               ("o"  describe-language-environment)
               ("p"  finder-by-keyword)
               ("r"  apropos-variable)
               ("s"  describe-syntax)
               ("u"  elisp-index-search)
               ("v"  describe-variable)
               ("x"  describe-coding-system)
               ("z"  Info-goto-emacs-command-node)
               )
          )
         ("k" (
               ("SPC"  xah-clean-whitespace)
               ("TAB" move-to-column)
               ("-"  xah-cycle-hyphen-underscore-space)
               ("1"  xah-append-to-register-1)
               ("2"  xah-clear-register-1)
               ("3"  xah-copy-to-register-1)
               ("4"  xah-paste-from-register-1)
               ("8"  xah-clear-register-1)
               ("7"  xah-append-to-register-1)
               ("0"  sort-numeric-fields)
               ("S"  reverse-region)
               ("c"  weiss-convert-sql-output-to-table)
               ("d"  delete-non-matching-lines)
               ("e"  list-matching-lines)
               ("f"  goto-line)
               ("i"  weiss-indent)
               ("j"  kill-current-buffer)
               ("l"  xah-escape-quotes)
               ("m"  xah-make-backup-and-save)
               ("n"  repeat-complex-command)
               ("q"  xah-reformat-lines)
               ("r"  anzu-query-replace-regexp)
               ("s"  sort-lines)
               ("t"  repeat)
               ("u"  delete-matching-lines)
               ("y"  delete-duplicate-lines)
               ))
         ("l" (
               ("SPC"  whitespace-mode)
               ("." toggle-frame-fullscreen)
               ("0" shell-command-on-region)
               ("8" ignore :then ((lambda ()(interactive) (if org-hide-emphasis-markers
                                                              (setq org-hide-emphasis-markers nil)
                                                            (setq org-hide-emphasis-markers t)
                                                            ))) :name "org-toggle-emphasis-markers")
               ("C"  toggle-case-fold-search)
               ("b"  toggle-debug-on-error)
               ("c"  dired-collapse-mode)
               ;; ("e"  ignore :then ((lambda () (interactive) (unless (featurep 'aweshell) (require 'aweshell))(eshell))) :name "eshell")
               ("e"  eshell)
               ("h"  global-hl-line-mode)
               ;; ("l"  visual-line-mode)             ;wrap-line
               ("l"  highlight-symbol)             ;wrap-line
               ("m"  shell-command)
               ("n"  display-line-numbers-mode)
               ("p"  sql-postgres)
               ("r"  weiss-dired-toggle-read-only)
               ("s"  sudo-edit)
               ("w"  toggle-word-wrap)
               ))
         ("m"  dired-jump)
         ("n"  end-of-buffer)
         ("o" (
               ("n" mc/mark-more-like-this-extended)
               ))
         ("p"  recenter-top-bottom)
         ("q"  xah-fill-or-unfill)
         ("r"  anzu-query-replace)
         ("s"  exchange-point-and-mark)
         ("t"  xah-show-kill-ring)
         ("u"  isearch-forward)
         ("v" (
               ("s"  start-kbd-macro)
               ("e"  end-kbd-macro)
               ("m"  kmacro-end-and-call-macro)
               ("c"  call-last-kbd-macro)
               ("n"  weiss-call-kmacro-multi-times)
               ))
         ("w" (
               ("f"  xref-find-definitions)
               ("m"  list-bookmarks)
               ("n"  make-frame-command)
               ("t"  weiss-test)
               ("l"  xref-pop-marker-stack)
               ("y"  winner-undo)                  ;windows setting
               ("r"  winner-redo)
               ("k"  delete-frame)
               ("o"  org-babel-tangle-jump-to-org)
               ))
         ;; ("x"  xah-cut-all-or-region)
         ;; ("y"  xah-search-current-word)
         )))
;; ryo-bind-keys:1 ends here
