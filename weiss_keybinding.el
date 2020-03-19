(use-package which-key
  :hook (after-init . which-key-mode)
  )

(use-package weiss_xfk
  :disabled
  :straight nil
  :init
  ;; (setq xah-fly-use-control-key nil)
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1)
  )

(load "/home/weiss/.emacs.d/weiss_xfk.el")
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key xah-fly-key-map (kbd "C-v") 'xah-paste-or-paste-previous)
(define-key xah-fly-key-map (kbd "<f5>") 'revert-buffer)

(use-package key-chord
  :disabled
  :config
  (key-chord-define-global "jk" 'xah-fly-command-mode-activate)
  (key-chord-mode 1)
  )

(defun weiss-xfk-ret-key ()
  (interactive)
  (cond
   ((eq major-mode 'org-mode) (call-interactively 'doom-org-dwim-at-point))
   (t nil)))

