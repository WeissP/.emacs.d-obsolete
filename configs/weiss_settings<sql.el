(with-eval-after-load 'sql
  (setq sql-postgres-login-params
        '((user :default "weiss")
          (database :default "imdb")
          (server :default "localhost")
          ))
  ;; (defalias 'sql-get-login 'ignore)
  (defun sql-send-string-no-popup (str)
    "Send the string STR to the SQL process."
    (interactive "sSQL Text: ")

    (let ((comint-input-sender-no-newline nil)
          (s (replace-regexp-in-string "[[:space:]\n\r]+\\'" "" str)))
      (if (sql-buffer-live-p sql-buffer)
          (progn
            ;; Ignore the hoping around...
            (save-excursion
              ;; Set product context
              (with-current-buffer sql-buffer
                (when sql-debug-send
                  (message ">>SQL> %S" s))

                ;; Send the string (trim the trailing whitespace)
                (sql-input-sender (get-buffer-process (current-buffer)) s)

                ;; Send a command terminator if we must
                (sql-send-magic-terminator sql-buffer s sql-send-terminator)

                (when sql-pop-to-buffer-after-send-region
                  (message "Sent string to buffer %s" sql-buffer))))

            ;; Display the sql buffer
            ;; (sql-display-buffer sql-buffer)
            )

        ;; We don't have no stinkin' sql
        (user-error "No SQL process started"))))


  (defun weiss-sql-send-paragraph-or-region ()
    "if current-prefix-arg then send region else send paragraph, add ; to the end to show the Result in new line"
    (interactive)
    (let ((start)
          (end))      
      (if (or weiss-select-mode (and current-prefix-arg (use-region-p)))           
          (setq start (region-beginning)
                end (region-end))            
        (setq start (save-excursion
                      (backward-paragraph)
                      (point))
              end (save-excursion
                    (forward-paragraph)
                    (point)))        
        )
      (sql-send-string-no-popup (buffer-substring-no-properties start end)))
    )
  )

(provide 'weiss_settings<sql)
