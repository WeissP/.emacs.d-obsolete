(add-hook 'haskell-mode-hook #'flycheck-mode)
(add-hook 'haskell-mode-hook #'dante-mode)

(with-eval-after-load 'dante
  (flycheck-add-next-checker 'haskell-dante '(info . haskell-hlint))
  (setq dante-repl-command-line '("ghci"))
  (setq dante-methods '(bare-ghci))
  ;; (setq dante-repl-command-line '("cabal" "v2-repl" dante-target "--builddir=newdist/dante"))
  ;; (setq dante-repl-command-line nil)
  )

(provide 'weiss_settings<dante<haskell)
