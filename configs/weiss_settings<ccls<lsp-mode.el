(with-eval-after-load 'emacs-ccls
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json" ".ccls")
                  projectile-project-root-files-top-down-recurring)))
  (require 'ccls)
  (dolist (x '(c-mode c++-mode objc-mode cuda-mode)) 
    (add-hook x #'(lambda () (lsp)))
    )

  (setq ccls-executable "/usr/bin/ccls")
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  )

(provide 'weiss_settings<ccls<lsp-mode)
