(with-eval-after-load 'snails
  (defun weiss-snails-create-window ()
    (setq snails-init-conf (current-window-configuration))

    (delete-other-windows)

    (split-window)
    (ignore-errors (windmove-down))

    ;; (ignore-errors
    ;;   (dotimes (i 50)
    ;;     (windmove-down)))

    (switch-to-buffer snails-input-buffer)
    (set-window-margins (selected-window) 1 1)

    (split-window (selected-window) (line-pixel-height) nil t)
    (windmove-down)
    (switch-to-buffer snails-content-buffer)
    (set-window-margins (selected-window) 1 1)
    (other-window -1)

    (add-hook 'after-change-functions 'snails-monitor-input nil t)
    )
  (advice-add 'snails-create-window :override 'weiss-snails-create-window)
  )

(provide 'weiss_window<snails)
