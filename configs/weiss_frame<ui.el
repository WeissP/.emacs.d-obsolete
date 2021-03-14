;; (car (frame-edges))
;; (frame-width)
;; (frame-height)
;; (frame-edges)
(defvar weiss-desktop-left-frame-alist
  '((tool-bar-lines . 0)
    (width . 103) ; chars
    (height . 48) ; lines
    (left . 1680)
    (top . 0)))

(defvar weiss-desktop-right-frame-alist
  '((tool-bar-lines . 0)
    (width . 104) ; chars
    (height . 48) ; lines
    (left . 2640)
    (top . 0)))

(defvar weiss-laptop-left-frame-alist
  '((tool-bar-lines . 0)
    (width . 104) ; chars
    (height . 48) ; lines
    (left . 0)
    (top . 0)))

(defvar weiss-laptop-right-frame-alist
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

(provide 'weiss_frame<ui)
