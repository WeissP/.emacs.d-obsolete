;; -*- lexical-binding: t -*-
;; sql
;; :PROPERTIES:
;; :header-args: :tangle sql/weiss-sql.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*sql][sql:1]]
(use-package sql
  :hook (sql-mode . (lambda () 
                      (linum-mode -1)
                      ;; (make-local-variable 'display-line-numbers)
                      ;; (setq display-line-numbers 'relative)
                      ))
  :bind
  (
   :map sql-mode-map
   ("<backtab>" . weiss-indent-paragraph)
   )
  :ryo
  (:mode 'sql-mode)
  ("<backtab>"  weiss-indent-paragraph)
  ("t" weiss-sql-send-paragraph-or-region)
  ("u" weiss-insert-semicolon)
  :config
  (setq sql-postgres-login-params
        '((user :default "weiss")
          (database :default "tpch")
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

  (use-package sql-indent
    ;; :disabled
    :quelpa (emacs-sql-indent
             :fetcher github
             :repo "alex-hhh/emacs-sql-indent")
    :config
    (defvar my-sql-indentation-offsets-alist
      `(
        (in-block +)
        (in-begin-block 0)
        (block-start 0)
        (block-end 0)
        ;; put new syntactic symbols here, and add the default ones at the end.
        ;; If there is no value specified for a syntactic symbol, the default
        ;; will be picked up.
        ,@sqlind-default-indentation-offsets-alist))

    (setq my-sql-indentation-offsets-alist
          `(
            (in-block ++)
            (in-begin-block +)
            (block-start ++)
            (block-end 0)

            ;; (in-select-clause sqlind-lineup-to-clause-end
            ;;                   sqlind-adjust-operator
            ;;                   sqlind-left-justify-logical-operator
            ;;                   sqlind-lone-semicolon)
            ;; put new syntactic symbols here, and add the default ones at the end.
            ;; If there is no value specified for a syntactic symbol, the default
            ;; will be picked up.
            ,@sqlind-default-indentation-offsets-alist))

    ;; Arrange for the new indentation offset to be set up for each SQL buffer.
    (add-hook 'sqlind-minor-mode-hook
              (lambda ()
                (setq sqlind-indentation-offsets-alist
                      my-sql-indentation-offsets-alist)))
    )

  (use-package sql-smie-mode
    :disabled
    :quelpa (sql-smie-mode
             :fetcher github
             :repo "deactivated/sql-smie-mode"))
  )

(provide 'weiss-sql)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; weiss_sql.el ends here
;; sql:1 ends here
