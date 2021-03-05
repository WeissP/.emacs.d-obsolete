(with-eval-after-load 'dired
  (defun weiss-check-cursor-type ()
    "disable cursor in dired-mode"
    (interactive)
    (when (eq major-mode 'dired-mode)
      (setq cursor-type nil)
      )
    ;; (unless (eq major-mode 'snails-mode) 
    ;;   (if (eq major-mode 'dired-mode)
    ;;       (setq cursor-type nil)
    ;;     (setq cursor-type t)    
    ;;     )      
    ;;   )
    )
  (add-to-list 'weiss/after-major-mode-function-list 'weiss-check-cursor-type)
  (add-to-list 'weiss/after-buffer-change-function-list 'weiss-check-cursor-type)
  )

(provide 'weiss_ui<dired)
