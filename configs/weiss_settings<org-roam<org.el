(setq
 org-roam-tag-separator ";"
 org-roam-directory "~/Dropbox/Org-roam/"
 org-roam-dailies-directory "daily/"
 org-agenda-files `(,(concat org-roam-directory org-roam-dailies-directory))
 )

(with-eval-after-load 'org-roam
  (setq
   org-roam-db-update-idle-seconds 1
   org-roam-db-update-method 'immediate
   )
  )

(provide 'weiss_settings<org-roam<org)
