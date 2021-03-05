(with-eval-after-load 'ryo-modal
  (ryo-modal-keys
   (:mc-all t)
   ("RET" newline :first '(deactivate-mark) :mode 'prog-mode)
   ("RET" newline :first '(deactivate-mark) :mode 'html-mode)
   ("'"  ryo-modal-repeat)
   (","  xah-backward-left-bracket)
   ("-"  weiss-switch-to-same-side-frame)
   ("="  xah-cycle-hyphen-underscore-space)
   ("."  xah-forward-right-bracket)
   (";"  rotate-text)
   ("/"  weiss-mark-brackets)
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
   ("7"  xah-select-text-in-quote)
   ("8"  weiss-select-sexp :then '(weiss-select-mode-turn-on))
   ("9"  weiss-switch-to-otherside-top-frame)
   ("0"  weiss-switch-buffer-or-otherside-frame-without-top)

   ;; ("a"  weiss-open-line-and-indent :then '(weiss-indent-nearby-lines))
   ("a"  weiss-open-line-and-indent)
   ("b"  xah-toggle-letter-case)
   ("c"  xah-copy-line-or-region)
   ("d"  weiss-cut-line-or-delete-region)
   ("e"  weiss-delete-backward-with-region)
   ("f"  weiss-before-insert-mode :exit t)
   ("g"  weiss-universal-argument)
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
         ("o" ignore
          :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-o")))
          :name "C-c C-o"
          )
         ("l" ignore
          :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-l")))
          :name "C-c C-l"
          )
         ))
   ("u"  weiss-delete-or-add-parent-sexp)
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

  (let ((leader-keymap
         '(
           (","  (
                  ("e"  weiss-execute-buffer)
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
                  ("a" weiss-kill-append)
                  ("b" ignore
                   :name "copy whole buffer"
                   :then ((lambda () (interactive) (kill-new (buffer-string)))))
                  ("e" weiss-exchange-region-kill-ring-car)
                  ("f" ignore
                   :name "copy file name"
                   :then ((lambda () (interactive) (kill-new (buffer-file-name)))))
                  ("k" save-buffers-kill-terminal)
                  ("p" xah-copy-file-path)
                  )
            )
           ("d" (
                 ("a"  weiss-custom-daily-agenda)
                 ("b"  weiss-save-current-content)
                 ("c"  org-roam-capture)
                 ("d"  weiss-switch-and-bookmarks-search)
                 ("f"  org-roam-find-file)
                 ("j" yasdcv-translate-input)
                 ("l"  list-buffers)
                 ("m"  magit-status)
                 ("t"  org-todo-list)
                 ("n"  xah-new-empty-buffer)
                 ("o"  xah-open-file-at-cursor)
                 ("s" yasdcv-translate-at-point)
                 ("1"  org-roam-dailies-capture-today)
                 ("2"  org-roam-dailies-capture-tomorrow)
                 ("3"  org-roam-dailies-capture-date)
                 ("8"  org-roam-dailies-find-date)
                 ("9"  org-roam-dailies-find-yesterday)
                 ("0"  org-roam-dailies-find-today)
                 ("-"  org-roam-dailies-find-tomorrow)
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
                 ("v"  counsel-yank-pop)
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
                 ("h"  weiss-toggle-hl-line)
                 ;; ("l"  visual-line-mode)             ;wrap-line
                 ("l"  highlight-symbol)             ;wrap-line
                 ("m"  shell-command)
                 ("n"  display-line-numbers-mode)
                 ("p"  sql-postgres)
                 ("r"  dired-toggle-read-only :exit t)
                 ("s"  sudo-edit)
                 ("w"  toggle-word-wrap)
                 ))
           ("m"  dired-jump)
           ("n"  end-of-buffer)
           ("o" (
                 ("t"  telega)
                 ("v" yank-rectangle)
                 ("n" mc/mark-next-like-this)
                 ("a" mc/mark-all-like-this)
                 ("s" weiss-start-kmacro)
                 ;; ("l" weiss-kmacro-insert-letters)
                 ("k" weiss-deactivate-mark)
                 ("e" weiss-end-kmacro)
                 ("c" kmacro-call-macro)
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
                 ("n"  weiss-new-frame)
                 ("t"  weiss-test)
                 ("l"  xref-pop-marker-stack)
                 ("y"  winner-undo)                  ;windows setting
                 ("r"  winner-redo)
                 ("k"  delete-frame :then ((lambda () (interactive) (weiss-update-top-windows t))))
                 ("o"  org-babel-tangle-jump-to-org)
                 ))
           ;; ("x"  xah-cut-all-or-region)
           ;; ("y"  xah-search-current-word)
           )
         ))
    (eval `(ryo-modal-keys
            ("SPC" ,leader-keymap)
            ("<deletechar>" ,leader-keymap)
            ))
    )
  )

(provide 'weiss_ryo-bind-keys<ks)
