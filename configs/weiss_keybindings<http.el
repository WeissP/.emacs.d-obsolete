(wks-define-key  http-mode-map ""
                 '(
                   ("<escape> <escape>" . wks-http-quick-insert-keymap)
                   )
                 )

(with-eval-after-load 'mhtml-mode
  (wks-define-key mhtml-mode-map ""
                  '(
                    ("<tab>" . weiss-indent)
                    ("t s" . weiss-run-java-spring)
                    ))
  )


(provide 'weiss_keybindings<http)
