(global-set-key (kbd "M-m") #'ryo-modal-mode)

(define-key prog-mode-map (kbd "<tab>") 'weiss-indent)
(with-eval-after-load 'latex-mode
  (define-key latex-mode-map (kbd "<tab>") 'weiss-indent)
  (define-key LaTeX-mode-map (kbd "<tab>") 'weiss-indent)
  )

(with-eval-after-load 'sgml-mode
  (define-key sgml-mode-map (kbd "<tab>") 'weiss-indent)
  )
(global-set-key (kbd "<backtab>") 'indent-for-tab-command)
(global-set-key (kbd "<S-delete>") (lambda () (interactive) (insert "\\")))
(global-set-key (kbd "M-DEL") (lambda () (interactive) (insert "|")))
(global-set-key (kbd "<f5>") 'revert-buffer)

(define-key key-translation-map (kbd "<f12>") (kbd "C-g"))

(global-set-key (kbd "M-e") 'eldoc)

(provide 'weiss_keybindings<ks)
