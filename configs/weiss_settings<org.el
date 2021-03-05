(defvar weiss/org-file-path "/home/weiss/Documents/OrgFiles/")
(defvar weiss/org-img-path "/home/weiss/Documents/OrgFiles/Bilder/")
(defun weiss--get-org-file-path (path)
  "get org-file path according to weiss/org-file-path"
  (interactive)
  (concat weiss/org-file-path path)
  )

(setq
 org-directory weiss/org-file-path
 org-extend-today-until 4
 org-cycle-max-level 15
 org-catch-invisible-edits 'smart
 )


(provide 'weiss_settings<org)
