(setq-default mode-line-format
              `(
                " "
                (:eval (if wks-vanilla-mode
                           (concat "<"
                                   (propertize "I" 'face
                                               '(:foreground "red" :weight 'bold))
                                   ">"
                                   )
                         "<C>"
                         ))
                "   "
                mode-line-mule-info mode-line-modified mode-line-remote
                "   "
                (,line-number-mode "L%l/")
                (,line-number-mode weiss-mode-line-buffer-line-count)
                (,column-number-mode " C%c ")        
                ;; weiss-mode-line-flycheck-errors
                "   "
                "Root:" weiss-mode-line-projectile-root-dir
                "   "
                "%e" mode-line-buffer-identification "   " 
                ;; weiss-mode-line-git
                (vc-mode vc-mode)
                "  " mode-line-misc-info mode-line-end-spaces
                ))

(provide 'weiss_settings<modeline<ui)
