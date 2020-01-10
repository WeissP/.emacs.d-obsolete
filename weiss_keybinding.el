;;; ~/Documents/pi/+keybinding.el -*- lexical-binding: t; -*-

(use-package xah-fly-keys
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1)
;;  :bind
;;  (
;;   ("<Esc>" . xah-fly-command-mode-activate)
;;   )
;;  (define-key key-translation-map (kbd "Esc") (kbd "<f8>"))
  ;;(define-key xah-fly-key-map (kbd "Esc") 'xah-fly-command-mode-activate)
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  )

(use-package key-chord
  :config
  (key-chord-define-global "jk" 'xah-fly-command-mode-activate)
  (key-chord-mode 1)
  )

(defun weiss-xfk-addon-command ()
  (interactive)
  (define-key xah-fly-key-map (kbd "h") 'backward-char)
  (define-key xah-fly-key-map (kbd "j") 'next-line)
  (define-key xah-fly-key-map (kbd "k") 'previous-line)
  (define-key xah-fly-key-map (kbd "l") 'forward-char)
  (define-key xah-fly-key-map (kbd "i") 'xah-beginning-of-line-or-block)
  )

(add-hook 'xah-fly-command-mode-activate-hook 'weiss-xfk-addon-command)

(use-package which-key
  ;; :hook (after-init . (which-key-mode))
  )
(which-key-mode)
(provide 'weiss_keybinding)

;;; weiss_keybinding.el ends here
