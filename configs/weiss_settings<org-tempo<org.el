(with-eval-after-load 'org-tempo
  (add-to-list 'org-structure-template-alist '("le" . "src elisp"))
  (add-to-list 'org-structure-template-alist '("lcp" . "src c++"))
  (add-to-list 'org-structure-template-alist '("lp" . "src python"))
  (add-to-list 'org-structure-template-alist '("ll" . "src latex"))
  (add-to-list 'org-structure-template-alist '("lj" . "src java"))
  (add-to-list 'org-structure-template-alist '("ls" . "src sh"))
  (add-to-list 'org-structure-template-alist '("lh" . "src html"))
  (add-to-list 'org-structure-template-alist '("lr" . "src R"))
  (add-to-list 'org-structure-template-alist '("lc" . "src conf"))
  (add-to-list 'org-structure-template-alist '("lq" . "src sql"))
  )

(provide 'weiss_settings<org-tempo<org)
