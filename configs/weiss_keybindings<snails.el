(setq wks-snails-vanilla-mode-map (make-sparse-keymap))
(set-keymap-parent wks-snails-vanilla-mode-map wks-vanilla-keymap)  

(with-eval-after-load 'snails
  (wks-define-key
   wks-snails-vanilla-mode-map ""
   '(
     ("<left>" . left-char)
     ("<right>" . right-char)
     ("<down>" . snails-select-next-item)
     ("<up>" . snails-select-prev-item)
     ("C-j" . snails-select-next-item)
     ("C-k" . snails-select-prev-item)
     ("C-M-S-s-k" . snails-select-prev-backend)
     ("C-M-S-s-j" . snails-select-next-backend)
     ("C-s" . snails-select-prev-backend)
     ("C-d" . snails-select-next-backend)
     ("C-<return>" . snails-candidate-alt-do)
     ("<end>" . wks-vanilla-mode-disable)
     )
   )
  ;; (define-key snails-mode-map [remap next-line] #'snails-select-next-backend)
  ;; (define-key snails-mode-map [remap previous-line] #'snails-select-prev-backend)
  ;; (setq-mode-local snails-mode wks-vanilla-mode-map wks-snails-vanilla-mode-map)
  )

(provide 'weiss_keybindings<snails)


