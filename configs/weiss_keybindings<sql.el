(with-eval-after-load 'sql
  (wks-unset-key sql-mode-map '("t"))
  (wks-define-key
   sql-mode-map ""
   '(
     ("<backtab>" . weiss-indent-paragraph)
     ("y" . weiss-sql-send-paragraph-or-region)
     ("t s" . weiss-insert-semicolon)
     )
   )

  (wks-unset-key sql-interactive-mode-map '("o"))
  (wks-define-key
   sql-interactive-mode-map
   ""
   '(
     ("<up>" . comint-previous-input)
     ))
  )

(provide 'weiss_keybindings<sql)
