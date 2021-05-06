(with-eval-after-load 'lsp-haskell
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp)
  (setq lsp-haskell-server-path "/home/weiss/.ghcup/bin/haskell-language-server-8.10.4")
  )

(provide 'weiss_lsp-haskell<lsp-mode)
