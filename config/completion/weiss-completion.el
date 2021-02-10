;; -*- lexical-binding: t -*-
;; completion
;; :PROPERTIES:
;; :header-args: :tangle completion/weiss-completion.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*completion][completion:1]]
;;; yasnippet
(use-package company
  :hook (company-mode . company-tng-mode)
  :bind
  (:map company-active-map
        ("<tab>" . 'company-complete-common-or-cycle)
        ("TAB" . 'company-complete-common-or-cycle)
        ("9" . 'weiss-company-select-next-or-toggle-main-frame)
        ("8" . (lambda () (interactive) (company-complete-common-or-cycle -1)))
        ("<escape>")
        ("RET")
        ("<return>")
        ("SPC"))
  (:map company-template-nav-map
        ("RET" . 'company-template-forward-field)
        ("<return>" . 'company-template-forward-field)
        ("TAB")
        ("<tab>"))
  :init
  (require 'company-template)
  :hook
  ((prog-mode . company-mode)
   (conf-mode . company-mode)
   (eshell-mode . company-mode)
   (org-mode . company-mode))
  :custom
  (company-tng-auto-configure nil)
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
  (company-idle-delay 0.1)
  (company-tooltip-limit 10)
  (company-tooltip-align-annotations t)
  (company-tooltip-width-grow-only t)
  (company-tooltip-idle-delay 0.1)
  (company-minimum-prefix-length 3)
  (company-dabbrev-downcase nil)
  (company-abort-manual-when-too-short t)
  (company-require-match nil)
  (company-global-modes '(not dired-mode dired-sidebar-mode))
  (company-tooltip-margin 1)
  :config
  (setq-mode-local
   org-mode
   company-backends
   '(company-bbdb company-semantic company-cmake company-clang company-files
                  (company-dabbrev-code company-gtags company-etags company-keywords)
                  company-oddmuse company-dabbrev))
  (defun weiss-company-select-next-or-toggle-main-frame ()
    "DOCSTRING"
    (interactive)
    (if ryo-modal-mode
        (weiss-switch-to-otherside-top-frame)
      (company-complete-common-or-cycle 1)
      ))
  (defun weiss-company-select-previous-other-window ()
    "DOCSTRING"
    (interactive)
    (if ryo-modal-mode
        (weiss-switch-buffer-or-otherside-frame-without-top)
      (company-select-previous)
      ))
  (use-package company-box
    :hook (company-mode . company-box-mode)
    :config
    (setq company-box-enable-icon nil)
    (set-face-attribute 'company-tooltip-mouse nil :inherit nil :background nil :foreground nil)
    )
  )

(use-package yasnippet
  :disabled
  :bind
  (:map
   yas-keymap
   ("<escape>")
   ("RET" . 'yas-next-field-or-maybe-expand)
   ("<return>" . 'yas-next-field-or-maybe-expand)
   ("M-RET" . 'yas-expand-snippet)
   ("M-<return>" . 'yas-expand-snippet)
   ("S-<return>" . 'yas-prev-field)
   ("TAB")
   ("S-TAB")
   ("<tab>"))
  :config
  (let ((inhibit-message t)) (yas-reload-all))
  :init
  (add-hook 'prog-mode-hook #'yas-minor-mode))


(provide 'weiss-completion)
;; completion:1 ends here
