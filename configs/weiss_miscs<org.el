(with-eval-after-load 'org
  (provide 'org-version)
  (defun weiss-org-copy-heading-link ()
    "copy the current heading link in org format"
    (interactive)
    (let* ((title (substring-no-properties (org-get-heading t t t t)))
           (des (read-string "Description: " title))
           )
      (kill-new (format "[[*%s][%s]]" title des))
      ))

  (defun weiss-org-search ()
    "execute different search commands with universal argument"
    (interactive)
    (let ((arg-v (prefix-numeric-value current-prefix-arg)))
      (setq current-prefix-arg nil)
      (cond
       ((eq arg-v 4) (counsel-org-goto))
       ((> arg-v 4) (counsel-org-goto-all))
       (t (swiper))
       )
      )
    )

  (defun weiss-switch-and-bookmarks-search()
    (interactive)
    (find-file "~/Documents/OrgFiles/Einsammlung.org")
    (org-agenda nil "b"))

  (defun weiss-org-archive()
    (interactive)
    (setq current-prefix-arg '(4))
    (call-interactively 'org-archive-subtree))
  )



(provide 'weiss_miscs<org)
