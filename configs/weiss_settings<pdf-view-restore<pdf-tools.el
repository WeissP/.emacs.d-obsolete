(setq pdf-view-restore-filename "~/.emacs.d/.pdf-view-restore")

(with-eval-after-load 'pdf-view-restore
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))

(provide 'weiss_settings<pdf-view-restore<pdf-tools)
