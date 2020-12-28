;; -*- lexical-binding: t -*-
;; completion
;; :PROPERTIES:
;; :header-args: :tangle completion/weiss-completion.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*completion][completion:1]]
;;; yasnippet
(defun +yas-expand-or-company-complete ()
  (interactive)
  (or (yas/expand)
      (call-interactively #'company-indent-or-complete-common)))

(use-package company
  :hook (company-mode . company-tng-mode)
  :bind
  (:map company-mode-map
        ("<tab>" . '+yas-expand-or-company-complete)
        ("TAB" . '+yas-expand-or-company-complete))
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
   (eshell-mode . company-mode))
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
  )

(use-package yasnippet
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
