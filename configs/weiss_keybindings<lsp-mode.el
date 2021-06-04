(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "M-p") #'lsp-describe-thing-at-point)
  (define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
  (define-key lsp-mode-map [remap xref-find-references] #'lsp-find-references)

  (wks-define-key
   lsp-mode-map ""
   '(
     ("t a" . lsp-execute-code-action)
     ("t i" . lsp-organize-imports)
     ("t d" . lsp-describe-thing-at-point)
     ("y" . lsp-rename)            
     ))

  (defmacro wks-lsp-bindkey (mode)
    `(with-eval-after-load ',(intern mode) 
       (wks-define-key
        ,(intern (format "%s-map" mode)) ""
        '(
          ("t a" . lsp-execute-code-action)
          ("t i" . lsp-organize-imports)
          ("t d" . lsp-describe-thing-at-point)
          ("y" . lsp-rename)            
          )
        )
       )
    )

  (dolist (x '("go-mode" "python-mode" "java-mode")) 
    `(wks-lsp-bindkey ,x)          
    )
  )

(provide 'weiss_keybindings<lsp-mode)
