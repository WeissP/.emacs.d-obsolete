(with-eval-after-load 'snails
  (defun snails-render-web-icon ()
    (all-the-icons-faicon "globe"))

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
  )

(provide 'weiss_ui<snails)
