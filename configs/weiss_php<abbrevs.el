(when (boundp 'php-mode-abbrev-table)
  (clear-abbrev-table php-mode-abbrev-table))

(define-abbrev-table 'php-mode-abbrev-table
  '(
    ("php" "<?php\n▮\n?>" weiss--ahf)
    ("e" "echo ▮;" weiss--ahf)
    ("rt" "return ▮;" weiss--ahf)
    ("g" "global ▮;" weiss--ahf)
    ))

(provide 'weiss_php<abbrevs)
