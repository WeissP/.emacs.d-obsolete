(with-eval-after-load 'org-roam
  (add-hook 'after-init-hook 'org-roam-mode)

  (defun weiss-roam-add-focusing-tag ()
    "add focusing tag with quote"
    (interactive)
    (goto-char (point-min))
    (re-search-forward "#\\+roam_tags:")
    (insert " focusing" )
    )

  (defun weiss-org-roam-copy-heading-link (&optional without-asking)
    "copy the current heading link in roam format"
    (interactive)
    (if (string-prefix-p "Ʀ" (file-name-nondirectory (buffer-file-name))) 
        (let ((id (org-id-get-create))
              (title
               (if without-asking
                   (substring-no-properties (org-get-heading t t t t))
                 (read-string "Description: " (substring-no-properties (org-get-heading t t t t)))               
                 )
               )
              )
          (kill-new (format " [[id:%s][%s]]" id title))
          )
      (let* ((title (substring-no-properties (org-get-heading t t t t)))
             (des (read-string "Description: " title))
             )
        (kill-new (format "[[*%s][%s]]" title des))
        )
      )
    )
  )

(provide 'weiss_miscs<org-roam<org)
