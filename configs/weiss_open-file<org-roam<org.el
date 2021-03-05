(with-eval-after-load 'org-roam
  ;; open link from roam direkt in browser
  (with-no-warnings
    (defun weiss-org-link-open-as-file (path arg)
      "Pretend PATH is a file name and open it.

According to \"file\"-link syntax, PATH may include additional
search options, separated from the file name with \"::\".

This function is meant to be used as a possible tool for
`:follow' property in `org-link-parameters'."
      (let* ((option (and (string-match "::\\(.*\\)\\'" path)
                          (match-string 1 path)))
             (file-name (if (not option) path
                          (substring path 0 (match-beginning 0)))))
        (if (string-match "[*?{]" (file-name-nondirectory file-name))
            (dired file-name)
          (if (string-prefix-p "Ʀlink:" (file-name-nondirectory file-name))
              (with-temp-buffer
                (insert-file-contents file-name)
                (re-search-forward "#\\+roam_key: ")
                (browse-url (buffer-substring-no-properties (+ (line-beginning-position) 12) (line-end-position)))
                )
            (apply #'org-open-file
                   file-name
                   arg
                   (cond ((not option) nil)
                         ((string-match-p "\\`[0-9]+\\'" option)
                          (list (string-to-number option)))
                         (t (list nil option))))
            )
          )))

    (advice-add 'org-link-open-as-file :override 'weiss-org-link-open-as-file)
    )
  )

(provide 'weiss_open-file<org-roam<org)
