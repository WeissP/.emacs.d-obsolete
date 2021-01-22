;; -*- lexical-binding: t -*-
;; general

;; [[file:../emacs-config.org::*general][general:1]]
(use-package snails
  ;; :quelpa (snails 
  ;;          :fetcher github 
  ;;          :repo manateelazycat/snails)
  :load-path "/home/weiss/.emacs.d/snails"
  :ensure nil
  ;; :defer nil
  :config
  ;; (setq snails-show-with-frame t)
  (setq snails-show-with-frame nil)
  ;; (setq snails-fuz-library-load-status "load")
  (setq snails-fame-width-proportion 0.8)
  (setq snails-default-show-prefix-tips nil)

  (require 'snails-backend-file-bookmark)
  (require 'snails-backend-filter-buffer)
  (require 'snails-backend-recentf-weiss)
  (require 'snails-backend-rg-curdir)
  (require 'snails-backend-filter-buffer)

  (defvar snails-current-dir nil)
  (defun weiss-snails-get-current-dir ()
    "get the path of current file"
    (interactive)
    (ignore-errors (setq snails-current-dir (expand-file-name default-directory))))
  ;; (advice-add 'snails :before 'weiss-snails-get-current-dir)

  (setq weiss-reduce-file-path-alist
        '(
          ("🅲🅻🅿" . "Compiler-and-Language-Processing-Tools")
          ("🆂🅲" . "scientififc computing")
          ("🆅" . "Documents/Vorlesungen")
          ("🅥" . "Nutstore Files/Vorlesungen")
          ("🅹" . "src/main/java")
          ("🅙🅣" . "src/test/java")
          ("~" . "/home/weiss")
          ))

  (defun weiss-reduce-file-path (filename &optional r)
    "replace long file paths with symbol, if `r' is non-nil, then replace symbol with path"
    (interactive)
    (let ((search-str)
          (replace-str))
      (dolist (x weiss-reduce-file-path-alist)
        (if r
            (setq search-str (car x) 
                  replace-str (cdr x))
          (setq search-str (cdr x) 
                replace-str (car x)))      
        (setq filename (replace-regexp-in-string search-str replace-str filename t))
        )
      )  
    (let ((limit 110)
          )
      (when (> (length filename) limit)
        (setq filename (substring filename -limit)))      
      )    
    filename
    )

  (defun weiss-snails-create-window ()
    (setq snails-init-conf (current-window-configuration))

    (delete-other-windows)

    (split-window)
    (ignore-errors (windmove-down))

    ;; (ignore-errors
    ;;   (dotimes (i 50)
    ;;     (windmove-down)))

    (switch-to-buffer snails-input-buffer)
    (set-window-margins (selected-window) 1 1)

    (split-window (selected-window) (line-pixel-height) nil t)
    (windmove-down)
    (switch-to-buffer snails-content-buffer)
    (set-window-margins (selected-window) 1 1)
    (other-window -1)

    (add-hook 'after-change-functions 'snails-monitor-input nil t)
    )
  (advice-add 'snails-create-window :override 'weiss-snails-create-window)

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
        '((";" '(snails-backend-projectile snails-backend-rg-curdir))
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

  ;; (defun weiss-test ()
  ;;   "DOCSTRING"
  ;;   (interactive)
  ;;   (snails '(snails-backend-projectile)))

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
