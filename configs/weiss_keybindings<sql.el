(wks-unset-key sql-mode-map '("t"))
(wks-define-key
 sql-mode-map ""
 '(
   ("<backtab>" . weiss-indent-paragraph)
   ("y" . weiss-sql-send-paragraph-or-region)
   ("t s" . weiss-insert-semicolon)
   )
 )

(provide 'weiss_keybindings<sql)
