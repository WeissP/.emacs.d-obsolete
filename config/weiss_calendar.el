(use-package german-holidays
  :config
  (setq calendar-holidays holiday-german-RP-holidays)
  )

;; Better views of calendar
(use-package calfw
  :commands cfw:open-calendar-buffer
  :bind ("<C-f12>" . open-calendar)
  :init
  (use-package calfw-org
    :commands (cfw:open-org-calendar cfw:org-create-source))

  (use-package calfw-ical
    :commands (cfw:open-ical-calendar cfw:ical-create-source))

  (defun open-calendar ()
    "Open calendar."
    (interactive)
    (unless (ignore-errors
              (cfw:open-calendar-buffer
               :contents-sources
               (list
                (when org-agenda-files
                  (cfw:org-create-source "YellowGreen"))
                (when (bound-and-true-p centaur-ical)
                  (cfw:ical-create-source "gcal" centaur-ical "IndianRed")))))
      (cfw:open-calendar-buffer)))
  (defalias 'centaur-open-calendar #'open-calendar)
  
  (defun weiss-calendar-command-mode-define-keys ()
    (weiss--define-keys
     xah-fly-key-map
     '(
       ;; ("~" . nil)                      
       ;; (":" . nil)

       ;; ("SPC" . xah-fly-leader-key-map)
       ;; ("DEL" . xah-fly-leader-key-map)
       ;;   ("RET" . newline)

       ;; ("'" . xah-cycle-hyphen-underscore-space)
       ;; ("," . xah-next-window-or-frame)
       ;; ("-" . xah-backward-punct)
       ;; ("." . xah-forward-right-bracket)
       (";" . cfw:navi-next-month-command)
       ;; ("/" . xah-goto-matching-bracket)
       ;; ("\\" . nil)
       ;; ("=" . xah-forward-equal-sign)
       ;; ("[" . hippie-expand )
       ;; ("]" . nil)
       ;; ("`" . other-frame)

       ;; ("<backtab>" . cfw:navi-prev-item-command)
       ;; ("V" . weiss-paste-with-linebreak)
       ;; ("!" . rotate-text)
       ;; ("#" . xah-backward-quote)
       ;; ("$" . xah-forward-punct)

       ("1" . cfw:change-view-day)
       ("2" . cfw:change-view-week)
       ;; ("3" . cfw:change-view-two-weeks)
       ;; ("4" . cfw:change-view-month)
       ;; ("5" . delete-char)
       ;; ("6" . xah-select-block)
       ;; ("7" . xah-select-line)
       ;; ("8" . cfw:change-view-two-weeks)
       ("8" . cfw:change-view-two-weeks)
       ("9" . cfw:change-view-month)

       ;; ("a" . execute-extended-command)
       ;; ("b" . xah-toggle-letter-case)
       ;; ("c" . xah-copy-line-or-region)
       ;; ("d" . xah-delete-backward-char-or-bracket-text)
       ;; ("e" . xah-backward-kill-word)
       ("f" . cfw:show-details-command)
       ;; ("g" . xah-delete-current-text-block)
       ("h" . cfw:navi-previous-day-command)
       ("i" . cfw:navi-previous-month-command)
       ("j" . cfw:navi-next-week-command)
       ("k" . cfw:navi-previous-week-command)
       ("l" . cfw:navi-next-day-command)
       ;; ("m" . xah-backward-left-bracket)
       ;; ("n" . )
       ("o" . cfw:navi-goto-week-end-command)
       ;; ("p" . weiss-insert-line)
       ;; ("q" . xah-reformat-lines)
       ;; ("r" . xah-kill-word)
       ;; ("s" . open-line)
       ("t" . cfw:navi-goto-today-command)
       ("u" . cfw:navi-goto-week-begin-command)
       ;; ("v" . xah-paste-or-paste-previous)
       ;; ("w" . xah-shrink-whitespaces)
       ;; ("x" . xah-cut-line-or-region)
       ;; ("y" . undo)
       ;; ("z" . xah-comment-dwim)
       )))
  )
