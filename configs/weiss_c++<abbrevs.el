(when (boundp 'c++-mode-abbrev-table)
  (clear-abbrev-table c++-mode-abbrev-table))
(define-abbrev-table 'c++-mode-abbrev-table
  '(
    ("s" "std::" weiss--ahf)
    ("vs" "master->VehicleState." weiss--ahf)
    ("rt" "return ▮;" weiss--ahf)
    )
  )

(provide 'weiss_c++<abbrevs)
