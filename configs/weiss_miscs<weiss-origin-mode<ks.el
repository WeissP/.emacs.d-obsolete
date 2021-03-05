(with-eval-after-load 'weiss-origin-mode
  (add-to-list 'weiss-origin-keep-keys '(telega-chat-mode . ("<deletechar>")))
  (add-to-list 'weiss-origin-keep-keys '(org-agenda-mode . ("<deletechar>" "9" "-" "s")))

  (let ((hook-list '(
                     org-agenda-mode-hook
                     magit-status-mode-hook
                     magit-mode-hook
                     telega-chat-mode-hook
                     telega-root-mode-hook
                     image-mode-hook
                     )))
    (dolist (x hook-list)
      (add-hook x 'weiss-origin-mode-enable))
    )

  (defun weiss-enable-origin-mode-only-in-fundamental-mode ()
    "only enable weiss-origin-mode when current major mode is plain fundamental-mode"
    (when (and (not weiss-origin-mode) (eq major-mode 'fundamental-mode))
      (weiss-origin-mode 1)
      )
    )
  ;; (add-to-list 'weiss/after-buffer-change-function-list 'weiss-enable-origin-mode-only-in-fundamental-mode)
  )

(provide 'weiss_miscs<weiss-origin-mode<ks)
