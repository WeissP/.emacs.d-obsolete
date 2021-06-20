(wks-unset-key java-mode-map '("," "/" ";"))

(wks-define-key
 java-mode-map "t"
 '(
   ("t" . lsp-java-generate-to-string)
   ("s" . weiss-run-java-spring)
   ;; ("f" . weiss-format-current-java-file)
   ("F" . weiss-format-current-java-dir)
   ("j" . weiss-add-javadoc)
   ("e" . lsp-java-generate-equals-and-hash-code)
   ("o" . lsp-java-generate-overrides)
   ("g" . lsp-java-generate-getters-and-setters)             
   ))

(provide 'weiss_keybindings<lsp-java<lsp-mode)
