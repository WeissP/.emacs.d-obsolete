(with-eval-after-load 'org-roam
  (defun weiss-roam-find-roam-key (filename)
    "DOCSTRING"
    (interactive)
    (with-temp-buffer
      (if (file-exists-p filename)
          (insert-file-contents filename)
        (find-file filename)
        )
      (goto-char (point-min))
      (re-search-forward "#\\+roam_key: ")
      (buffer-substring-no-properties (+ (line-beginning-position) 12) (line-end-position))
      )
    )

  (defun weiss-roam-find-file (filename &optional wildcards)
    "DOCSTRING"
    (interactive
     (find-file-read-args "Find file: "
                          (confirm-nonexistent-file-or-buffer)))
    (cond
     ((string-prefix-p "Ʀlink:" (file-name-nondirectory filename))
      (browse-url (weiss-roam-find-roam-key filename))
      )
     ((string-prefix-p "ƦEmacs_Config" (file-name-nondirectory filename))
      (find-file (weiss-roam-find-roam-key filename))
      )
     (t (find-file filename wildcards))
     )
    )

  (setq org-roam-find-file-function 'weiss-roam-find-file)
  )

(provide 'weiss_roam-find-file<org-roam<org)
