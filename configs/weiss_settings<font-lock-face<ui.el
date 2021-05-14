(with-eval-after-load 'weiss_after-dump-misc
  (set-face-attribute 'default nil :font "JetBrainsMono")
  (set-face-attribute 'fixed-pitch nil :font "JetBrainsMono")
  ;; (set-face-attribute 'variable-pitch nil :font "Route159" :height 1.05)
  (set-face-attribute 'variable-pitch nil :font "lato" :height 1.05)

  (set-face-attribute 'font-lock-keyword-face nil :foreground "#5b5e6b" :weight 'extrabold :slant 'italic)
  (set-face-attribute 'font-lock-comment-face nil :foreground "#9ca0a4" :weight 'light :slant 'normal)

  (set-face-attribute 'font-lock-doc-face nil :font (font-spec :name "Route159") :weight 'normal :slant 'normal)
  (set-face-attribute 'region nil :background "#cfe4ff")
  (set-face-attribute 'font-lock-builtin-face nil :foreground "#a0522d" :slant 'italic)
  (set-face-attribute 'font-lock-variable-name-face nil :foreground "#383a42" :underline t)
)

(provide 'weiss_settings<font-lock-face<ui)
