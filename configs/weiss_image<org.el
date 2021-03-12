(with-eval-after-load 'org
  (defun weiss-org-screenshot ()
    "call flameshot to capture screen shot"
    (interactive)
    (weiss-org-insert-image
     "flameshot-caputre.png"
     (concat "flameshot gui -p " weiss/org-img-path)
     t)
    )

  (defun weiss-org-download-img ()
    "download the img link from clipboard"
    (interactive)
    (weiss-org-insert-image
     "wget-img.png"
     (format "wget -O %swget-img.png %s" weiss/org-img-path (substring-no-properties (gui-get-selection 'CLIPBOARD (or x-select-request-type 'UTF8_STRING))))
     t)    
    )
  ;; flameshot-caputre.png
  (defun weiss-org-insert-image (pic-name command &optional img-attr)
    "insert image to org"
    (interactive)
    (let* ((path weiss/org-img-path)
           (name (format "%s.png" (format-time-string "%Y-%m-%d_%H-%M-%S")))
           (old-name (concat path pic-name))
           (new-name (concat path name))
           )
      (when (file-exists-p old-name)
        (delete-file old-name)
        )
      (shell-command-to-string command)
      (while (not (file-exists-p old-name))
        (sit-for 0.1)
        )
      (rename-file old-name new-name)
      (end-of-line)
      (insert "\n")
      (when img-attr
        (insert "#+ATTR_org: :width 600\n")
        )
      (insert (concat "[[" new-name  "]]"))
      )  
    (org-display-inline-images))
  )

(provide 'weiss_image<org)
