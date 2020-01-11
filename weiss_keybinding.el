;;; ~/Documents/pi/+keybinding.el -*- lexical-binding: t; -*-

(use-package which-key
  :hook (after-init . which-key-mode)
  )

(use-package xah-fly-keys
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1)
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
  (define-key xah-fly-key-map (kbd "!") 'rotate-text)
  (define-key xah-fly-key-map (kbd "<backtab>") 'weiss-indent)
  (define-key xah-fly-key-map (kbd "n") 'swiper-isearch)  
  (define-key xah-fly-key-map (kbd "p") 'weiss-insert-line)  
  (define-key xah-fly-key-map (kbd "V") 'weiss-paste-with-linebreak)  
  (define-key xah-fly-key-map (kbd "2") 'scroll-up)  
  (define-key xah-fly-key-map (kbd "1") 'scroll-down)  
  (define-key xah-fly-key-map (kbd "0") 'universal-argument)  
  (define-key xah-fly-key-map (kbd "(") '(xah-pop-local-mark-ring))  
  ;; i-keymap
  (define-key xah-fly-c-keymap (kbd "o") 'counsel-bookmark)
  (define-key xah-fly-c-keymap (kbd "j") 'counsel-recentf)
  ;; ,-keymap
  (define-key xah-fly-w-keymap (kbd "m") 'weiss-eval-last-sexp)
  ;; r-keymap
  ;; (define-key xah-fly-key-map ())
  )

(add-hook 'xah-fly-command-mode-activate-hook 'weiss-xfk-addon-command)

(defun weiss-xfk-addon-insert ()
  (interactive)
  (define-key xah-fly-key-map (kbd "!") 'nil)
  (define-key xah-fly-key-map (kbd "V") 'nil)
  (define-key xah-fly-key-map (kbd "J") 'nil)  
  (define-key xah-fly-key-map (kbd "K") 'nil)  
  (define-key xah-fly-key-map (kbd "(") 'nil)  
  )

(add-hook 'xah-fly-insert-mode-activate-hook 'weiss-xfk-addon-insert)


(provide 'weiss_keybinding)

;;; weiss_keybinding.el ends here

