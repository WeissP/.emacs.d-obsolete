(with-eval-after-load 'weiss_after-dump-misc
  ;; (car (frame-edges))
  ;; (frame-width)
  ;; (frame-height)
  ;; (frame-edges)
  ;;LEFT TOP RIGHT BOTTOM
  (setq frame-resize-pixelwise t)

  (setq weiss-desktop-left-frame-alist
        '((tool-bar-lines . 0)
          (width . 104) ; chars
          (height . 48) ; lines
          (left . 0)
          (top . 29)))

  (setq weiss-desktop-right-frame-alist
        '((tool-bar-lines . 0)
          (width . 104) ; chars
          (height . 48) ; lines
          (left . 960)
          (top . 29)))

  (setq weiss-laptop-left-frame-alist
        '((tool-bar-lines . 0)
          (width . 104) ; chars
          (height . 48) ; lines
          (left . 0)
          (top . 0)))

  (setq weiss-laptop-right-frame-alist
        '((tool-bar-lines . 0)
          (width . 104) ; chars
          (height . 48) ; lines
          (left . 840)
          (top . 0)))


  (if (display-graphic-p)
      (progn
        (setq default-frame-alist weiss-desktop-left-frame-alist)
        (setq initial-frame-alist weiss-desktop-right-frame-alist)
        )
    (progn
      (setq initial-frame-alist '( (tool-bar-lines . 0)))
      (setq default-frame-alist '( (tool-bar-lines . 0)))))
  )

(provide 'weiss_frame<ui)
