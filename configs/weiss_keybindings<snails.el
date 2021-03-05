(with-eval-after-load 'snails
  (define-key snails-mode-map (kbd "C-j") #'snails-select-next-item)
  (define-key snails-mode-map (kbd "C-k") #'snails-select-prev-item)
  (define-key snails-mode-map (kbd "C-s") #'snails-select-prev-backend)
  (define-key snails-mode-map (kbd "C-d") #'snails-select-next-backend)
  (define-key snails-mode-map (kbd "M-RET") #'snails-candidate-alt-do)

  (define-key snails-mode-map [remap next-line] #'snails-select-next-backend)
  (define-key snails-mode-map [remap previous-line] #'snails-select-prev-backend)

  (define-key snails-mode-map (kbd "8") 'snails-select-prev-item)
  (define-key snails-mode-map (kbd "9") 'snails-select-next-item)
  )

(provide 'weiss_keybindings<snails)
