(define-key telega-chat-mode-map [remap org-roam-dailies-capture-today] #'weiss-roam-telega-capture)

(wks-define-key
 telega-msg-button-map ""
 '(
   ("9" . weiss-switch-to-otherside-top-frame)
   ("0" .  weiss-switch-buffer-or-otherside-frame-without-top)   
   ("-" . weiss-switch-to-same-side-frame)
   ("SPC" . wks-leader-keymap)
   )
 )

(wks-unset-key telega-root-mode-map '("s"))





(provide 'weiss_keybindings<telega)
