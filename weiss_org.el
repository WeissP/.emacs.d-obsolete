;; init-org.el --- Initialize org configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2006-2020 Vincent Zhang

;; Author: Vincent Zhang <seagle0128@gmail.com>
;; URL: https://github.com/seagle0128/.emacs.d

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Org configurations.
;;

;;; Code:

(use-package org
  :straight nil
  :custom-face (org-ellipsis ((t (:foreground nil))))

  ;; :bind (("C-c a" . org-agenda)
  ;;        ("C-c b" . org-switchb)
  ;;        :map org-mode-map
  ;;        ("<" . (lambda ()
  ;;                 "Insert org template."
  ;;                 (interactive)
  ;;                 (if (or (region-active-p) (looking-back "^\s*" 1))
  ;;                     (org-hydra/body)
  ;;                   (self-insert-command 1)))))

  :hook ((org-mode . (lambda ()
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
                       (push '("#+END_SRC" . ?□) prettify-symbols-alist)
                       (push '("#+BEGIN_QUOTE" . ?») prettify-symbols-alist)
                       (push '("#+END_QUOTE" . ?«) prettify-symbols-alist)
                       (push '("#+HEADERS" . ?☰) prettify-symbols-alist)
                       (push '("#+RESULTS:" . ?💻) prettify-symbols-alist)

                       (prettify-symbols-mode 1)))

         ;; (org-indent-mode . (lambda()
         ;;                      (diminish 'org-indent-mode)
         ;;                      ;; WORKAROUND: Prevent text moving around while using brackets
         ;;                      ;; @see https://github.com/seagle0128/.emacs.d/issues/88
         ;;                      (make-variable-buffer-local 'show-paren-mode)
         ;;                      (setq show-paren-mode nil))))
         )
  :init (setq
         org-directory "~/Documents/Org/"
         org-agenda-files (list org-directory)
         org-todo-keywords '((sequence "INPROGRESS(i)" "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c@)"))
         ;; (sequence "⚑(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
         org-cycle-max-level 15
         org-agenda-skip-scheduled-if-done t
         org-log-done 'time
         org-fast-tag-selection-single-key t
         org-agenda-include-diary t
         cdlatex-math-symbol-alist '(
                                     ( ?v  ("\\vee"   "\\vDash"         ))
                                     ( ?+  ("\\cup"   "\\equiv"         ))
                                     ( ?{  ("\\subset" "\\subseteq"        ))
                                     ( ?}  ("\\supset"  "\\supseteq"       ))
                                     )
         org-priority-faces '((65 :foreground "#de3d2f" :weight bold)
                              (66 :foreground "#da8548")
                              (67 :foreground "#0098dd"))
         org-agenda-custom-commands
         '(
           ("c" "Custom agenda"
            ((agenda ""))
            (
             (org-agenda-tag-filter-preset '("+dailyagenda"))
             (org-agenda-hide-tags-regexp (concat org-agenda-hide-tags-regexp "\\|dailyagenda"))
             (org-agenda-span 20)
             ))
           ("b" occur-tree "Bookmarks")
           )
         org-tags-column -80
         ;; org-log-done 'time
         org-catch-invisible-edits 'smart
         org-fontify-done-headline t
         org-agenda-compact-blocks t
         org-image-actual-width '(600)
         org-capture-templates   '(("o" "org-noter" entry (file "~/Documents/Org/Vorlesungen.org")
                                    "* %f \n :PROPERTIES: \n :NOTER_DOCUMENT: %F \n :END: \n [[%F][Filepath]]")
                                   )
         org-startup-indented t
         org-ellipsis (if (char-displayable-p ?) "  " nil)
         org-pretty-entities nil
         org-hide-emphasis-markers t)

  :config
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
                      :foreground "#c0c0c0"
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

  (use-package org-fancy-priorities
    :after org
    :hook (org-mode . org-fancy-priorities-mode)
    :config
    (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")))

  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    :config
    (setq  org-bullets-bullet-list '("◉" "◆" "●" "◇" "○" "→" "·" ))
;;; “♰” “☥” “✞” “✟” “✝” “†” “✠” “✚” “✜” “✛” “✢” “✣” “✤” “✥” “♱” "✙”  "◉"  "○" "✸" "✿" ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
    )

  ;; Enable markdown backend
  (add-to-list 'org-export-backends 'md)

  ;; ;; Babel
  ;; (setq org-confirm-babel-evaluate nil
  ;;       org-src-fontify-natively t
  ;;       org-src-tab-acts-natively t)

  ;; (defvar load-language-list '((emacs-lisp . t)
  ;;                              (perl . t)
  ;;                              (python . t)
  ;;                              (ruby . t)
  ;;                              (js . t)
  ;;                              (css . t)
  ;;                              (sass . t)
  ;;                              (C . t)
  ;;                              (java . t)
  ;;                              (plantuml . t)))

  ;; ;; ob-sh renamed to ob-shell since 26.1.
  ;; (cl-pushnew '(shell . t) load-language-list)

  ;; (use-package ob-go
  ;;   :init (cl-pushnew '(go . t) load-language-list))

  ;; (use-package ob-rust
  ;;   :init (cl-pushnew '(rust . t) load-language-list))

  ;; (use-package ob-ipython
  ;;   :if (executable-find "jupyter")     ; DO NOT remove
  ;;   :init (cl-pushnew '(ipython . t) load-language-list))

  ;; (org-babel-do-load-languages 'org-babel-load-languages
  ;;                              load-language-list)

  ;; Rich text clipboard
  (use-package org-rich-yank
    :bind (:map org-mode-map
                ("C-v" . org-rich-yank)))

  ;; ;; Table of contents
  ;; (use-package toc-org
  ;;   :hook (org-mode . toc-org-mode))

  ;; ;; Export text/html MIME emails
  ;; (use-package org-mime
  ;;   :bind (:map message-mode-map
  ;;               ("C-c M-o" . org-mime-htmlize)
  ;;               :map org-mode-map
  ;;               ("C-c M-o" . org-mime-org-buffer-htmlize)))

  ;; ;; Presentation
  ;; (use-package org-tree-slide
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
  ;;   :custom-face
  ;;   (org-pomodoro-mode-line ((t (:inherit warning))))
  ;;   (org-pomodoro-mode-line-overtime ((t (:inherit error))))
  ;;   (org-pomodoro-mode-line-break ((t (:inherit success))))
  ;;   :bind (:map org-agenda-mode-map
  ;;               ("P" . org-pomodoro))))
  )

(defun weiss-org-option ()
  (interactive)
  (company-mode -1)
  (linum-mode -1)
  (iimage-mode)
  (emojify-mode)
  (make-local-variable 'shiftless-upper-rules)
  (shiftless-Umlaut)
  (make-local-variable 'display-line-numbers)
  (setq
   display-line-numbers 'nil)
  ;; (let ((current-prefix-arg '(16)))
  ;;   (call-interactively 'org-latex-preview)
  ;;   )
  )
(add-hook 'org-mode-hook 'weiss-org-option)

(provide 'init-org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here
