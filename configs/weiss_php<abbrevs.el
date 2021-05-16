(when (boundp 'php-mode-abbrev-table)
  (clear-abbrev-table php-mode-abbrev-table))

(define-abbrev-table 'php-mode-abbrev-table
  '(
    ("php" "<?php\n▮\n?>")
    ))

(provide 'weiss_php<abbrevs)
