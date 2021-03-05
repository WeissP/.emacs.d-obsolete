(with-eval-after-load 'sql-indent
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

(provide 'weiss_settings<sql-indent<sql)
