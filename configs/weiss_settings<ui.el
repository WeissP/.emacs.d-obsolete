;; (winner-mode)

(if weiss-dumped-p 
    (enable-theme 'doom-one-light)
  (load-theme 'doom-one-light t)
  )

(setq inhibit-startup-screen t)

(provide 'weiss_settings<ui)
