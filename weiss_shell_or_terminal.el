(use-package aweshell
  ;; :disabled                             
  :straight (aweshell
             :type git
             :host github
             :repo "manateelazycat/aweshell"))

(use-package vterm
  :config
  (setq vterm-shell "zsh")
  (add-hook 'vterm-set-title-functions 'vterm--rename-buffer-as-title))

(defun vterm--rename-buffer-as-title (title)
  (rename-buffer (format "vterm @ %s" title) t))
