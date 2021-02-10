;; -*- lexical-binding: t -*-
;; general

;; [[file:../emacs-config.org::*general][general:1]]
(require 'org)
;; (require 'latex)
;; (use-package latex)

(add-to-list 'load-language-list '(latex . t))
;; general:1 ends here

;; packages

;; [[file:../emacs-config.org::*packages][packages:1]]
(use-package company-auctex
  :disabled
  :hook (LaTeX-mode-hook)
  :config
  (company-auctex-init))

;; (require 'ox-enumerate-latex) ;; for export

(use-package org-edit-latex
  ;; :disabled
  :ensure nil
  ;; :load-path "/home/weiss/.emacs.d/local-package/"
  ;; :quelpa (org-edit-latex :fetcher github
  ;; :repo "et2010/org-edit-latex")
  ;; :hook (org-mode . org-edit-latex-mode)
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

;; [[file:../emacs-config.org::*functions][functions:1]]
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
    (let ((text (buffer-substring-no-properties 1 (min 100 (point-max)))))    
      (if (or (string-match "begin{tikzpicture}" text)
              (string-match "begin{forest}" text))
          (let ((buffer-file-name nil))
            (if current-prefix-arg
                (preview-clearout-buffer)
              (message "%s" "preview-buffer")
              (preview-buffer)))
        (weiss-org-preview-latex-and-image)
        )))
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

;; [[file:../emacs-config.org::*export][export:1]]
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))

(setq
 org-export-headline-levels 5
 org-export-with-tags nil
 org-latex-listings 'minted
 org-latex-pdf-process
 '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
   "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
 LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)"))
 )
;; \\setlength\\parindent{0pt}
;; \usepackage{xcolor}
;; \definecolor{code}{HTML}{986801}
(add-to-list 'org-latex-packages-alist '("" "minted" t))

;; (add-to-list 'org-latex-packages-alist '("" "tikz" t))
;; ;; \\usepackage{arev}

(add-to-list 'org-latex-classes
             '("weiss-Paper"
               "\\documentclass[11pt]{report}

[PACKAGES]
\\makeatletter
\\setlength\\parindent{0pt}
\\usepackage[table]{xcolor}
\\usepackage{lipsum}
\\usepackage{ifsym}
\\usepackage{fontawesome}
\\usepackage{enumitem}
\\usepackage{changepage}
\\usepackage{inconsolata}
\\usepackage{xcolor}
\\definecolor{code}{HTML}{986801}
\\setminted[]{tabsize=2, breaklines=true, linenos=true}
\\newenvironment{right_indent}
  {\\begin{adjustwidth}{0.5cm}{0em}\\ }
  {\\end{adjustwidth}}
\\usepackage{titlesec}
\\titleformat{\\chapter}[display]   
{\\normalfont\\huge\\bfseries}{\\chaptertitlename\\ \\thechapter}{20pt}{\\Huge}   
\\titlespacing*{\\chapter}{0pt}{-15pt}{40pt}
\\renewcommand\\section{\\leftskip 0pt\\@startsection {section}{1}{\\z@}%
                                   {-3.5ex \\@plus -1ex \\@minus -.2ex}%
                                   {2.3ex \\@plus.2ex}%
                                   {\\normalfont\\Large\\bfseries}}%
\\renewcommand\\subsection{\\leftskip 0pt\\@startsection{subsection}{2}{\\z@}%
                                     {-3.25ex\\@plus -1ex \\@minus -.2ex}%
                                     {1.5ex \\@plus .2ex}%
                                     {\\normalfont\\large\\bfseries}}%

\\newcommand\\Xsubsection{\\@startsection{subsection}{8}{\\z@}%
                                     {-3.25ex\\@plus -1ex \\@minus -.2ex}%
                                     {1.5ex \\@plus .2ex}%
                                     {\\normalfont\\normalsize\\bfseries\\leftskip 3ex}}%
\\newcommand\\Xsubsubsection{\\@startsection{subsubsection}{8}{\\z@}%
                                     {-3.25ex\\@plus -1ex \\@minus -.2ex}%
                                     {1.5ex \\@plus .2ex}%
                                     {\\normalfont\\normalsize\\bfseries\\leftskip 6ex}}%

\\newcommand\\Mysubsection[1]{\\Xsubsection{#1}\\leftskip 4ex}
\\newcommand\\Mysubsubsection[1]{\\Xsubsubsection{#1}\\leftskip 7ex}
\\renewcommand{\\labelitemi}{$\\bullet$}
\\renewcommand{\\labelitemii}{$\\circ$}
\\renewcommand{\\labelitemiii}{$\\circ$}
\\renewcommand{\\labelitemiv}{$\\circ$}
[EXTRA]
"
               ;; ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\Mysubsection{%s}")
               ("\\subsubsection{%s}" . "\\Mysubsubsection{%s}")
               ("\\paragraph{%s}" . "\\paragraph{%s}")
               ))


;; (setq org-latex-default-class "weiss-abgabe")
;; export:1 ends here

;; misc

;; [[file:../emacs-config.org::*misc][misc:1]]
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

;; [[file:../emacs-config.org::*keybinding][keybinding:1]]
(ryo-modal-keys
 (:mode 'latex-mode)
 ("u" weiss-org-preview-latex-and-image)
 ("<escape> <escape>" (
                       ("i" ignore
                        :name "mathit"
                        :then ((lambda()(weiss--quick-add-latex-style "mathit")))
                        )
                       ("t" ignore
                        :name "texttt"
                        :then ((lambda()(weiss--quick-add-latex-style "texttt")))
                        )
                       ("b" ignore
                        :name "mathbb"
                        :then ((lambda()(weiss--quick-add-latex-style "mathbb")))
                        )
                       ("r" ignore
                        :name "textrm"
                        :then ((lambda()(weiss--quick-add-latex-style "textrm")))
                        )
                       ("s" ignore
                        :name "textsc"
                        :then ((lambda()(weiss--quick-add-latex-style "textsc")))
                        )
                       ("u" ignore
                        :name "underline"
                        :then ((lambda()(weiss--quick-add-latex-style "underline")))
                        )
                       ("f" ignore
                        :name "textbf"
                        :then ((lambda()(weiss--quick-add-latex-style "textbf")))
                        )
                       ("h" ignore
                        :name "hat"
                        :then ((lambda()(weiss--quick-add-latex-style "hat")))
                        )
                       ("c" ignore
                        :name "mathcal"
                        :then ((lambda()(weiss--quick-add-latex-style "mathcal")))
                        )
                       ("RET" ignore
                        :name "new line"
                        :then ((lambda()(weiss-insert-bracket-pair "&" "\\\\")))
                        )
                       ("-" weiss-quick-add-latex-style-sout
                        :name "sout")
                       )
  )
 )
;; keybinding:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-latex)
;; end:1 ends here
