(if (display-graphic-p)
    (progn
      (setq default-frame-alist weiss-desktop-left-frame-alist)
      (setq initial-frame-alist weiss-desktop-right-frame-alist)
      )
  (progn
    (setq initial-frame-alist '( (tool-bar-lines . 0)))
    (setq default-frame-alist '( (tool-bar-lines . 0)))))

(provide 'weiss_frame<ui)
