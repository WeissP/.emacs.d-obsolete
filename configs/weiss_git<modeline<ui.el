;; (defvar-local weiss-mode-line-git nil)

;; (defun vc-branch ()
;;   (let ((backend (vc-backend buffer-file-name)))
;;     (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2))))

;; (defun weiss-mode-line-update-git (&rest args)
;;   "DOCSTRING"
;;   (interactive)
;;   (setq weiss-mode-line-git (vc-branch))
;;   )

;; (add-hook 'find-file-hook #'weiss-mode-line-update-git)
;; (add-hook 'after-save-hook #'weiss-mode-line-update-git)
;; (advice-add #'vc-refresh-state :after #'weiss-mode-line-update-git)

(provide 'weiss_git<modeline<ui)
