(setq
 org-capture-templates   '(("o" "org-noter" entry (file "~/Documents/OrgFiles/Vorlesungen.org")
                            "* %f \n :PROPERTIES: \n :NOTER_DOCUMENT: %F \n :END: \n [[%F][Filepath]]")
                           ("a" "Abgabe" entry (file "~/Documents/OrgFiles/Vorlesungen.org")
                            "* [[%F][%f]]  \n ")
                           )
 )

(with-eval-after-load 'org
  (defun weiss-after-org-capture ()
    "DOCSTRING"
    (interactive)
    (unless org-note-abort
      (let ((key  (plist-get org-capture-plist :key))
            (desc (plist-get org-capture-plist :description))
            (template (plist-get org-capture-plist :template))
            )
        (cond
         ((string-prefix-p "CONFIG-" desc)
          (let* ((filename (with-temp-buffer
                             (insert template)
                             (goto-char (point-min))
                             (search-forward "#+roam_key: ")
                             (let ((beg (point))
                                   end
                                   )
                               (search-forward ".el")
                               (setq end (point))
                               (buffer-substring-no-properties beg end)
                               )
                             ))
                 (name (file-name-sans-extension (file-name-nondirectory filename)))
                 )
            (find-file filename)          
            (insert "(with-eval-after-load '\n\n)")
            (goto-char (point-max))
            (insert (format "\n\n(provide '%s)" name))
            ))))))

  (add-hook 'org-capture-after-finalize-hook #'weiss-after-org-capture)
  )


(provide 'weiss_capture<org)
