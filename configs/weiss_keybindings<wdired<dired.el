(wks-define-key
 wdired-mode-map ""
 '(
   ("C-q" . (weiss-dired-exit-wdired (wdired-exit)(wks-vanilla-mode-disable)))
   )
 )

(provide 'weiss_keybindings<wdired<dired)
