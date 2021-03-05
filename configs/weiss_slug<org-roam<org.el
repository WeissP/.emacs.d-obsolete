(with-eval-after-load 'org-roam
  (defun weiss-org-roam--title-to-slug (title)
    "add Umlaut convert"
    (let ((l '(
               ("ä" . "ae")
               ("ö" . "oe")
               ("ü" . "ue")
               ("ß" . "ss")
               )
             )
          )
      (dolist (x l title) 
        (setq title (replace-regexp-in-string (car x) (cdr x) title))
        )      
      )
    (org-roam--title-to-slug title)
    )
  (setq org-roam-title-to-slug-function 'weiss-org-roam--title-to-slug)
  )

(provide 'weiss_slug<org-roam<org)
