(with-eval-after-load 'display-line-numbers
  (setq
   display-line-numbers-grow-only t
   line-number-display-limit-width 200
   display-line-numbers-width 3)

  (dolist (x '(prog-mode)) 
    (eval `(setq-mode-local
            ,x display-line-numbers 'relative))    
    )
  
  (dolist (x '(prog-mode-hook dired-mode-hook)) 
    (add-hook x #'display-line-numbers-mode)
    )
  )

(provide 'weiss_settings<display-line-numbers<ui)
