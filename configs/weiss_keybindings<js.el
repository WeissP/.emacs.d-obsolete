(with-eval-after-load 'js-format
  (wks-define-key js-mode-map ""
                  '(
                    ("<tab>" . js-format-buffer)
                    ))
  )

(provide 'weiss_keybindings<js)
