(dolist (x '(c-mode c++-mode objc-mode cuda-mode)) 
  (add-hook x #'(lambda () (require 'ccls) (lsp)))
  )

(setq ccls-executable "/usr/bin/ccls")

(with-eval-after-load 'ccls
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json" ".ccls")
                  projectile-project-root-files-top-down-recurring)))
  )

(provide 'weiss_settings<ccls<lsp-mode)
