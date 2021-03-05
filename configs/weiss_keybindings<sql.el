(define-key sql-mode-map (kbd "<backtab>") #'weiss-indent-paragraph)

(ryo-modal-keys
 (:mode 'sql-mode)
 ("<backtab>"  weiss-indent-paragraph)
 ("t" weiss-sql-send-paragraph-or-region)
 ("u" weiss-insert-semicolon)
 )

(provide 'weiss_keybindings<sql)
