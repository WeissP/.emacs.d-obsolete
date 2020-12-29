;; -*- lexical-binding: t -*-
;; general

;; [[file:~/.emacs.d/config/emacs-config.org::*general][general:1]]
(use-package snails
  ;; :quelpa (snails 
  ;;          :fetcher github 
  ;;          :repo manateelazycat/snails)
  :load-path "/home/weiss/.emacs.d/snails"
  :ensure nil
  ;; :defer nil
  :config
  ;; (setq snails-fuz-library-load-status "load")
  (setq snails-fame-width-proportion 0.8)
  (setq snails-default-show-prefix-tips nil)

  (require 'snails-backend-file-bookmark)
  (require 'snails-backend-filter-buffer)
  (require 'snails-backend-recentf-weiss)
  (require 'snails-backend-rg-curdir)
  (require 'snails-backend-filter-buffer)

  (with-no-warnings
    (defun weiss-snails-init-face-with-theme ()
      "disable change face with theme"
      (let* ((bg-mode (frame-parameter nil 'background-mode))
             (default-background-color (face-background 'default))
             (default-foreground-color (face-foreground 'default))
             input-buffer-color
             content-buffer-color)
        (cond ((eq bg-mode 'dark)
               (setq input-buffer-color (snails-color-blend default-background-color "#000000" 0.9))
               (setq content-buffer-color (snails-color-blend default-background-color "#000000" 0.8)))
              ((eq bg-mode 'light)
               (setq input-buffer-color (snails-color-blend default-background-color "#000000" 0.95))
               (setq content-buffer-color (snails-color-blend default-background-color "#000000" 0.9))))
        (set-face-attribute 'snails-input-buffer-face nil
                            :foreground default-foreground-color
                            :background input-buffer-color)

        (set-face-attribute 'snails-content-buffer-face nil
                            :foreground default-foreground-color
                            :background content-buffer-color)

        (set-face-attribute 'snails-select-line-face nil
                            :slant 'normal
                            :foreground default-foreground-color
                            :background "wheat" )
        )
      )
    (advice-add 'snails-init-face-with-theme :override 'weiss-snails-init-face-with-theme)
    )


  (defun snails-render-web-icon ()
    (all-the-icons-faicon "globe"))

  (setq snails-prefix-backends
        '((";" '(snails-backend-rg-curdir snails-backend-projectile))
          ("," '(snails-backend-imenu snails-backend-directory-files snails-backend-current-buffer))
          ("=" '(snails-backend-buffer))
          ("!" '(snails-backend-search-pdf))
          ))

  (setq snails-default-backends
        '(
          snails-backend-filter-buffer
          snails-backend-file-bookmark
          snails-backend-recentf-weiss
          ))

  (define-key snails-mode-map (kbd "C-j") #'snails-select-next-item)
  (define-key snails-mode-map (kbd "C-k") #'snails-select-prev-item)
  (define-key snails-mode-map (kbd "C-s") #'snails-select-prev-backend)
  (define-key snails-mode-map (kbd "C-d") #'snails-select-next-backend)

  (define-key snails-mode-map [remap next-line] #'snails-select-next-backend)
  (define-key snails-mode-map [remap previous-line] #'snails-select-prev-backend)

  (define-key snails-mode-map (kbd "8") 'snails-select-prev-item)
  (define-key snails-mode-map (kbd "9") 'snails-select-next-item)

  (setq snails-fuz-library-load-status "unload")
  ;; (require 'fuz)
  )

(provide 'weiss-snails)
;; general:1 ends here
