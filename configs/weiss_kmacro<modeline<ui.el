(defun weiss-modeline-add-kmacro (&rest args)
  "DOCSTRING"
  (interactive)
  (add-to-list 'mode-line-format
               '(:eval
                 (if defining-kbd-macro
                     (propertize " kmacro " 'face
                                 '(:foreground "blue" :weight 'bold))
                   (weiss-modeline-remove-kmacro)
                   ))
               )
  )

(defun weiss-modeline-remove-kmacro (&rest args)
  "DOCSTRING"
  (interactive)
  (setq mode-line-format (cdr mode-line-format))
  )

(advice-add 'kmacro-start-macro :after #'weiss-modeline-add-kmacro)

(provide 'weiss_kmacro<modeline<ui)
