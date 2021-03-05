(with-eval-after-load 'ryo-modal
  (with-eval-after-load 'org-roam
    (ryo-modal-keys
     (:mode 'org-mode)
     ("t i" org-roam-insert)
     ("t r" org-roam)
     ("t j"
      (
       ("t" org-roam-tag-add)
       ("n" org-roam-capture)
       ("f" weiss-roam-add-focusing-tag)
       ("s" weiss-org-roam-copy-heading-link)    
       ))
     )
    )
  )

(provide 'weiss_keybindings<org-roam<org)
