(when (boundp 'c++-mode-abbrev-table)
  (clear-abbrev-table c++-mode-abbrev-table))
(define-abbrev-table 'c++-mode-abbrev-table
  '(
    ("s" "std::" weiss--ahf)
    ("vs" "master->VehicleState." weiss--ahf)
    ("rt" "return ▮;" weiss--ahf)
    ("pr" "std::cout << ▮ << std::endl;" weiss--ahf)
    ("fi" "for (int i = 0; i < ▮; ++i){\n\n}" weiss--ahf-indent)
    ("if" "if (▮) {\n\n}" weiss--ahf-indent)
    )
  )

(provide 'weiss_cpp<abbrevs)
