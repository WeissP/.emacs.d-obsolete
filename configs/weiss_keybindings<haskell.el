(with-eval-after-load 'haskell-mode
  (with-eval-after-load 'haskell-interactive-mode
    (wks-unset-key haskell-interactive-mode-map '("SPC"))
    (wks-define-key
     haskell-mode-map
     ""
     '(
       ("-" . weiss-haskell-load-process-and-switch-buffer)
       ("<tab>" . weiss-indent)
       ))
    (wks-define-key
     haskell-interactive-mode-map
     ""
     '(
       ("<up>" . haskell-interactive-mode-history-previous)
       ("<down>" . haskell-interactive-mode-history-next)
       ))
    )

  (with-eval-after-load 'haskell-indentation-mode
    (wks-unset-key haskell-indentation-mode-map '(";"))
    )
  )

(provide 'weiss_keybindings<haskell)
