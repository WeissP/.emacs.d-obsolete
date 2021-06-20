(add-hook 'python-mode #'flycheck-mode)
(add-hook 'java-mode #'flycheck-mode)
(setq 
 ;; Only check while saving and opening files
 flycheck-check-syntax-automatically '(mode-enabled save)
 ;; flycheck-temp-prefix ".flycheck"
 ;; flycheck-emacs-lisp-load-path 'inherit
 )

(defun weiss-flycheck-diwm ()
  "DOCSTRING"
  (interactive)
  (if (and lsp-mode current-prefix-arg)
      (call-interactively 'lsp-ui-flycheck-list)
    (call-interactively 'flycheck-list-errors)
    )
  )

(provide 'weiss_settings<flycheck)
