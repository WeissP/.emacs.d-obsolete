(add-hook 'python-mode #'flycheck-mode)
(add-hook 'java-mode #'flycheck-mode)
(setq 
 ;; Only check while saving and opening files
 flycheck-check-syntax-automatically '(mode-enabled save)
 ;; flycheck-temp-prefix ".flycheck"
 ;; flycheck-emacs-lisp-load-path 'inherit
 )

(provide 'weiss_settings<flycheck)
