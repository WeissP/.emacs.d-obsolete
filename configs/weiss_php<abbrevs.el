(with-eval-after-load 'weiss_html<abbrevs
  (when (boundp 'php-mode-abbrev-table)
    (clear-abbrev-table php-mode-abbrev-table))

  (setq weiss-php-mode-abbrev-table
        (append weiss-html-mode-abbrev-table
                '(
                  ("php" "<?php\n▮\n?>" weiss--ahf)
                  ("e" "echo ▮;" weiss--ahf)
                  ("rt" "return ▮;" weiss--ahf)
                  ("g" "global ▮;" weiss--ahf)
                  ("for" "for ($i = 1; $i <= $▮; $i++) {\n\n}" weiss--ahf-indent)
                  ("hs" "htmlspecialchars(▮)" weiss--ahf)
                  )
                ))

  (define-abbrev-table 'php-mode-abbrev-table weiss-php-mode-abbrev-table)
  (define-abbrev-table 'web-mode-abbrev-table weiss-php-mode-abbrev-table)
  )



(provide 'weiss_php<abbrevs)
