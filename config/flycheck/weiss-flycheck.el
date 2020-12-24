;; -*- lexical-binding: t -*-
;; flycheck
;; :PROPERTIES:
;; :header-args: :tangle flycheck/weiss-flycheck.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*flycheck][flycheck:1]]
(use-package flycheck
  :diminish
  ;; :hook (after-init . global-flycheck-mode)
  :hook (
         (python-mode . flycheck-mode)
         (java-mode . flycheck-mode)
         )
  :init
  (setq 
   ;; Only check while saving and opening files
   flycheck-check-syntax-automatically '(mode-enabled save)
   ;; flycheck-temp-prefix ".flycheck"
   ;; flycheck-emacs-lisp-load-path 'inherit
   )
  :config
  ;; (when (fboundp 'define-fringe-bitmap)
  ;; (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
  ;; [16 48 112 240 112 48 16] nil nil 'center))

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
  )

(provide 'weiss-flycheck)
;; flycheck:1 ends here
