;; -*- lexical-binding: t -*-
;; completion
;; :PROPERTIES:
;; :header-args: :tangle completion/weiss-completion.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*completion][completion:1]]
;;; Completion

(use-package company
  :bind
  (
   ;; :map company-mode-map
   ;; ("<tab>" . '+insert-tab)
   :map company-active-map
   ("9" . 'weiss-company-select-next-or-toggle-main-frame)
   ("0" . 'weiss-company-select-previous-other-window)
   ("<tab>" . 'company-complete-common-or-cycle)
   ("TAB" . 'company-complete-common-or-cycle)
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
     self-insert-command
     delete-backward-char
     org-self-insert-command
     org-delete-backward-char
     weiss-disable-abbrev-and-activate-insert-mode
     kill-line
     weiss-delete-forward-with-region
     weiss-delete-backward-with-region
     weiss-cut-line-or-delete-region
     delete-backward-char
     weiss-before-insert-mode
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
  :config
  (defun weiss-company-select-next-or-toggle-main-frame ()
    "DOCSTRING"
    (interactive)
    (if ryo-modal-mode
        (weiss-switch-to-otherside-top-frame)
      (company-select-next)
      ))
  (defun weiss-company-select-previous-other-window ()
    "DOCSTRING"
    (interactive)
    (if ryo-modal-mode
        (weiss-switch-buffer-or-otherside-frame-without-top)
      (company-select-previous)
      ))
  )

  ;;; yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode)
  :config (use-package yasnippet-snippets))

(provide 'weiss-completion)
;; completion:1 ends here
