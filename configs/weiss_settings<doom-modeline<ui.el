(setq doom-modeline-window-width-limit fill-column
      ;; doom-modeline-project-detection
      ;; doom-modeline-buffer-file-name-style 'relative-to-project
      ;; doom-modeline-bar-width 6
      doom-modeline-window-width-limit 110
      )
;; (setq doom-modeline-minor-modes t)
(line-number-mode -1)
(add-hook 'after-init-hook #'doom-modeline-mode)

(provide 'weiss_settings<doom-modeline<ui)
