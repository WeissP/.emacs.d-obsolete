(wks-define-key
 sql-mode-map ""
 '(
   ("<backtab>" . weiss-indent-paragraph)
   ("t" . weiss-sql-send-paragraph-or-region)
   ("u" . weiss-insert-semicolon)
   ("9" . snails-select-next-item)
   ("C-s" . snails-select-prev-backend)
   ("C-d" . snails-select-next-backend)
   ("M-RET" . snails-candidate-alt-do)
   )
 )

(provide 'weiss_keybindings<sql)
