(use-package snails
  :load-path "/home/weiss/.emacs.d/snails"
  :ensure nil
  ;; :defer nil
  :init
  
  (require 'snails-backend-browser-bookmark)
  (require 'snails-backend-file-bookmark)
  ;; (require 'snails-backend-eaf-youtube-search)
  (require 'snails-backend-eaf-web-search)
  (require 'snails-backend-filter-buffer)
  (require 'snails-backend-limit-recentf)
  (require 'snails-backend-eaf-bangou-search)
  (require 'snails-backend-eaf-browser-history)
  (require 'snails-backend-eaf-browser-open)
  (require 'snails-backend-eaf-browser-search)
  (require 'snails-backend-eaf-github-search)

  ;; (define-key snails-mode-map [remap next-line] #'snails-select-next-item)
  ;; (define-key snails-mode-map [remap previous-line] #'snails-select-prev-item)
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
    ;; (setq current-buf-name (buffer-name))
    (snails '(
              snails-backend-filter-buffer
              snails-backend-file-bookmark
              snails-backend-limit-recentf
              )))

  (defun snails-eaf-backends ()
    (interactive)
    ;; (require 'weiss_eaf)
    (snails '(
              snails-backend-eaf-bangou-search
              snails-backend-eaf-web-search
              snails-backend-browser-bookmark
              snails-backend-eaf-browser-history
              snails-backend-eaf-browser-open
              snails-backend-eaf-browser-search
              snails-backend-eaf-github-search
              ))
    )
;; (snails '(snails-backend-eaf-browser-history))
  (define-key snails-mode-map (kbd "C-j") #'snails-select-next-item)
  (define-key snails-mode-map (kbd "C-k") #'snails-select-prev-item)
  (define-key snails-mode-map (kbd "C-s") #'snails-select-prev-backend)
  (define-key snails-mode-map (kbd "C-d") #'snails-select-next-backend))

(defun weiss-snails-mode-setup ()
  "to be run as hook for `snails-mode'."
  (xah-fly-insert-mode-activate)
  )

;; (add-hook 'snails-mode-hook 'weiss-snails-mode-setup)

;; (snails '(snails-backend-filter-buffer))
;; (string-match ".*" "*65ba-sdf1-sdf8-12gg-dsf8-xcv8-asds")

(provide 'weiss_snails)


;; (snails '(snails-backend-current-buffer))
