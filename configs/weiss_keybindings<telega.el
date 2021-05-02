(define-key telega-chat-mode-map [remap org-roam-dailies-capture-today] #'weiss-roam-telega-capture)

(wks-define-key
 telega-msg-button-map ""
 '(
   ("-" . push-button)
   ("c" . weiss-telega-copy-msg)
   ("SPC" . wks-leader-keymap)
   )
 )

(wks-unset-key telega-root-mode-map '("s" "i"))
(wks-unset-key telega-chat-button-map '("s" "i"))
(wks-unset-key telega-msg-button-map '("k" "l" "i" "="))





(provide 'weiss_keybindings<telega)
