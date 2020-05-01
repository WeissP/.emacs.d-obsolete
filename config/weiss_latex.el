;; init-latex.el -*- lexical-binding: t -*-

(require 'org)

(add-to-list 'load-language-list '(latex . t))

(use-package company-auctex
  :hook (LaTeX-mode-hook)
  :config
  (company-auctex-init))

(use-package auc-tikz
  :disabled
  :quelpa (auc-tikz
           :fetcher github
           :repo blerner/auc-tikz
           ))
;; (setq TeX-global-PDF-mode t TeX-engine 'xetex)
;; (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
;; (setq TeX-command-default "XeLaTeX")

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
  )

(use-package org-edit-latex
  ;; :disabled
  :quelpa (org-edit-latex :fetcher github
                          :repo "et2010/org-edit-latex"))

(plist-put org-format-latex-options :scale 1.5)

;; (use-package auctex
;; :disabled
;; :quelpa (auctex)
;; :ensure t 
;; )
;; (require 'auctex)

(use-package webkit-katex-render
  :disabled
  :quelpa (webkit-katex-render :fetcher github
                               :repo "fuxialexander/emacs-webkit-katex-render")
  :init
  (setq webkit-katex-render--background-color "#0098dd"))

(use-package magic-latex-buffer
  :hook (latex-mode-hook)
  )

(use-package cdlatex
  :diminish
  ;; :disabled
  ;; :after org
  ;; :hook ((LaTeX-mode . turn-on-cdlatex) ; with AUCTeX latex mode
  ;;        (latex-mode . turn-on-cdlatex)) ; with emacs latex mode
  :init
  ;; (setq cdlatex-math-modify-prefix ?!)
  (setq cdlatex-math-symbol-alist '(
                                    ( ?v  ("\\vee"   "\\vDash"         ))
                                    ( ?+  ("\\cup"   "\\equiv"         ))
                                    ( ?{  ("\\subset" "\\subseteq"        ))
                                    ( ?}  ("\\supset"  "\\supseteq"       ))
                                    )
        ))

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(require 'weiss-symbols-input)

(defun weiss-latex-command-mode-define-keys ()
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

     ;; ("a" . open-line)
     ;; ("b" . xah-toggle-letter-case)
     ;; ("c" . xah-copy-line-or-region)
     ;; ("C" . org-copy-subtree)
     ;; ("d" . weiss-org-cut-line-or-delete-region)
     ;; ("e" . xah-backward-kill-word)
     ;; ("f" . xah-fly-insert-mode-activate)
     ;; ("g" . weiss-xfk-g-keymap)
     ;; ("h" . backward-char)
     ;; ("i" . previous-line)
     ;; ("j" . next-line)
     ;; ("k" . previous-line)
     ;; ("l" . xah-fly-insert-mode-activate-space-before)
     ;; ("l" . forward-char)
     ;; ("m" . xah-backward-left-bracket)
     ;; ("n" . swiper-isearch)
     ;; ("o" . forward-word)
     ;; ("p" . weiss-insert-)
     ;; ("q" . xah-reformat-lines)
     ;; ("r" . xah-kill-word)
     ;; ("s" . open-line)
     ;; ("t" . set-mark-command)
     ("u" . weiss-org-preview-latex-and-image)
     ;; ("v" . xah-paste-or-paste-previous)
     ;; ("w" . xah-shrink-whitespaces)
     ;; ("x" . org-kill-line)
     ;; ("X" . org-refile)
     ;; ("y" . undo)
     ;; ("z" . xah-comment-dwim)
     )))
(provide 'weiss_latex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; weiss_latex.el ends here
