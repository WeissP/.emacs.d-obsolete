(setq wks-repeat-command-alist
      '(
        (weiss-delete-forward-with-region . kill-line)
        (weiss-delete-backward-with-region . weiss-kill-line-backward)
        (xah-shrink-whitespaces . weiss-insert-space)
        (weiss-select-line-downward . xah-select-current-block)
        (xah-select-current-block . xah-select-block)
        (weiss-cut-line-or-delete-region . weiss-delete-current-block)
        (kill-region . weiss-delete-current-block)
        (er/expand-region . weiss-expand-region-outside)
        (xah-toggle-letter-case . weiss-downcase-region)
        (undo . undo-redo)

        (weiss-down-key . weiss-move-to-next-block)
        (next-line . weiss-move-to-next-block)

        (weiss-up-key . weiss-move-to-previous-block)
        (previous-line . weiss-move-to-previous-block)

        (weiss-right-key . weiss-move-to-next-punctuation)
        (right-char . weiss-move-to-next-punctuation)
        (forward-char . weiss-move-to-next-punctuation)

        (weiss-left-key . weiss-move-to-previous-punctuation)
        (left-char . weiss-move-to-previous-punctuation)
        (backward-char . weiss-move-to-previous-punctuation)

        (xah-paste-or-paste-previous . yank)
        ))

(setq wks-repeat-command-blacklist
      '(wks-repeat-command popwin:close-popup-window rotate-text snails-quit keyboard-quit))

(setq wks-last-command nil)

(defun wks-repeat-command ()
  "CSTRING"
  (interactive)
  ;; (message "last-command: %s" last-command)
  (if-let ((c (cdr (assoc last-command wks-repeat-command-alist)))
           )
      (setq wks-last-command c)
    (if (eq last-command 'wks-repeat-command)
        (when-let ((c (cdr (assoc wks-last-command wks-repeat-command-alist)))
                   )
          (setq wks-last-command c))
      (when (and last-command (not (member last-command wks-repeat-command-blacklist))) 
        (setq wks-last-command last-command)
        )
      )    
    )
  (message "wks-last-command: %s" wks-last-command)
  (call-interactively wks-last-command)
  )



(provide 'weiss_repeat-command<wks)
