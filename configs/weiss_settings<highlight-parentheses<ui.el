(add-hook 'prog-mode-hook #'highlight-parentheses-mode)

(with-eval-after-load 'highlight-parentheses
  (setq
   hl-paren-highlight-adjacent t
   hl-paren-colors '("#E53E3E" "#383a42" "#383a42" "#383a42")
   )
  (set-face-attribute 'hl-paren-face nil :weight 'bold)
  ;; (setq hl-paren-background-colors '("#E53E3E" "#c9bce9" "#FAFAFA""#FAFAFA"))
  )

(provide 'weiss_settings<highlight-parentheses<ui)
