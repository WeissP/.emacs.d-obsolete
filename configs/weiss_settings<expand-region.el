(with-eval-after-load 'expand-region
  (defun weiss-expand-region-outside ()
    "DOCSTRING"
    (interactive)
    (let ((er/try-expand-list '(
                                ;; er/mark-word
                                ;; er/mark-symbol
                                ;; er/mark-symbol-with-prefix
                                ;; er/mark-next-accessor
                                ;; er/mark-method-call
                                ;; er/mark-inside-quotes
                                ;; er/mark-outside-quotes
                                ;; er/mark-inside-pairs
                                er/mark-outside-pairs
                                ;; er/mark-comment
                                ;; er/mark-url
                                ;; er/mark-email
                                ;; er/mark-defun
                                )))
      (message "er/try-expand-list: %s" er/try-expand-list)
      (call-interactively 'er/expand-region)
      )
    )
  )

(provide 'weiss_settings<expand-region)
