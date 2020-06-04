;; init-latex.el -*- lexical-binding: t -*-

(require 'org)
(require 'latex)

(add-to-list 'load-language-list '(latex . t))

(use-package company-auctex
  :hook (LaTeX-mode-hook)
  :config
  (company-auctex-init))

;;; edit
;;;; delete
(setq weiss-latex-special-markers '("$"))

(defun weiss-delete-backward-bracket-and-mark-bracket-text-latex-mode ()
  "DOCSTRING"
  (interactive)
  (cond
   ;; ((string= (char-to-string (char-before)) ">")  (delete-char -1))
   ((member (char-to-string (char-before)) weiss-latex-special-markers)
    (let ((before-point (point))
          (mark-point )
          (special-marker (char-to-string (char-before))))
      (delete-char -1)
      (when (string-match (regexp-opt (list special-marker)) (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        (if (member (char-to-string (char-before (- (point) 0))) (list " " "\n"))
            (progn (search-forward special-marker)
                   (delete-char -1)
                   (setq mark-point (- before-point 1))
                   )
          (search-backward special-marker)
          (delete-char 1)
          (setq mark-point (- before-point 2))
          )
        (push-mark mark-point)
        (setq mark-active t)
        (setq deactivate-mark nil)
        (exchange-point-and-mark)
        ))
    )
   ((member (char-to-string (char-before)) '("}" "{"))
    (if (member (char-to-string (char-before)) '("}"))
        (xah-delete-backward-bracket-text)
      (xah-delete-forward-bracket-text)
      )
    (let ((before-point (point))
          (before-char (char-before))
          )
      ;; if char-before is a-z or A-Z
      (when (or (and (> before-char 96) (< before-char 123)) (and (> before-char 64) (< before-char 91)))
        ;; 92 -> \
        (if (and (re-search-backward "[ {}+]") (eq (char-after (1+ (point))) 92))
            (kill-region (1+ (point)) before-point)
          (goto-char before-point)
          (when (eq (char-after (line-beginning-position)) 92) (kill-region (line-beginning-position) (point)))
          )
        )))
   (t (xah-delete-backward-char-or-bracket-text))
   )
  )

(defun weiss-delete-forward-bracket-and-mark-bracket-text-latex-mode ()
  "DOCSTRING"
  (interactive)
  (cond
   ;; ((string= (char-to-string (char-after)) ">")  (delete-char -1))
   ((member (char-to-string (char-after)) weiss-latex-special-markers)
    (let ((before-point (point))
          (mark-point )
          (special-marker (char-to-string (char-after))))
      (delete-char 1)
      (when (string-match (regexp-opt (list special-marker)) (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        (if (member (char-to-string (char-before (- (point) 0))) (list " " "\n"))
            (progn (search-forward special-marker)
                   (delete-char 1)
                   (setq mark-point (- before-point 1))
                   )
          (search-backward special-marker)
          (delete-char 1)
          (setq mark-point (- before-point 2))
          )
        (push-mark mark-point)
        (setq mark-active t)
        (setq deactivate-mark nil)
        (exchange-point-and-mark)
        ))
    )
   ((member (char-to-string (char-after)) '("}" "{"))
    (forward-char)
    (if (member (char-to-string (char-before)) '("}"))
        (xah-delete-backward-bracket-text)
      (xah-delete-forward-bracket-text)
      )
    (let ((before-point (point))
          (before-char (char-before))
          )
      ;; if char-after is a-z or A-Z
      (when (or (and (> before-char 96) (< before-char 123)) (and (> before-char 64) (< before-char 91)))
        ;; 92 -> \
        (if (and (re-search-backward "[ {}+]") (eq (char-after (1+ (point))) 92))
            (kill-region (1+ (point)) before-point)
          (goto-char before-point)
          (when (eq (char-after (line-beginning-position)) 92) (kill-region (line-beginning-position) (point)))
          )
        )))
   (t (xah-delete-forward-char-or-bracket-text))
   )
  )


;;;; quick input
(defun weiss--quick-add-latex-style (latex-style)
  "Quick add latex style"
  (interactive)
  (let ((region-string
         (if (use-region-p)
             (delete-and-extract-region (region-beginning) (region-end))
           (delete-and-extract-region (point) (+ 1 (point))))))
    (insert (format "\\%s{ %s }" latex-style region-string))
    )
  )

(defun weiss-quick-add-latex-style-it ()
  (interactive)
  (weiss--quick-add-latex-style "mathit")
  )
(defun weiss-quick-add-latex-style-bb ()
  (interactive)
  (weiss--quick-add-latex-style "mathbb")
  )
(defun weiss-quick-add-latex-style-cal ()
  (interactive)
  (weiss--quick-add-latex-style "mathcal")
  )
(defun weiss-quick-add-latex-style-rm ()
  (interactive)
  (weiss--quick-add-latex-style "textrm")
  )
(defun weiss-quick-add-latex-style-sc ()
  (interactive)
  (weiss--quick-add-latex-style "textsc")
  )
(defun weiss-quick-add-latex-style-hat ()
  (interactive)
  (weiss--quick-add-latex-style "hat")
  )
(defun weiss-quick-add-latex-style-bf ()
  (interactive)
  (weiss--quick-add-latex-style "textbf")
  )

(defun weiss-quick-add-latex-style-sout ()
  (interactive)
  (let ((region-string
         (if (use-region-p)
             (delete-and-extract-region (region-beginning) (region-end))
           (delete-and-extract-region (point) (+ 1 (point))))))
    (insert (format "$ \\sout{\\textrm{%s}} $" region-string))
    ))

(weiss--define-keys
 (define-prefix-command 'weiss-quick-add-latex-style-keymap)
 '(
   ("i" . weiss-quick-add-latex-style-it)
   ("b" . weiss-quick-add-latex-style-bb)
   ("r" . weiss-quick-add-latex-style-rm)
   ("s" . weiss-quick-add-latex-style-sc)
   ("f" . weiss-quick-add-latex-style-bf)
   ("h" . weiss-quick-add-latex-style-hat)
   ("c" . weiss-quick-add-latex-style-cal)
   ("-" . weiss-quick-add-latex-style-sout)
   ))

(defun call-keymap (map &optional prompt)
  "Read a key sequence and call the command it's bound to in MAP."
  ;; Note: MAP must be a symbol so we can trick `describe-bindings' into giving
  ;; us a nice help text.
  (let* ((overriding-local-map `(keymap (,map . ,map)))
         (help-form `(describe-bindings ,(vector map)))
         (key (read-key-sequence prompt))
         (cmd (lookup-key map key t)))
    (if (functionp cmd) (call-interactively cmd)
      (user-error "%s is undefined" key))))

(defun weiss-insert-latex-dwim ()
  "If command mode, then add latex style or structure, else expand abbrevs"
  (interactive)
  (if (xah-command-mode-p)
      (call-keymap 'weiss-quick-add-latex-style-keymap "add-latex")
    (weiss-symbols-input-change-to-symbol)
    )
  )

(use-package cdlatex
  :diminish
  :disabled
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

(require 'weiss-symbols-input)

;;; keybinding
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
     ("u" . weiss-latex-buffer-preview)
     ;; ("v" . xah-paste-or-paste-previous)
     ;; ("w" . xah-shrink-whitespaces)
     ;; ("x" . org-kill-line)
     ;; ("X" . org-refile)
     ;; ("y" . undo)
     ;; ("z" . xah-comment-dwim)
     )))

;;; Preview
(defun weiss-latex-buffer-preview ()
  "If current-prefix-arg then remove preview, else preview all"
  (interactive)
  (let ((text (buffer-substring-no-properties 1 (min 100 (point-max)))))    
    (if (or (string-match "begin{tikzpicture}" text)
            (string-match "begin{forest}" text))
        (let ((buffer-file-name nil))
          (if current-prefix-arg
              (preview-clearout-buffer)
            (preview-buffer)))
      (weiss-org-preview-latex-and-image)
      ))
  
  )

(setq org-latex-create-formula-image-program 'imagemagick)

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
  )

(use-package org-edit-latex
  :disabled
  :ensure nil
  :load-path "/home/weiss/.emacs.d/local-package/"
  ;; :quelpa (org-edit-latex :fetcher github
  ;; :repo "et2010/org-edit-latex")
  :hook (org-mode . org-edit-latex-mode)
  ;; :config
  ;; (setq org-edit-latex-inline-beg-regexp ".* $^")
  )

(plist-put org-format-latex-options :scale 1.5)

(use-package magic-latex-buffer
  ;; :disabled
  ;; cool style
  ;; :hook ((LaTeX-mode . magic-latex-buffer)
  ;; (latex-mode . magic-latex-buffer))
  )



;;; Export
(defun weiss-add-enumerate-to-all-headlines ()
  "DOCSTRING"
  (interactive)
  (beginning-of-buffer)
  (while (not (eq (point) (point-max)))
    (org-next-visible-heading 1)
    (org-set-tags ":enumerate:"))  
  )


;; (require 'ox-enumerate-latex)
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))

(setq
 org-export-headline-levels 1
 org-export-with-tags nil
 org-latex-listings 'minted
 org-latex-pdf-process
 '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
   "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
 )

(add-to-list 'org-latex-packages-alist '("" "minted" t))
(add-to-list 'org-latex-packages-alist '("" "tikz" t))

(add-to-list 'org-latex-classes
             '("weiss-abgabe"
               "\\documentclass{article}

[PACKAGES]
\\usepackage[table]{xcolor}
\\usepackage{ifsym}
\\setminted[]{tabsize=2, breaklines=true, linenos=true}
\\setlength\\parindent{0pt}
\\usepackage{fontawesome}
\\usepackage{enumitem}
\\usepackage{forest}
\\usepackage{tikz}
\\usetikzlibrary{automata,arrows}
\\setlist[itemize,2]{label=$\\circ$}
\\setlist[itemize,3]{label=-}
[EXTRA]
"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
               ))



(setq org-latex-default-class "weiss-abgabe")

;; (add-to-list 'org-export-backends 'enumerate-latex nil #'eq)

;; (setq org-export-backends '(enumerate-latex))







(provide 'weiss_latex)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; weiss_latex.el ends here
