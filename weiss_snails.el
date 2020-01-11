(use-package snails
  :straight (snails
             :type git
             :host github
             :repo "manateelazycat/snails")
  
  )

(defun weiss-snails-mode-setup ()
  "to be run as hook for `snails-mode'."
  (xah-fly-insert-mode-activate)
  )
(add-hook 'snails-mode-hook 'weiss-snails-mode-setup)
