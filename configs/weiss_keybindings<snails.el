(with-eval-after-load 'snails
  (wks-define-key
   snails-mode-map ""
   '(
     ("C-j" . snails-select-next-item)
     ("C-k" . snails-select-prev-item)
     ("8" . snails-select-prev-item)
     ("9" . snails-select-next-item)
     ("C-s" . snails-select-prev-backend)
     ("C-d" . snails-select-next-backend)
     ("M-RET" . snails-candidate-alt-do)
     )
   )
  ;; (define-key snails-mode-map (kbd "C-j") #'snails-select-next-item)
  ;; (define-key snails-mode-map (kbd "C-k") #'snails-select-prev-item)
  ;; (define-key snails-mode-map (kbd "C-s") #'snails-select-prev-backend)
  ;; (define-key snails-mode-map (kbd "C-d") #'snails-select-next-backend)
  ;; (define-key snails-mode-map (kbd "M-RET") #'snails-candidate-alt-do)

  (define-key snails-mode-map [remap next-line] #'snails-select-next-backend)
  (define-key snails-mode-map [remap previous-line] #'snails-select-prev-backend)

  (add-to-ordered-list 'emulation-mode-map-alists
		               `((snails-mode . ,snails-mode-map)))
  ;; (define-key snails-mode-map (kbd "8") 'snails-select-prev-item)
  ;; (define-key snails-mode-map (kbd "9") 'snails-select-next-item)
  )

(provide 'weiss_keybindings<snails)
