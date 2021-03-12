(define-key telega-chat-mode-map [remap org-roam-dailies-capture-today] #'weiss-roam-telega-capture)

(wks-define-key
 telega-msg-button-map ""
 '(
   ("9" . weiss-switch-to-otherside-top-frame)
   ("0" .  weiss-switch-buffer-or-otherside-frame-without-top)   
   ("5" .  push-button)   
   ("-" . weiss-switch-to-same-side-frame)
   ("c" . weiss-telega-copy-msg)
   ("SPC" . wks-leader-keymap)
   )
 )

(wks-unset-key telega-root-mode-map '("s" "i"))
(wks-unset-key telega-chat-button-map '("s" "i"))
(wks-unset-key telega-msg-button-map '("k" "l" "i"))





(provide 'weiss_keybindings<telega)
