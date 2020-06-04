(use-package flycheck
  :diminish
  :hook (after-init . global-flycheck-mode)
  ;; :hook (prog-mode . flycheck-mode)
  :init
  (setq flycheck-global-modes
              '(not text-mode outline-mode fundamental-mode lisp-interaction-mode
                    org-mode diff-mode shell-mode eshell-mode term-mode vterm-mode)
              flycheck-emacs-lisp-load-path 'inherit
              flycheck-indication-mode (if (display-graphic-p)
                                           'right-fringe
                                         'right-margin)
              ;; Only check while saving and opening files
              flycheck-check-syntax-automatically '(mode-enabled)
              )
  :config
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))

  ;; Display Flycheck errors in GUI tooltips
  (if (display-graphic-p)
      (use-package flycheck-posframe
        :custom-face (flycheck-posframe-border-face ((t (:inherit default))))
        :hook (flycheck-mode . flycheck-posframe-mode)
        :init (setq flycheck-posframe-border-width 1
                    flycheck-posframe-inhibit-functions
                    '((lambda (&rest _) (bound-and-true-p company-backend)))))
    
    (use-package flycheck-popup-tip
      :hook (flycheck-mode . flycheck-popup-tip-mode)))

  ;; (use-package flycheck-java)
  (use-package flycheck-infer
    :disabled
    :quelpa (flycheck-infer
             :fetcher github
             :repo calve/flycheck-infer)
    )
  )

(provide 'weiss_flycheck)
