(define-key lsp-mode-map (kbd "M-p") #'lsp-describe-thing-at-point)
(define-key lsp-mode-map [remap xref-find-definitions] #'lsp-find-definition)
(define-key lsp-mode-map [remap xref-find-references] #'lsp-find-references)

;; (with-eval-after-load 'lsp-mode
;;   (dolist (x '(go-mode python-mode java-mode)) 
;;     (eval `(ryo-modal-keys
;;             (:mode ',x)
;;             ("t i" lsp-organize-imports)
;;             ("t d" lsp-describe-thing-at-point)
;;             ("u" lsp-rename)            
;;             )) 
;;     )
;;   )

(provide 'weiss_keybindings<lsp-mode)
