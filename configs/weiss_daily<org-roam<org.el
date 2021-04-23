(with-eval-after-load 'org-roam
  (defun weiss-roam--add-to-today-daily (content state)
    "add `content'  to the `state' heading in today daily file"
    (let* ((filename (concat
                      org-roam-directory
                      org-roam-dailies-directory
                      "Ʀ"
                      (if (< (string-to-number (format-time-string "%H")) 4)
                          (format-time-string "d-%Y-%m-%d" (time-subtract (current-time) (* 24 3600)))                          
                        (format-time-string "d-%Y-%m-%d")
                        )
                      ".org"))
           (org-capture-templates
            `(("d" "done" entry (file+headline ,filename ,state)
               ,content))
            ))
      (org-capture nil (kbd "d"))
      ))

  (defun weiss-roam-copy-done-item-to-daily (change-plist)
    "add current the link of Done or Cancelled item to daily file"
    (interactive)
    (when (string-prefix-p "Ʀ" (file-name-nondirectory buffer-file-name))
      (let ((state (plist-get change-plist :to))
            )
        (when (or (string= state "DONE") (string= state "CANCELLED"))
          (weiss-roam--add-to-today-daily
           (concat "* " (weiss-org-roam-copy-heading-link t))
           (capitalize state))
          )      
        )
      )    
    )
  (add-hook 'org-trigger-hook 'weiss-roam-copy-done-item-to-daily)
  )

(provide 'weiss_daily<org-roam<org)
