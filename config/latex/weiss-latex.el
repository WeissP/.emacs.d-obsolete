;; -*- lexical-binding: t -*-
;; general

;; [[file:~/.emacs.d/config/emacs-config.org::*general][general:1]]
(require 'org)
(require 'latex)

(add-to-list 'load-language-list '(latex . t))
;; general:1 ends here

;; packages

;; [[file:~/.emacs.d/config/emacs-config.org::*packages][packages:1]]
(use-package company-auctex
  :hook (LaTeX-mode-hook)
  :config
  (company-auctex-init))

(require 'ox-enumerate-latex) ;; for export

(use-package org-edit-latex
  ;; :disabled
  :ensure nil
  :load-path "/home/weiss/.emacs.d/local-package/"
  ;; :quelpa (org-edit-latex :fetcher github
  ;; :repo "et2010/org-edit-latex")
  :hook (org-mode . org-edit-latex-mode)
  ;; :config
  ;; (setq org-edit-latex-inline-beg-regexp ".* $^")
  )

(use-package magic-latex-buffer
  ;; :disabled
  ;; cool style
  ;; :hook ((LaTeX-mode . magic-latex-buffer)
  ;; (latex-mode . magic-latex-buffer))
  )
;; packages:1 ends here

;; functions

;; [[file:~/.emacs.d/config/emacs-config.org::*functions][functions:1]]
(defun weiss-add-enumerate-to-all-headlines ()
  "DOCSTRING"
  (interactive)
  (beginning-of-buffer)
  (while (not (eq (point) (point-max)))
    (org-next-visible-heading 1)
    (org-set-tags ":enumerate:"))  
  )

(defun weiss-export-pdf-dwim ()
  "DOCSTRING"
  (interactive)
  (let ((current-frame (get-frame-name)))
    (if (string= current-frame "PDF-Export") 
        (org-latex-export-to-pdf-enumerate)    
      (org-latex-export-to-pdf-enumerate-new-frame)  
      )
    ))

(defun weiss-latex-buffer-preview ()
  "If current-prefix-arg then remove preview, else preview all"
  (interactive)
  (if current-prefix-arg
      (preview-clearout-buffer)
    (message "%s" "preview-buffer")
    (preview-buffer))
  ;; (let ((text (buffer-substring-no-properties 1 (min 100 (point-max)))))    
  ;;   (if t
  ;;       ;; (or (string-match "begin{tikzpicture}" text)
  ;;           ;; (string-match "begin{forest}" text))
  ;;       (let ((buffer-file-name nil))
  ;;         (if current-prefix-arg
  ;;             (preview-clearout-buffer)
  ;;           (message "%s" "preview-buffer")
  ;;           (preview-buffer)))
  ;;     (weiss-org-preview-latex-and-image)
  ;;     ))  
  )

(defun weiss-quick-add-latex-style-sout ()
  (interactive)
  (let ((region-string
         (if (use-region-p)
             (delete-and-extract-region (region-beginning) (region-end))
           (delete-and-extract-region (point) (+ 1 (point))))))
    (insert (format "$ \\sout{\\textrm{%s}} $" region-string))
    ))

(defun weiss--quick-add-latex-style (latex-style)
  "Quick add latex style"
  (interactive)
  (let ((region-string
         (if (use-region-p)
             (delete-and-extract-region (region-beginning) (region-end))
           (delete-and-extract-region (point) (+ 1 (point))))))
    (insert (format "\\%s{%s}" latex-style region-string))
    )
  )

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
;; functions:1 ends here

;; export

;; [[file:~/.emacs.d/config/emacs-config.org::*export][export:1]]
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
;; \\usepackage{arev}

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
\\setlist[itemize,3]{label=$\\diamond$}
\\setenumerate[1]{label=\\alph*)}
\\setenumerate[2]{label=\\roman*)}
[EXTRA]
"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
               ))



;; (setq org-latex-default-class "weiss-abgabe")
;; export:1 ends here

;; misc

;; [[file:~/.emacs.d/config/emacs-config.org::*misc][misc:1]]
;; for delete bracket
  (setq weiss-latex-special-markers '("$"))
  ;; Preview
  (setq org-latex-create-formula-image-program 'dvipng)
  (eval-after-load "preview"
    '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
    )
(plist-put org-format-latex-options :scale 1.5)
;; misc:1 ends here

;; keybinding

;; [[file:~/.emacs.d/config/emacs-config.org::*keybinding][keybinding:1]]
(ryo-modal-keys
 (:mode 'latex-mode)
 ("u" weiss-latex-buffer-preview)
 ("<escape> <escape>" (
                       ("i" ignore
                        :name ""
                        :then ((lambda()(weiss--quick-add-latex-style "")))
                        )
                       ;; ("t" ignore
                       ;;  :name "texttt"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "texttt")))
                       ;;  )
                       ;; ("b" ignore
                       ;;  :name "mathbb"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "mathbb")))
                       ;;  )
                       ;; ("r" ignore
                       ;;  :name "textrm"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "textrm")))
                       ;;  )
                       ;; ("s" ignore
                       ;;  :name "textsc"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "textsc")))
                       ;;  )
                       ;; ("u" ignore
                       ;;  :name "underline"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "underline")))
                       ;;  )
                       ;; ("f" ignore
                       ;;  :name "textbf"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "textbf")))
                       ;;  )
                       ;; ("h" ignore
                       ;;  :name "hat"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "hat")))
                       ;;  )
                       ;; ("c" ignore
                       ;;  :name "mathcal"
                       ;;  :then ((lambda()(weiss--quick-add-latex-style "mathcal")))
                       ;;  )
                       ;; ("-" weiss-quick-add-latex-style-sout
                       ;;  :name "sout")
                       )
  )
 )
;; keybinding:1 ends here

;; end

;; [[file:~/.emacs.d/config/emacs-config.org::*end][end:1]]
(provide 'weiss-latex)
;; end:1 ends here
