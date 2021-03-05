(when (boundp 'python-mode-abbrev-table)
  (clear-abbrev-table python-mode-abbrev-table)
  )

(define-abbrev-table 'python-mode-abbrev-table
  '(
    ("if" "if ▮:" weiss--ahf)
    ("else" "else:" weiss--ahf)
    ("for" "for ▮ in :" weiss--ahf)
    ("while" "while ▮ :" weiss--ahf)
    ("def" "def ▮():" weiss--ahf)
    ("r" "range(▮)" weiss--ahf)
    ("rt" "return " weiss--ahf)
    ("try" "try:" weiss--ahf)
    ("ex" "except ▮:" weiss--ahf)
    ("pr" "print(▮)" weiss--ahf)
    ))

(provide 'weiss_python<abbrevs)
