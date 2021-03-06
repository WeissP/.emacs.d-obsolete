(setq
 lsp-headerline-breadcrumb-enable nil
 lsp-ui-doc-enable nil
 lsp-enable-symbol-highlighting nil
 lsp-enable-links nil                 ;; no clickable links
 lsp-enable-folding nil               ;; use `hideshow' instead
 lsp-enable-text-document-color nil   ;; as above
 lsp-enable-semantic-highlighting nil ;; as above
 lsp-enable-symbol-highlighting nil   ;; as above
 lsp-modeline-code-actions-enable nil ;; keep modeline clean
 lsp-modeline-diagnostics-enable t  ;; as above
 lsp-lens-enable nil                    ;; disable lens
 lsp-eldoc-enable-hover t           ;; disable eldoc hover
 lsp-signature-auto-activate t        ;; show function signature
 lsp-signature-doc-lines 2            ;; but dont take up more lines
 )

(provide 'weiss_ui<lsp-mode)
