(setq
 lsp-log-io nil                       ;; enable log only for debug
 lsp-response-timeout 100
 lsp-auto-guess-root nil        ; Detect project root
 lsp-keep-workspace-alive nil ; Auto-kill LSP server
 lsp-enable-indentation t
 lsp-enable-on-type-formatting nil    ;; disable formatting on the fly
 lsp-enable-snippet nil               ;; no snippet
 lsp-enable-file-watchers nil         ;; turn off for better performance
 lsp-idle-delay 0.1                   ;; lazy refresh
 lsp-restart 'auto-restart  ;; auto restart lsp
 )

(with-eval-after-load 'lsp-mode
  (add-hook 'python-mode-hook #'(lambda ()
                                  (require 'lsp-python-ms)
                                  (lsp-deferred)))

  (dolist (x '(java-mode-hook go-mode-hook c++-mode-hook)) 
    (add-hook x #'lsp-deferred)
    )
  )

(provide 'weiss_settings<lsp-mode)
