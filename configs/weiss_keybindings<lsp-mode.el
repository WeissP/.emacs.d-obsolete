(define-key lsp-mode-map (kbd "M-p") #'lsp-describe-thing-at-point)
(define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
(define-key lsp-mode-map [remap xref-find-references] #'lsp-find-references)

(wks-define-key
 lsp-mode-map ""
 '(
   ("t a" . lsp-execute-code-action)
   ("t i" . lsp-organize-imports)
   ("t d" . lsp-describe-thing-at-point)
   ("u" . lsp-rename)            
   ))

(with-eval-after-load 'lsp-mode
  (dolist (x '(go-mode-map python-mode-map java-mode-map)) 
    (eval `(wks-define-key
            ,x ""
            '(
              ("t a" . lsp-execute-code-action)
              ("t i" . lsp-organize-imports)
              ("t d" . lsp-describe-thing-at-point)
              ("u" . lsp-rename)            
              )))    
    )
  )

(provide 'weiss_keybindings<lsp-mode)
