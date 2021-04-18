(wks-define-key
 sql-mode-map ""
 '(
   ("<backtab>" . weiss-indent-paragraph)
   ("t" . weiss-sql-send-paragraph-or-region)
   ("u" . weiss-insert-semicolon)
   )
 )

(provide 'weiss_keybindings<sql)
