(with-eval-after-load 'haskell-mode
  (with-eval-after-load 'hasky-stack
    (wks-define-key
     haskell-mode-map
     ""
     '(
       ("t e" . hasky-stack-execute)
       ))
    )
  )

(provide 'weiss_settings<hasky-stack<haskell)
