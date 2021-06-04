(with-eval-after-load 'go-mode
  (wks-define-key
 go-mode-map ""
 '(
   ("8" . weiss-execute-buffer)
   )))


(provide 'weiss_keybindings<go-mode)
