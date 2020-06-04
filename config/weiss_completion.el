;;; -*- lexical-binding: t -*-
;;; Completion

(use-package company
  :bind
  (
   ;; :map company-mode-map
   ;; ("<tab>" . '+insert-tab)
   :map company-active-map
        ("0" . 'company-select-next)
        ("9" . 'company-select-previous)
        ("<tab>" . 'company-complete-selection)
        ("TAB" . 'company-complete-selection)
        ("RET")
        ("<return>")
        ("SPC")
        :map company-template-nav-map
        ("RET" . 'company-template-forward-field)
        ("<return>" . 'company-template-forward-field)
        ("TAB")
        ("<tab>"))
  :init
  (require 'company-template)
  :hook
  (after-init . global-company-mode)
  :custom
  (company-frontends '(company-tng-frontend
                       company-pseudo-tooltip-frontend
                       company-echo-metadata-frontend))
  (company-begin-commands
   '(
     xah-fly-insert-mode-activate
     self-insert-command
     weiss-disable-abbrev-and-activate-insert-mode
     kill-line
     weiss-delete-forward-with-region
     weiss-delete-backward-with-region
     weiss-cut-line-or-delete-region
     delete-backward-char
     ))
  (company-idle-delay 0.01)
  (company-minimum-prefix-length 3)
  (company-dabbrev-downcase nil)
  (company-abort-manual-when-too-short t)
  (company-require-match nil)
  (company-global-modes '(not dired-mode dired-sidebar-mode))
  ;; :config
  ;; (setq completion-ignore-case t) 
  ;; (use-package company-auctex)
  ;; (require 'company-sql)
  ;; (add-to-list 'company-backends 'company-sql)
  )

;;; yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode)
  :config (use-package yasnippet-snippets))


(provide 'weiss_completion)
