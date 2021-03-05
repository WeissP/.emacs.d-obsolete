(with-eval-after-load 'org
  (defun weiss-roam-telega-capture ()
    "DOCSTRING"
    (interactive)
    (let* ((content (format "* TODO %%?\n%s :fleeting:" (weiss-get-telega-marked-text)))
           (org-roam-dailies-capture-templates
            `(
              ("f" "Fleeting notes" entry #'org-roam-capture--get-point
               ,content
               :file-name "daily/Ʀd-%<%Y-%m-%d>"
               :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
               :olp ("Fleeting notes")
               )             
              )
            ))
      (org-roam-dailies-capture-today)
      ))
  )

(provide 'weiss_capture<telega)
