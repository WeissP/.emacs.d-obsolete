;; init-org.el --- Initialize org configurations.	-*- lexical-binding: t -*-

;;; Code:

;; (use-package org-functions
;;   :straight (org-functions
;;              :type git
;;              :host github
;;              :repo "hlissner/doom-emacs"
;;              :files ("modules/lang/org/autoload/*.el")
;;              )
;;   :bind (:map org-mode-map
;;               ("RET" . +org/dwim-at-point))
;;   )

(use-package org 
  :diminish
  :straight org-plus-contrib
  :custom-face (org-ellipsis ((t (:foreground nil))))
  ;;;; bind
  :bind
  (
   :map org-mode-map
        ("M-k" . org-metaup)
        ("M-j" . org-metadown)
        ("M-h" . org-metaleft)
        ("M-l" . org-metaright)
        ("M-H" . org-shiftmetaleft)
        ("M-L" . org-shiftmetaright)
        ("RET" . weiss-org-RET-key)
        ("<shifttab>" . org-shifttab)

        ;; (defun evil-org--populate-navigation-bindings ()
        ;;   "Configures gj/gk/gh/gl for navigation."
        ;;   (let-alist evil-org-movement-bindings
        ;;     (evil-define-key 'motion evil-org-mode-map
        ;;                      (kbd (concat "g" .left)) 'org-up-element
        ;;                      (kbd (concat "g" .right)) 'org-down-element
        ;;                      (kbd (concat "g" .up)) 'org-backward-element
        ;;                      (kbd (concat "g" .down)) 'org-forward-element
        ;;                      (kbd (concat "g" (capitalize .left))) 'evil-org-top)))
        )
  ;;;; hook
  :hook ((org-mode . (lambda ()
                       (company-mode -1)
                       (linum-mode -1)
                       (display-line-numbers-mode nil)
                       (iimage-mode)
                       (diminish 'iimage-mode)
                       (emojify-mode)
                       (make-local-variable 'shiftless-upper-rules)
                       (shiftless-Umlaut)
                       (make-local-variable 'display-line-numbers)
                       (visual-line-mode)
                       (diminish 'visual-line-mode)
                       (setq
                        display-line-numbers 'nil)
                       ;; (let ((current-prefix-arg '(16)))
                       ;;   (call-interactively 'org-latex-preview)
                       ;;   )
                       
                       "Beautify org symbols."

                       ;; (push '("[ ]" . ?☐) prettify-symbols-alist)
                       ;; (push '("[X]" . ?☑) prettify-symbols-alist)
                       ;; (push '("[-]" . ?⛝) prettify-symbols-alist)

                       (push '("#+ARCHIVE:" . ?📦) prettify-symbols-alist)
                       (push '("#+AUTHOR:" . ?👤) prettify-symbols-alist)
                       (push '("#+CREATOR:" . ?💁) prettify-symbols-alist)
                       (push '("#+DATE:" . ?📆) prettify-symbols-alist)
                       (push '("#+DESCRIPTION:" . ?⸙) prettify-symbols-alist)
                       (push '("#+EMAIL:" . ?🖂) prettify-symbols-alist)
                       (push '("#+OPTIONS:" . ?⛭) prettify-symbols-alist)
                       (push '("#+SETUPFILE:" . ?⛮) prettify-symbols-alist)
                       (push '("#+TAGS:" . ?🏷) prettify-symbols-alist)
                       (push '("#+TITLE:" . ?🕮) prettify-symbols-alist)

                       (push '("#+BEGIN_SRC" . ?✎) prettify-symbols-alist)
                       (push '("#+begin_src" . ?✎) prettify-symbols-alist)
                       (push '("#+END_SRC" . ?⬝) prettify-symbols-alist)
                       (push '("#+end_src" . ?⬝) prettify-symbols-alist)
                       (push '("#+BEGIN_QUOTE" . ?») prettify-symbols-alist)
                       (push '("#+END_QUOTE" . ?«) prettify-symbols-alist)
                       (push '("#+HEADERS" . ?☰) prettify-symbols-alist)
                       (push '("#+RESULTS:" . ?💻) prettify-symbols-alist)

                       (prettify-symbols-mode 1)))

         (org-indent-mode . (lambda()
                              (diminish 'org-indent-mode)
                              ;; WORKAROUND: Prevent text moving around while using brackets
                              ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                              (make-variable-buffer-local 'show-paren-mode)
                              (setq show-paren-mode nil))))
  
  
  ;;;; init
:init

(provide 'org-version)

(define-prefix-command 'weiss-org-xfk-g-keymap)

(defun weiss-org-command-mode-define-keys ()
  (define-key xah-fly-key-map (kbd "g") weiss-org-xfk-g-keymap)
  (weiss--define-keys
   xah-fly-key-map
   '(
     ;; ("~" . nil)
     ;; (":" . nil)

     ;; ("SPC" . xah-fly-leader-key-map)
     ;; ("DEL" . xah-fly-leader-key-map)
     ;; ("RET" . +org/dwim-at-point)

     ;; ("'" . xah-cycle-hyphen-underscore-space)
     ;; ("," . weiss-switch-frame-and-refresh-xfk)
     ;; ("-" . xah-backward-punct)
     ;; ("." . xah-forward-right-bracket)
     ;; (";" . xah-end-of-line-or-block)
     ;; ("/" . xah-goto-matching-bracket)
     ;; ("\\" . nil)
     ;; ("=" . xah-forward-equal-sign)
     ;; ("[" . hippie-expand )
     ;; ("]" . nil)
     ;; ("`" . other-frame)

     ("<backtab>" . org-shifttab)
     ;; ("V" . weiss-paste-with-linebreak)
     ("!" . rotate-text)
     ;; ("#" . xah-backward-quote)
     ;; ("$" . xah-forward-punct)

     ;; ("1" . scroll-down)
     ;; ("2" . scroll-up)
     ;; ("3" . delete-other-windows)
     ;; ("4" . split-window-below)
     ;; ("5" . delete-char)
     ;; ("6" . xah-select-block)
     ;; ("7" . xah-select-line)
     ;; ("8" . xah-extend-selection)
     ;; ("9" . xah-select-text-in-quote)
     ;; ("0" . xah-pop-local-mark-ring)

     ("a" . open-line)
     ;; ("b" . xah-toggle-letter-case)
     ;; ("c" . xah-copy-line-or-region)
     ("C" . org-copy-subtree)
     ;; ("d" . xah-delete-backward-char-or-bracket-text)
     ;; ("e" . xah-backward-kill-word)
     ;; ("f" . xah-fly-insert-mode-activate)
     ;; ("g" . weiss-xfk-g-keymap)
     ;; ("h" . backward-char)
     ;; ("i" . xah-beginning-of-line-or-block)
     ;; ("j" . next-line)
     ;; ("k" . previous-line)
     ;; ("l" . xah-fly-insert-mode-activate-space-before)
     ;; ("l" . forward-char)
     ;; ("m" . xah-backward-left-bracket)
     ;; ("n" . swiper-isearch)
     ;; ("o" . forward-word)
     ;; ("p" . weiss-insert-line)
     ;; ("q" . xah-reformat-lines)
     ;; ("r" . xah-kill-word)
     ;; ("s" . open-line)
     ;; ("t" . set-mark-command)
     ;; ("u" . backward-word)
     ;; ("v" . xah-paste-or-paste-previous)
     ;; ("w" . xah-shrink-whitespaces)
     ("x" . org-kill-line)
     ("X" . org-refile)
     ;; ("y" . undo)
     ;; ("z" . xah-comment-dwim)
     )))

(weiss--define-keys
 weiss-org-xfk-g-keymap
 '(
   ("h" . org-up-element)
   ("l" . org-down-element)
   ("k" . org-backward-element)
   ("j" . org-forward-element)

   ("t" . org-set-tags-command)
   ("q" . org-todo)
   )
 )

(defun weiss-org-RET-key ()
  (interactive)
  (if xah-fly-insert-state-q
      (org-return)
    (+org/dwim-at-point))
  )

(defun weiss-switch-and-Bookmarks-search()
  (interactive)
  (find-file "~/Documents/Org/Einsammlung.org")
  (org-agenda nil "b")
  )

;; (defun weiss-show-the-days-of-the-week()
;; )

;; (autoload '+org/dwim-at-point "+org" nil t)
;; (bind-key "RET" #'+org/dwim-at-point org-mode-map)
(setq
 org-directory "~/Documents/Org/"
 org-agenda-files '("/home/weiss/Documents/Org/todo.org")
 org-agenda-prefix-format "%t %s "     ;hide files name
 org-todo-keywords '((sequence "INPROGRESS(i)" "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c@)"))
 ;; (sequence "⚑(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
 org-cycle-max-level 15
 org-agenda-skip-scheduled-if-done t
 org-hide-leading-stars t
 org-hide-leading-stars-before-indent-mode t
 org-list-description-max-indent 4
 org-startup-indented t
 org-log-done 'time
 org-fast-tag-selection-single-key t
 org-agenda-include-diary t
 org-agenda-window-setup 'current-window

 org-refile-targets (quote (("Kenntnisse.org" :level . 1)
                            ("todo.org" :maxlevel . 2)
                            ("Vorlesungen.org" :maxlevel . 2)
                            ("Einsammlung.org" :maxlevel . 2)
                            ))
 org-agenda-custom-commands
 '(
   ("c" "Custom agenda"
    ((agenda ""))
    (
     ;; (org-agenda-tag-filter-preset '("+dailyagenda"))
     (org-agenda-hide-tags-regexp (concat org-agenda-hide-tags-regexp "\\|dailyagenda"))
     (org-agenda-span 20)
     ))
   ("b" occur-tree "Bookmarks")
   )
 org-link-frame-setup
 '(
   (vm . vm-visit-folder)
   (vm-imap . vm-visit-imap-folder)
   (gnus . gnus)
   (file . find-file)
   (wl . wl-frame)
   )
 org-tags-column -80
 org-log-done 'time
 org-catch-invisible-edits 'smart
 org-fontify-done-headline t
 org-agenda-compact-blocks t
 org-image-actual-width '(600)
 org-capture-templates   '(("o" "org-noter" entry (file "~/Documents/Org/Vorlesungen.org")
                            "* %f \n :PROPERTIES: \n :NOTER_DOCUMENT: %F \n :END: \n [[%F][Filepath]]")
                           )
 org-ellipsis (if (char-displayable-p ?) "  " nil)
 org-pretty-entities nil
 org-hide-emphasis-markers t)         ; hide ** //

:config
;; (add-to-list 'org-tag-faces
;; '("Frage" . (:foreground "tomato")))
(font-lock-add-keywords 'org-mode
                        '(("^.*:Frage:.*$" 0 'font-lock-keyword-face)))
(add-to-list 'org-tag-faces '("Frage" . (:foreground "red"  :weight bold)))
(set-face-attribute 'bold nil
                    :weight 'bold
                    :underline 'nil
                    :foreground "#f5355e"
                    :background nil)
(set-face-attribute 'italic nil
                    :weight 'normal
                    :underline 'nil
                    :slant 'italic
                    :height 0.9
                    :foreground "#606060"
                    :background nil)
(set-face-attribute 'org-link nil
                    :weight 'normal
                    :underline 'nil
                    :foreground "#20B2AA"
                    :background nil)
(set-face-attribute 'org-block-begin-line nil
                    :weight 'normal
                    :slant 'italic
                    :underline 'nil
                    :foreground "#999999"
                    :background nil)
(set-face-attribute 'org-block nil
                    :background "#fafafa")
(set-face-attribute 'org-headline-done nil
                    :strike-through t
                    :weight 'normal)
(set-face-attribute 'org-level-1 nil
                    :height 1.2
                    :foreground "#ff5a19"
                    :weight 'bold)
(set-face-attribute 'org-level-2 nil
                    :height 1.1
                    :foreground "#040404"
                    :weight 'normal)
(set-face-attribute 'org-level-3 nil
                    :height 1.0
                    :foreground "#040404"
                    :weight 'normal)
(set-face-attribute 'org-level-4 nil
                    :height 1.0
                    :foreground "#040404"
                    :weight 'normal)
(set-face-attribute 'org-level-5 nil
                    :height 1.0
                    :foreground "#040404"
                    :weight 'normal)
(set-face-attribute 'org-level-6 nil
                    :height 1.0
                    :foreground "#040404"
                    :weight 'normal)
(set-face-attribute 'org-level-7 nil
                    :height 1.0
                    :foreground "#040404"
                    :weight 'normal)
(set-face-attribute 'org-level-8 nil
                    :height 1.0
                    :foreground "#040404"
                    :weight 'normal)

(defun weiss-org-archive()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'org-archive-subtree)
  )

(defun weiss-org-latex-preview-all()
  (interactive)
  (setq current-prefix-arg '(16))
  (call-interactively 'org-latex-preview)
  )

(defun weiss-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  ;; (setq filename
  ;;       (concat
  ;;        (make-temp-name
  ;;         (concat (buffer-file-name)
  ;;                 "_"
  ;;                 (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (setq pathFileName
        (concat "./Bilder/"
                (concat
                 (make-temp-name
                  (concat (buffer-name)
                          "_"
                          (format-time-string "%Y%m%d_%H%M%S_")) ) ".png")
                )
        )
  (call-process "import" nil nil nil pathFileName)
  (insert (concat "[[" pathFileName "]]"))
  (org-display-inline-images))

;;https://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it

(defun weiss-custom-daily-agenda()
  (interactive)
  (org-agenda nil "c")
  )
;; (getenv "PATH")

(use-package org-fancy-priorities 
  :diminish
  :after org
  :hook (org-mode . org-fancy-priorities-mode)
  :config

  (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")
        org-priority-faces '((65 :foreground "#de3d2f" :weight bold)
                             (66 :foreground "#da8548" :weight bold)
                             (67 :foreground "#0098dd"))

        ))

(use-package org-bullets 
  :diminish
  :after org
  :hook (org-mode . org-bullets-mode)
  :config
  (setq  org-bullets-bullet-list '("◉" "◆" "●" "◇" "○" "→" "·" ))
  ;; “♰” “☥” “✞” “✟” “✝” “†” “✠” “✚” “✜” “✛” “✢” “✣” “✤” “✥” “♱” "✙”  "◉"  "○" "✸" "✿" ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
  )

;; Enable markdown backend
(add-to-list 'org-export-backends 'md)

;; Babel
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

(defvar load-language-list '((emacs-lisp . t)
                             (perl . t)
                             (python . t)
                             (ruby . t)
                             (js . t)
                             (css . t)
                             (sass . t)
                             (C . t)
                             (java . t)
                             (plantuml . t)))

;; ob-sh renamed to ob-shell since 26.1.
(cl-pushnew '(shell . t) load-language-list)

(use-package ob-fsharp
  :init (cl-pushnew '(fsharp . t) load-language-list))

(use-package ob-javascript
  :straight (org-functions
             :type git
             :host github
             :repo "zweifisch/ob-javascript"
             )
  :init (cl-pushnew '(javascript . t) load-language-list))

(use-package ob-go
  :init (cl-pushnew '(go . t) load-language-list))

(use-package ob-rust
  :init (cl-pushnew '(rust . t) load-language-list))

(use-package ob-ipython
  :if (executable-find "jupyter")     ; DO NOT remove
  :init (cl-pushnew '(ipython . t) load-language-list))

(org-babel-do-load-languages 'org-babel-load-languages
                             load-language-list)

;; (use-package auctex)

;; Rich text clipboard
(use-package org-rich-yank 
  :diminish
  :bind (:map org-mode-map
              ("C-v" . org-rich-yank)))

;; ;; Table of contents
;; (use-package toc-org 
;; :diminish
;;   :hook (org-mode . toc-org-mode))

;; ;; Export text/html MIME emails
;; (use-package org-mime 
;; :diminish
;;   :bind (:map message-mode-map
;;               ("C-c M-o" . org-mime-htmlize)
;;               :map org-mode-map
;;               ("C-c M-o" . org-mime-org-buffer-htmlize)))

;; ;; Presentation
;; (use-package org-tree-slide 
;; :diminish
;;   :diminish
;;   :functions (org-display-inline-images
;;               org-remove-inline-images)
;;   :bind (:map org-mode-map
;;               ("C-<f7>" . org-tree-slide-mode)
;;               :map org-tree-slide-mode-map
;;               ("<left>" . org-tree-slide-move-previous-tree)
;;               ("<right>" . org-tree-slide-move-next-tree)
;;               ("S-SPC" . org-tree-slide-move-previous-tree)
;;               ("SPC" . org-tree-slide-move-next-tree))
;;   :hook ((org-tree-slide-play . (lambda ()
;;                                   (text-scale-increase 4)
;;                                   (org-display-inline-images)
;;                                   (read-only-mode 1)))
;;          (org-tree-slide-stop . (lambda ()
;;                                   (text-scale-increase 0)
;;                                   (org-remove-inline-images)
;;                                   (read-only-mode -1))))
;;   :config
;;   (org-tree-slide-simple-profile)
;;   (setq org-tree-slide-skip-outline-level 2))

;; ;; Pomodoro
;; (use-package org-pomodoro 
;; :diminish
;;   :custom-face
;;   (org-pomodoro-mode-line ((t (:inherit warning))))
;;   (org-pomodoro-mode-line-overtime ((t (:inherit error))))
;;   (org-pomodoro-mode-line-break ((t (:inherit success))))
;;   :bind (:map org-agenda-mode-map
;;               ("P" . org-pomodoro))))
(load "/home/weiss/.emacs.d/config/+org.el")
;; (bind-key "RET" #'+org/dwim-at-point org-mode-map)

)

;;;; org-hook
(defun weiss-org-option ()
(interactive)
(company-mode -1)
(linum-mode -1)
(display-line-numbers-mode nil)
(iimage-mode)
(emojify-mode)
(make-local-variable 'shiftless-upper-rules)
(shiftless-Umlaut)
(make-local-variable 'display-line-numbers)
(visual-line-mode)
(setq
 display-line-numbers 'nil)
;; (let ((current-prefix-arg '(16)))
;;   (call-interactively 'org-latex-preview)
;;   )
)
;; (add-hook 'org-mode-hook 'weiss-org-option)

(fset 'org-agenda-done
"td")
;;;; org-Keybinding
(with-eval-after-load 'org-agenda
(defun weiss-org-agenda-command-mode-define-keys ()
  (weiss--define-keys
   xah-fly-key-map
   '(
     ;; ("~" . nil)
     ;; (":" . nil)

     ;; ("SPC" . xah-fly-leader-key-map)
     ;; ("DEL" . xah-fly-leader-key-map)
     ;; ("RET" . +org/dwim-at-point)

     ;; ("'" . xah-cycle-hyphen-underscore-space)
     ;; ("," . xah-next-window-or-frame)
     ;; ("." . xah-forward-right-bracket)
     ;; (";" . xah-end-of-line-or-block)
     ;; ("/" . xah-goto-matching-bracket)
     ;; ("\\" . nil)
     ("-" . xah-backward-punct)
     ("=" . xah-forward-punct)
     ;; ("[" . hippie-expand )
     ;; ("]" . nil)
     ;; ("`" . other-frame)

     ;; ("<backtab>" . org-shifttab)
     ;; ("V" . weiss-paste-with-linebreak)
     ;; ("!" . rotate-text)
     ;; ("#" . xah-backward-quote)
     ;; ("$" . xah-forward-punct)

     ;; ("1" . scroll-down)
     ;; ("2" . scroll-up)
     ;; ("3" . delete-other-windows)
     ;; ("4" . split-window-below)
     ;; ("5" . delete-char)
     ;; ("6" . xah-select-block)
     ;; ("7" . xah-select-line)
     ;; ("8" . xah-extend-selection)
     ;; ("9" . xah-select-text-in-quote)
     ;; ("0" . xah-pop-local-mark-ring)

     ;; ("a" . new-line)
     ;; ("b" . xah-toggle-letter-case)
     ;; ("c" . xah-copy-line-or-region)
     ;; ("C" . org-copy-subtree)
     ("d" . org-agenda-done)
     ;; ("e" . xah-backward-kill-word)
     ;; ("f" . xah-fly-insert-mode-activate)
     ;; ("g" . weiss-xfk-g-keymap)
     ;; ("h" . backward-char)
     ;; ("i" . xah-beginning-of-line-or-block)
     ;; ("j" . next-line)
     ;; ("k" . previous-line)
     ;; ("l" . xah-fly-insert-mode-activate-space-before)
     ;; ("l" . forward-char)
     ;; ("m" . xah-backward-left-bracket)
     ;; ("n" . swiper-isearch)
     ;; ("o" . forward-word)
     ;; ("p" . weiss-insert-line)
     ("q" . org-agenda-exit)
     ("r" . org-agenda-redo)
     ;; ("s" . open-line)
     ("t" . org-agenda-todo)
     ;; ("u" . backward-word)
     ;; ("v" . xah-paste-or-paste-previous)
     ;; ("w" . xah-shrink-whitespaces)
     ;; ("x" . org-kill-line)
     ;; ("y" . undo)
     ;; ("z" . xah-comment-dwim)
     )))
)

;;;; package
(use-package org-tempo ; for <s expand in org-babel 
  :diminish
  :after org
  :straight nil
  :config
  (add-to-list 'org-structure-template-alist '("le" . "src elisp"))
  (add-to-list 'org-structure-template-alist '("lp" . "src python"))
  (add-to-list 'org-structure-template-alist '("lh" . "src html"))
  )


(use-package cdlatex 
  :diminish
  ;; :disabled
  :after org
  :init
  (plist-put org-format-latex-options :scale 1.5)
  (setq cdlatex-math-symbol-alist '(
                                    ( ?v  ("\\vee"   "\\vDash"         ))
                                    ( ?+  ("\\cup"   "\\equiv"         ))
                                    ( ?{  ("\\subset" "\\subseteq"        ))
                                    ( ?}  ("\\supset"  "\\supseteq"       ))
                                    )
        ))

(provide 'weiss_org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; weiss_org.el ends here
