(with-eval-after-load 'snails
  (setq
   snails-show-with-frame nil
   snails-fame-width-proportion 0.8
   snails-default-show-prefix-tips nil
   snails-fuz-library-load-status "unload"
   )

  (require 'snails-backend-buffer)
  (require 'snails-backend-projectile)
  (require 'snails-backend-imenu)
  (require 'snails-backend-directory-files)
  (require 'snails-backend-current-buffer)
  (require 'snails-backend-search-pdf)

  (require 'snails-backend-org-roam)
  (require 'snails-backend-file-bookmark)
  (require 'snails-backend-filter-buffer)
  (require 'snails-backend-recentf-weiss)
  (require 'snails-backend-rg-curdir)
  (require 'snails-backend-filter-buffer)
  (require 'snails-backend-preview)

  (setq snails-prefix-backends
        '((";" '(snails-backend-projectile snails-backend-rg-curdir))
          ("," '(snails-backend-imenu snails-backend-directory-files snails-backend-current-buffer))
          ("=" '(snails-backend-buffer))
          ("!" '(snails-backend-search-pdf))
          ))

  (setq snails-default-backends
        '(
          snails-backend-preview
          snails-backend-filter-buffer
          snails-backend-emacs-config
          snails-backend-file-bookmark
          snails-backend-org-roam-link
          snails-backend-org-roam-focusing
          snails-backend-org-roam-uc
          snails-backend-org-roam-project
          snails-backend-org-roam-note
          snails-backend-org-roam-tutorial
          snails-backend-recentf-weiss
          snails-backend-org-roam-all
          snails-backend-org-roam-new2
          ))
  )

(provide 'weiss_settings<snails)
