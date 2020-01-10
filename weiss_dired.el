(use-package dired
  :straight nil
  :config
  (setq dried-dwim-target t)
  (setq dired-recursive-deletes t) 
  (setq dired-recursive-copies t) 
  )

(defun weiss-dired-mode-setup ()
  "to be run as hook for `dired-mode'."
  (dired-hide-details-mode 1)
  (xah-fly-insert-mode-activate)
  )
(add-hook 'dired-mode-hook 'weiss-dired-mode-setup)
