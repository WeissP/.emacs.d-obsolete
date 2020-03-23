(use-package snails
  :load-path "/home/weiss/.emacs.d/snails"
  :straight nil
  :init
  (require 'snails-backend-browser-bookmark)
  (require 'snails-backend-file-bookmark)
  ;; (require 'snails-backend-eaf-youtube-search)
  (require 'snails-backend-eaf-web-search)
  (require 'snails-backend-filter-buffer)
  (require 'snails-backend-limit-recentf)
  (require 'snails-backend-eaf-bangou-search)
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

  ;; (snails '(snails-backend-filter-buffer))

  (set-face-attribute 'snails-select-line-face nil
                      :slant 'italic
                      :background "wheat"
                      )

  (defun snails-normal-backends ()
    (interactive)
    (setq current-buf-name (buffer-name))
    (snails '(
              snails-backend-filter-buffer
              snails-backend-file-bookmark
              ;; snails-backend-recentf 
              snails-backend-limit-recentf
              ))
    )
  
  (defun snails-eaf-backends ()
    (interactive)
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

  (define-key snails-mode-map (kbd "C-j") #'snails-select-next-item)
  (define-key snails-mode-map (kbd "C-k") #'snails-select-prev-item)  
  (define-key snails-mode-map (kbd "C-s") #'snails-select-prev-backend)
  (define-key snails-mode-map (kbd "C-d") #'snails-select-next-backend)  

  
  )

(defun weiss-snails-mode-setup ()
  "to be run as hook for `snails-mode'."
  (xah-fly-insert-mode-activate)
  )

;; (add-hook 'snails-mode-hook 'weiss-snails-mode-setup)

;; (snails '(snails-backend-filter-buffer))
;; (string-match ".*" "*65ba-sdf1-sdf8-12gg-dsf8-xcv8-asds")




