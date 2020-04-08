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

(defun vterm--rename-buffer-as-title (title)
  (rename-buffer (format "vterm @ %s" title) t))

(provide 'weiss_shell_or_terminal)
