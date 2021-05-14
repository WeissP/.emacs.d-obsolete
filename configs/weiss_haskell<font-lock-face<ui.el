(with-eval-after-load 'weiss_after-dump-misc
  (with-eval-after-load 'haskell-mode
    (set-face-attribute 'haskell-operator-face nil
                        :inherit nil
                        :underline nil
                        )
    )  
  )

(provide 'weiss_haskell<font-lock-face<ui)
