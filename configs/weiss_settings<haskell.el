(with-eval-after-load 'haskell-mode
  ;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  ;; (setq haskell-process-path-ghci "/home/weiss/.ghcup/bin/ghci-9.0.1")
  (add-hook 'haskell-mode-hook
            (lambda ()
              (interactive-haskell-mode t)
              (haskell-indentation-mode -1)))
  ;; (setq haskell-process-type 'stack-ghci)
  (defun weiss-haskell-load-process-and-switch-buffer ()
    "DOCSTRING"
    (interactive)
    (haskell-process-load-or-reload)
    (if (one-window-p)
        (progn
          (split-window-below)          
          (other-window 1)
          (switch-to-buffer "*haskell*")
          )
      (other-window 1)
      (unless (string= (buffer-name) "*haskell*")
        (switch-to-buffer "*haskell*")
        )
      )
    )

  )

(provide 'weiss_settings<haskell)
