(with-eval-after-load 'snails
  (defun weiss-snails-fuzzy-match-input-p (input candidate-content)
    "replace space as .* and replace two spaces as space"
    (interactive)
    (setq input (replace-regexp-in-string "  " "ⓨ" input)) 
    (setq input (replace-regexp-in-string " " ".*" input))
    (setq input (replace-regexp-in-string "ⓨ" " " input))
    (string-match-p input candidate-content)
    )

  (advice-add 'snails-match-input-p :override #'weiss-snails-fuzzy-match-input-p)
  )

(provide 'weiss_fuzzy-match<snails)
