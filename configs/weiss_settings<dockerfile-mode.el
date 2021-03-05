(with-eval-after-load 'dockerfile-mode
  (setq-mode-local dockerfile-mode completion-ignore-case t)
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  )

(provide 'weiss_settings<dockerfile-mode)
