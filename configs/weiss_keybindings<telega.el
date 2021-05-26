(define-key telega-chat-mode-map [remap org-roam-dailies-capture-today] #'weiss-roam-telega-capture)

(wks-define-key
 telega-msg-button-map ""
 '(
   ("-" . push-button)
   ("c" . weiss-telega-copy-msg)
   ("SPC" . wks-leader-keymap)
   ("C-r" . telega-chatbuf-filter-search)
   )
 )

(wks-define-key
 telega-chat-mode-map ""
 '(
   ("C-r" . telega-chatbuf-filter-search)
   )
 )


(wks-unset-key telega-root-mode-map '("s" "i" "a"))
(wks-unset-key telega-chat-button-map '("s" "i" "a"))
(wks-unset-key telega-msg-button-map '("k" "l" "i" "=" "a"))





(provide 'weiss_keybindings<telega)
