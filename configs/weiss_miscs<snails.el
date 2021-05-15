(with-eval-after-load 'snails
  (setq snails-fuz-library-load-status "unload")

  (defun weiss-snails-paste ()
    "paste and convert the paste string in single line"
    (interactive)
    (call-interactively 'xah-paste-or-paste-previous)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "\n" nil t)
        (replace-match ""))
      )
    )
  ;; (defvar snails-current-dir nil)
  ;; (defun weiss-snails-get-current-dir ()
  ;;   "get the path of current file"
  ;;   (interactive)
  ;;   (ignore-errors (setq snails-current-dir (expand-file-name default-directory))))
  ;; (advice-add 'snails :before 'weiss-snails-get-current-dir)

  
  )

(provide 'weiss_miscs<snails)


