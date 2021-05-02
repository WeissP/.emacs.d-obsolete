(with-eval-after-load 'popwin
  (popwin-mode 1)
  (push '(debugger-mode :height 30) popwin:special-display-config)
  ;; (push '("*Stardict Output*" :height 30) popwin:special-display-config)
  ;; (push '("weiss_abbrevs.el" :height 30) popwin:special-display-config)
  (push '("*quickrun*" :height 10) popwin:special-display-config)
  (push '("*meghanada-typeinfo*" :height 30) popwin:special-display-config)
  ;; *Org Src abgabe-blatt01-AlgoDat.org[ LaTeX environment ]*
  (setq popwin:special-display-config (delete '(occur-mode :noselect t) popwin:special-display-config))
  )

(provide 'weiss_settings<popwin<window-frame<ui)
