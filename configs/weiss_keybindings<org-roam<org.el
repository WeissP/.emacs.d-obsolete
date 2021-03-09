(with-eval-after-load 'org-roam
  (wks-define-key
   org-mode-map "t "
   '(
     ("i" . org-roam-insert)
     ("r" . org-roam)
     ("j t" . org-roam-tag-add)
     ("j n" . org-roam-capture)
     ("j f" . weiss-roam-add-focusing-tag)
     ("s" . weiss-org-roam-copy-heading-link)
     )
   ))

(provide 'weiss_keybindings<org-roam<org)
