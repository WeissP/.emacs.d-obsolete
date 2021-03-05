(when (featurep 'snails)
  (set-face-attribute 'snails-header-line-face nil :inherit 'variable-pitch :foreground "#a626a4" :underline t :weight 'normal :slant 'italic :height 1.2)
  (set-face-attribute 'snails-header-index-face nil :inherit 'snails-header-line-face :height 0.7 :slant 'italic)
  (set-face-attribute 'snails-candiate-content-face nil :inherit 'variable-pitch :weight 'light :slant 'normal)
  (set-face-attribute 'snails-input-buffer-face nil :inherit 'variable-pitch :font (font-spec :name "lato") :height 200)
  (set-face-attribute 'snails-content-buffer-face nil :inherit 'variable-pitch :font (font-spec :name "lato") :height 150)
  )

(provide 'weiss_snails<font-lock-face<ui)
