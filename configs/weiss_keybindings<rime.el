(define-key global-map (kbd "M-SPC") 'toggle-input-method)
(define-key rime-active-mode-map (kbd "C-<return>") 'weiss-rime-return)
(define-key rime-active-mode-map (kbd "<return>") 'rime--return)
(define-key rime-mode-map (kbd "C-n") 'rime-force-enable)

(provide 'weiss_keybindings<rime)
