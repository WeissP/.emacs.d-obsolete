(use-package which-key 
  :diminish
  :hook (after-init . which-key-mode)
  )

(use-package weiss_xfk 
  :diminish
  :disabled
  :ensure nil
  :init
  ;; (setq xah-fly-use-control-key nil)
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1)
  )

;; (load "/home/weiss/.emacs.d/config/weiss_xfk.el")
(require 'weiss_xfk)
(define-key key-translation-map (kbd "<f12>") (kbd "C-g"))
;; (define-key key-translation-map (kbd "M-[") (kbd "C-g"))
(define-key xah-fly-key-map (kbd "C-v") 'xah-paste-or-paste-previous)
(define-key xah-fly-key-map (kbd "<S-delete>") '(lambda ()(interactive)(insert "\\")))
(define-key xah-fly-key-map (kbd "<f5>") 'revert-buffer)
(diminish 'xah-fly-keys)

(defun weiss-test ()
  "DOCSTRING"
  (interactive)
  (unless (use-region-p)
    (push-mark (point) nil t))
  (forward-char))

(use-package key-chord 
  :diminish
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

(provide 'weiss_keybinding)
