(defun weiss-export-pdf-dwim ()
  "DOCSTRING"
  (interactive)
  (let ((current-frame (get-frame-name)))
    (if (string= current-frame "PDF-Export") 
        (org-latex-export-to-pdf-enumerate)    
      (org-latex-export-to-pdf-enumerate-new-frame)  
      )
    ))


(with-eval-after-load 'ox-latex
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
  )

(provide 'weiss_export<latex)
