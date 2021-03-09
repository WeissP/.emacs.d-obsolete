(with-eval-after-load 'hl-line
  (set-face-attribute 'hl-line nil :inherit nil :box nil :background "#ffe8e8" :extend nil)
  (defface box-hl-line
    '((t (:inherit nil :extend nil :box (:line-width (-1 . -2) :color "#ededed" :style nil))))
    "highlight the current line with box"
    )
  ;; (set (make-local-variable 'hl-line-face) 'box-hl-line)

  (defface normal-hl-line
    '((t :box nil :extend nil :background "#ffe8e8"))
    "highlight the current line with background"
    )

  (defface emphasis-hl-line
    '((t :box nil :extend nil :background "#ffb5ff"))
    "highlight the current line with background"
    )

  (defvar weiss/disable-hl-mode-list '(snails-mode pdf-view-mode))

  (defun weiss-enable-hl-line (&rest args)
    "change hl line face by major-mode"
    (interactive)
    (unless (member major-mode weiss/disable-hl-mode-list)
      (hl-line-mode -1)
      (cond
       (weiss-dired-single-handed-mode
        (set (make-local-variable 'hl-line-face) 'emphasis-hl-line)
        )
       ((eq major-mode 'dired-mode)
        (set (make-local-variable 'hl-line-face) 'normal-hl-line)
        )
       ((eq major-mode 'org-agenda-mode)
        (set (make-local-variable 'hl-line-face) 'normal-hl-line)
        )
       (t (set (make-local-variable 'hl-line-face) 'box-hl-line))
       )
      (hl-line-mode 1)
      )
    )

  (defun weiss-toggle-hl-line ()
    "toggle hl line using weiss-enable-hl-line"
    (interactive)
    (if hl-line-mode
        (hl-line-mode -1)
      (weiss-enable-hl-line)
      )
    )

  (add-hook 'window-state-change-functions #'weiss-enable-hl-line)
  ;; (add-to-list 'weiss/after-buffer-change-function-list 'weiss-enable-hl-line)
  ;; (add-to-list 'weiss/after-major-mode-function-list 'weiss-enable-hl-line)
  )

(provide 'weiss_settings<hl-line<ui)
