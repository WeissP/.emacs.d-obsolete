(define-prefix-command 'wks-org-quick-insert-keymap)

(wks-define-key
 wks-org-quick-insert-keymap ""
 '(
   ("=" . (weiss-org-babel-insert-c++ (weiss-insert-pair "#+begin_src c++" "#+end_src" t)))
   ("c" . (weiss-org-babel-insert-conf (weiss-insert-pair "#+begin_src c" "#+end_src" t)))
   ("e" . (weiss-org-babel-insert-elisp (weiss-insert-pair "#+begin_src elisp" "#+end_src" t)))
   ("g" . (weiss-org-babel-insert-go (weiss-insert-pair "#+begin_src go" "#+end_src" t)))
   ("h" . (weiss-org-babel-insert-haskell (weiss-insert-pair "#+begin_src haskell" "#+end_src" t)))
   ("j" . (weiss-org-babel-insert-java (weiss-insert-pair "#+begin_src java" "#+end_src" t)))
   ("l" . (weiss-org-babel-insert-latex (weiss-insert-pair "#+begin_src latex" "#+end_src" t)))
   ("p" . (weiss-org-babel-insert-python (weiss-insert-pair "#+begin_src python" "#+end_src" t)))
   ("q" . (weiss-org-babel-insert-sql (weiss-insert-pair "#+begin_src sql" "#+end_src" t)))
   ("r" . (weiss-org-babel-insert-r (weiss-insert-pair "#+begin_src R" "#+end_src" t)))
   ("s" . (weiss-org-babel-insert-sh (weiss-insert-pair "#+begin_src sh" "#+end_src" t)))
   ("RET" . (weiss-org-latex-insert-newline (insert "$\\\\$\n")))
   ;; ("c" . (weiss-org-latex-insert-color (weiss-insert-pair "$\\color{code}\\texttt{" "}$" nil)))
   )
 )

(provide 'weiss_quick-insert<org)
