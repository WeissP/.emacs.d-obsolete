(setq lsp-ui-doc-enable nil
      lsp-ui-doc-use-webkit nil
      lsp-ui-doc-delay 0.2
      lsp-ui-doc-include-signature t
      lsp-ui-doc-position 'at-point
      lsp-ui-doc-border (face-foreground 'default)
      lsp-eldoc-enable-hover nil ; Disable eldoc displays in minibuffer

      lsp-ui-sideline-enable t
      lsp-ui-sideline-show-hover nil
      lsp-ui-sideline-show-diagnostics nil
      lsp-ui-sideline-update-mode 'line
      lsp-ui-sideline-delay 1
      lsp-ui-sideline-show-code-actions nil
      lsp-ui-sideline-ignore-duplicate nil
      )

(provide 'weiss_settings<lsp-ui<lsp-mode)
