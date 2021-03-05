(with-eval-after-load 'org
  (fset 'org-agenda-done "td")

  (define-key org-mode-map (kbd "M-i") #'org-shiftmetaleft)
  (define-key org-mode-map (kbd "M-k") #'org-metaup)
  (define-key org-mode-map (kbd "M-j") #'org-metadown)
  (define-key org-mode-map (kbd "M-l") #'org-shiftmetaright)
  (define-key org-mode-map (kbd "M-o") #'org-metaleft)
  (define-key org-mode-map (kbd "M-p") #'org-metaright)
  (define-key org-mode-map (kbd "M-p") #'org-metaright)

  (ryo-modal-keys
   (:mode 'org-mode)
   ("<shifttab>" org-shifttab)
   ("5" +org/dwim-at-point)
   ("6" org-insert-heading-respect-content)
   ("8" org-export-dispatch)
   ("C" org-copy-subtree)
   ("d" weiss-org-cut-line-or-delete-region)
   ("j" next-line :first '(deactivate-mark))
   ("k" previous-line :first '(deactivate-mark))
   ("u" weiss-org-preview-latex-and-image)
   ("n" weiss-org-search)
   ("x" weiss-org-exchange-point-or-switch-to-sp)
   ("X" org-refile)
   ("t" (
         ("a" weiss-org-screenshot)
         ("o" org-noter)
         ("d" weiss-org-download-img)
         ("q" weiss-set-org-tags)
         ("s" org-noter-sync-current-note)
         ("t" org-todo)
         ("b" org-mark-ring-goto)
         ("j s" weiss-org-copy-heading-link)
         ))
   ("<escape> o" (
                  ("e"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src elisp" "#+end_src" t)))
                   :name "elisp babel")
                  ("="
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src c++" "#+end_src" t)))
                   :name "c++ babel")
                  ("p"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src python" "#+end_src" t)))
                   :name "python babel")
                  ("l"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src latex" "#+end_src" t)))
                   :name "latex babel")
                  ("j"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src java" "#+end_src" t)))
                   :name "java babel")
                  ("g"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src go" "#+end_src" t)))
                   :name "golang babel")
                  ("s"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src sh" "#+end_src" t)))
                   :name "sh babel")
                  ("h"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src html" "#+end_src" t)))
                   :name "html babel")
                  ("r"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src R" "#+end_src" t)))
                   :name "R babel")
                  ("c"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src conf" "#+end_src" t)))
                   :name "conf babel")
                  ("q"
                   ignore
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src sql" "#+end_src" t)))
                   :name "sql babel")
                  )
    )
   ("<escape> <escape>" (
                         ("RET"
                          ignore
                          :then ((lambda () (insert "$\\\\$\n")))
                          :name "latex new line")
                         ("s"
                          ignore
                          :then ((lambda ()(weiss-insert-bracket-pair "\\begin{right_indent}" "\\end{right_indent}" t)))
                          :name "add subs")
                         ("c"
                          ignore
                          :then ((lambda ()(weiss-insert-bracket-pair "$\\color{code}\\texttt{" "}$" nil)))
                          :name "add color")

                         ))
   )

  (ryo-modal-keys
   (:mode 'org-agenda-mode)
   ("-" xah-backward-punct)
   ("=" xah-forward-punct)
   ;; ("d" org-agenda-done)
   ;; ("q" org-agenda-exit)
   ;; ("r" org-agenda-redo)
   ;; ("t" org-agenda-todo)
   )
  )

(provide 'weiss_keybindings<org)
