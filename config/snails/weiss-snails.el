;; -*- lexical-binding: t -*-
;; snails
;; :PROPERTIES:
;; :header-args: :tangle snails/weiss-snails.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*snails][snails:1]]
(use-package snails
    :load-path "/home/weiss/.emacs.d/snails"
    :ensure nil
    ;; :defer nil
    :init
    ;; (setq snails-fuz-library-load-status "load")
    (setq snails-fame-width-proportion 0.8)
    (setq snails-default-show-prefix-tips nil)
    (require 'snails-backend-browser-bookmark)
    (require 'snails-backend-file-bookmark)
    ;; (require 'snails-backend-eaf-youtube-search)
    (require 'snails-backend-filter-buffer)
    (require 'snails-backend-limit-recentf)
    (require 'snails-backend-rg-curdir)

    (define-key snails-mode-map [remap next-line] #'snails-select-next-item)
    (define-key snails-mode-map [remap previous-line] #'snails-select-prev-item)
    :config
    ;; (add-to-list 'snails-backend-buffer-blacklist " *snails tips*")
    ;; (add-to-list 'snails-backend-buffer-blacklist "*eaf*")
    ;; (weiss--define-keys
    ;;  (define-prefix-command 'snails-mode-map)
    ;;  '(
    ;;    ("C-j" . snails-select-next-item)
    ;;    ("C-k" . snails-select-prev-item)
    ;;    ("C-s" . snails-select-prev-backend)
    ;;    ("C-d" . snails-select-next-backend)
    ;;    ))

    (defun snails-init-face-with-theme ()
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
                            :slant 'italic
                            :foreground "#383a42"
                            :background "wheat" )
        ))

    (defun snails-render-web-icon ()
      (all-the-icons-faicon "globe"))

    (defun snails-normal-backends ()
      (interactive)
      (setq snails-start-frame (selected-frame))
      ;; (setq current-buf-name (buffer-name))
      (snails '(
                snails-backend-filter-buffer
                snails-backend-file-bookmark
                snails-backend-limit-recentf
                ;; snails-backend-projectile
                ))
      ;; (select-frame-set-input-focus snails-start-frame)
      )
    ;; (snails '(snails-backend-rg))
    ;; (snails '(snails-backend-current-buffer))
    (setq snails-prefix-backends
          '((";" '(snails-backend-directory-files snails-backend-projectile))
            ("," '(snails-backend-imenu snails-backend-current-buffer snails-backend-rg-curdir))
            ;; ("," '(snails-backend-imenu snails-backend-current-buffer))
            ("!" '(snails-backend-search-pdf))
            ))

    (setq snails-default-backends
          '(
            snails-backend-filter-buffer
            snails-backend-file-bookmark
            snails-backend-limit-recentf
            ;; snails-backend-projectile
            ))

    ;; (snails '(snails-backend-current-buffer))
    (define-key snails-mode-map (kbd "C-j") #'snails-select-next-item)
    (define-key snails-mode-map (kbd "C-k") #'snails-select-prev-item)
    (define-key snails-mode-map (kbd "C-s") #'snails-select-prev-backend)
    (define-key snails-mode-map (kbd "C-d") #'snails-select-next-backend)

(setq snails-fuz-library-load-status "unload")
    ;; (require 'fuz)

    ;; (add-hook 'snails-mode-hook 'weiss-snails-mode-setup)

    ;; (snails '(snails-backend-filter-buffer))
    ;; (string-match ".*" "*65ba-sdf1-sdf8-12gg-dsf8-xcv8-asds")
    )

  (provide 'weiss-snails)
;; snails:1 ends here
