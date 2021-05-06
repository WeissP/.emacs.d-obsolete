(with-eval-after-load 'magit
  (wks-unset-key magit-status-mode-map '("SPC" "9" "-" "0"))
  )

(provide 'weiss_keybindings<magit)
