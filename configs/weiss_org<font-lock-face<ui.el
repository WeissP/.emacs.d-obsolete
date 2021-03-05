(when (featurep 'org)
  (add-hook 'org-mode-hook (lambda ()
                             (variable-pitch-mode)
                             ))
  ;; fix indentation when variable-pitch-mode is called
  (require 'org-indent)
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))  

  (set-face-attribute 'bold  nil
                      :weight 'demibold
                      :slant 'normal
                      :underline 'nil
                      :foreground "#f5355e"
                      :background nil)
  (set-face-attribute 'italic nil
                      :weight 'normal
                      :underline 'nil
                      :slant 'italic
                      :height 0.95
                      :foreground "#606060"
                      :background nil)
  (set-face-attribute 'underline nil
                      :weight 'normal
                      :underline 'nil
                      :foreground "medium sea green"
                      :background nil)
  (set-face-attribute 'org-link nil
                      :height 1.1
                      :inherit nil
                      :underline t
                      )
  (set-face-attribute 'org-block-begin-line nil
                      :weight 'normal
                      :slant 'normal
                      :extend t
                      :underline 'nil
                      :foreground "#999999"
                      :background "#FAFAFA")
  (set-face-attribute 'org-checkbox nil
                      :font "JetBrainsMono"
                      :extend nil
                      )
  (set-face-attribute 'org-table nil
                      :font "JetBrainsMono"
                      :extend nil
                      )

  (set-face-attribute 'org-block nil
                      :font "JetBrainsMono"
                      :extend nil
                      :background "#FAFAFA")

  (set-face-attribute 'org-drawer nil
                      :foreground "#999999"
                      :slant 'normal
                      :weight 'light
                      :background nil)
  (set-face-attribute 'org-special-keyword nil
                      :height 'unspecified
                      :foreground 'unspecified
                      :weight 'bold
                      :slant 'normal
                      :inherit 'org-drawer)
  (set-face-attribute 'org-property-value nil
                      :weight 'normal
                      :slant 'normal
                      :height 1.0
                      :inherit 'org-special-keyword)
  (set-face-attribute 'org-headline-done nil
                      :strike-through t
                      :weight 'normal)

  (set-face-attribute 'org-level-1 nil
                      :height 1.35
                      :foreground "#ff5a19"
                      :weight 'bold)
  (set-face-attribute 'org-level-2 nil
                      :height 0.95
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-1)
  (set-face-attribute 'org-level-3 nil
                      :height 0.95
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-2)
  (set-face-attribute 'org-level-4 nil
                      :height 0.95
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-3)
  (set-face-attribute 'org-level-5 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-4)
  (set-face-attribute 'org-level-6 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-5)
  (set-face-attribute 'org-level-7 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-6)
  (set-face-attribute 'org-level-8 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-7)

  (font-lock-add-keywords 'org-mode
                          '(("^.*:Frage:.*$" 0 'font-lock-keyword-face)))

  (add-to-list 'org-tag-faces '("Frage" . (:foreground "red"  :weight 'bold)))
  )

(provide 'weiss_org<font-lock-face<ui)
