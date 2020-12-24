;; -*- lexical-binding: t -*-
;; shell or terminal
;; :PROPERTIES:
;; :header-args: :tangle shell-or-terminal/weiss-shell-or-terminal.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*shell or terminal][shell or terminal:1]]
(use-package aweshell
  ;; :disabled                             
  :quelpa (aweshell
           :fetcher github
           :repo "manateelazycat/aweshell"))

(use-package vterm
  :disabled
  :config
  (setq vterm-shell "zsh")
  (add-hook 'vterm-set-title-functions 'vterm--rename-buffer-as-title))

;; (defun vterm--rename-buffer-as-title (title)
;; (rename-buffer (format "vterm @ %s" title) t))

(defun weiss-send-last-command ()
  "DOCSTRING"
  (interactive)
  (eshell-kill-output)
  (eshell-previous-matching-input-from-input 1)
  (eshell-send-input)
  )

(ryo-modal-keys
 (:mode 'eshell-mode)
 ("u" weiss-send-last-command))

(provide 'weiss-shell-or-terminal)
;; shell or terminal:1 ends here
