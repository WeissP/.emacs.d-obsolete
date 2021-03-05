(defun weiss-after-change-frame-or-window (&optional a b c)
  "run after change frame or window"
  (interactive)
  (dolist (x weiss/after-buffer-change-function-list)
    (eval (list x))
    )
  )

(let ((function-list '(
                       select-frame-set-input-focus
                       previous-buffer
                       next-buffer
                       switch-to-buffer
                       other-window
                       find-file
                       org-open-file
                       dired-goto-file
                       org-agenda-finalize
                       wdired-finish-edit
                       )))
  (dolist (x function-list)
    (advice-add x :after #'weiss-after-change-frame-or-window)
    )
  )

(defun weiss-after-major-mode ()
  "run after new major mode"
  (interactive)
  (dolist (x weiss/after-major-mode-function-list)
    (eval (list x))
    )
  )

(let ((hook-list '(
                   prog-mode-hook
                   text-mode-hook
                   fundamental-mode-hook
                   dired-mode-hook
                   wdired-mode-hook
                   special-mode-hook
                   conf-mode-hook
                   quickrun-after-run-hook
                   custom-mode-hook
                   )))
  (dolist (x hook-list)
    (add-hook x 'weiss-after-major-mode))
  )

(provide 'weiss_buffer-frame-change-hook<ks)
