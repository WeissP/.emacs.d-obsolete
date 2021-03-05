(with-eval-after-load 'org-roam
  (setq org-roam-capture-templates
        `(
          ("d" "default" plain (function org-roam-capture--get-point)
           "* ${title}\n** %?"
           :file-name "Ʀ${slug}_%<%Y%m%d%H>"
           :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags:\n")
          ("p" "project" plain (function org-roam-capture--get-point)
           "* ${title}\n** link:\n*** \n** %?"
           :file-name "ƦProject-${slug}_%<%Y%m%d%H>"
           :head "#+title: Project-${title}\n#+roam_alias: \n#+roam_tags: project \n")
          ("n" "note" plain (function org-roam-capture--get-point)
           "* ${title}\n %?"
           :file-name "ƦNote-${slug}_%<%Y%m%d%H>"
           :head "#+title: note-${title}\n#+roam_alias: \n#+roam_tags: note \n")
          ("t" "tutorial" plain (function org-roam-capture--get-point)
           "* [[file:ƦUseful-commands-${title}_%<%Y%m%d%H>.org][useful commands]]\n* link\n** \n%?"
           :file-name "ƦTutorial-${slug}_%<%Y%m%d%H>"
           :head "#+title: Tutorial-${title}\n#+roam_alias: \n#+roam_tags: tutorial ${slug}\n")
          ("c" "useful commands" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "ƦUseful-commands-${slug}_%<%Y%m%d%H>"
           :head "#+title: Useful-commands-${title}\n#+roam_alias: \n#+roam_tags: useful-commands ${slug}\n")
          ("l" "link" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "Ʀlink:${slug}"
           :head "#+title: ${title}\n#+roam_tags: link#+roam_key: %c\n"
           )
          )
        )

  (setq org-roam-dailies-capture-templates
        '(
          ("s" "Scheduled" entry #'org-roam-capture--get-point
           "* TODO %i%?\nSCHEDULED: <%<%Y-%m-%d %a>>"
           :file-name "daily/Ʀd-%<%Y-%m-%d>"
           :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
           :olp ("Scheduled")
           )
          ("t" "Todo" entry #'org-roam-capture--get-point
           "* TODO %i%?\nSCHEDULED: [%<%Y-%m-%d %a>]"
           :file-name "daily/Ʀd-%<%Y-%m-%d>"
           :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
           :olp ("Todo")
           )
          ("f" "Fleeting notes" entry #'org-roam-capture--get-point
           "* TODO %i%? :fleeting:"
           :file-name "daily/Ʀd-%<%Y-%m-%d>"
           :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
           :olp ("Fleeting notes")
           )
          ("j" "Journey" entry #'org-roam-capture--get-point
           "* %?"
           :file-name "daily/Ʀd-%<%Y-%m-%d>"
           :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
           :olp ("Journey")
           :unnarrowed t
           )
          ))

  (setq org-roam-capture-ref-templates
        '(
          ("r" "ref" plain #'org-roam-capture--get-point
           "%?"
           :file-name "Ʀlink:${slug}"
           :head "#+title: ${title}\n#+roam_alias: \n#+roam_tags: link\n#+roam_key: ${ref}\n"
           :unnarrowed t)))
  )

(provide 'weiss_templates<org-roam<org)
