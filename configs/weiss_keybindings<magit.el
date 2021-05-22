(with-eval-after-load 'magit
  (wks-unset-key magit-status-mode-map '("SPC" "9" "-" "0" "a"))
  (wks-define-key
   magit-status-mode-map
   ""
   '(
     ("=" . magit-cherry-apply)
     ))
  )


(provide 'weiss_keybindings<magit)
