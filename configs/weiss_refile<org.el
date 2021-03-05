(setq
 org-refile-targets
 `((,(weiss--get-org-file-path "Kenntnisse.org")   :level . 1)
   (,(weiss--get-org-file-path "todo.org"):maxlevel . 2)                            
   (,(weiss--get-org-file-path "Vorlesungen.org"):maxlevel . 2)
   (,(weiss--get-org-file-path "Einsammlung.org"):maxlevel . 2)
   (,(weiss--get-config-file-path "emacs-config.org"):maxlevel . 2)
   )

 org-refile-use-outline-path nil

 )

(with-eval-after-load 'org
  (defun weiss-org-refile (arg)
    "normally only refile current file, refile all files in org-refile-targets with current-prefix-arg"
    (interactive "p")
    (let ((current-prefix-arg))
      (if (eq arg 1)
          (weiss-org-refile-current-file)    
        (call-interactively #'org-refile)
        ) 
      )
    )

  (defun weiss-org-refile-current-file ()
    "only refile current file"
    (interactive)
    (let ((org-refile-targets `((,buffer-file-name :maxlevel . 4)))
          (org-refile-use-outline-path nil))
      (message "targets: %s" org-refile-targets)
      (call-interactively #'org-refile)
      )
    )
  )

(provide 'weiss_refile<org)
