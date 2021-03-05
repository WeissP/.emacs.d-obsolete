(when (boundp 'maxima-mode-abbrev-table)
  (clear-abbrev-table maxima-mode-abbrev-table))
(define-abbrev-table 'maxima-mode-abbrev-table
  '(
    ("t" "apply (tex, [%i▮]);" weiss--ahf)
    ("e" ":= " weiss--ahf)
    ("plt" "plot2d(▮,[x,0,1]);" weiss--ahf)
    )
  )

(provide 'weiss_imaxima<abbrevs)
