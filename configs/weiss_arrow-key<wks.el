(setq weiss-org-special-markers '("*" "/" "$"))

(setq uppercase-alphabet '("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"))


(defvar weiss-non-stop-delimiters-list '(";" "	" " " "\n" "'" "\\"))
(defvar weiss-stop-delimiters-list '("|" "`" ":" "." "," "\"" "-" "+" "_" "=" "/" "@" "$" "*"))

;; need mode-local.el
(setq-mode-local
 python-mode
 weiss-non-stop-delimiters-list '(";" "	" " " "\n" "'" "\\")
 weiss-stop-delimiters-list '("|" "`" ":" ":" "." "," "\"" "-" "+" "_" "=" "/" "@" "$" "*"))

(setq-mode-local
 org-mode
 weiss-non-stop-delimiters-list '("	" " " "\n" "'" "\\")
 weiss-stop-delimiters-list '("|" "`" ":" "&" ";" "." "," "\"" "-" "+" "_" "=" "/" "@" "$" "|"))

(setq-mode-local
 latex-mode
 weiss-non-stop-delimiters-list '("	" " " "\n" "'" "\\")
 weiss-stop-delimiters-list '("|" "`" ":" "&" ";" "." "," "\"" "-" "+" "_" "=" "/" "@" "$" "*"))

(setq-mode-local
 sgml-mode
 weiss-non-stop-delimiters-list '(";" "	" " " "\n" "'" "\\")
 weiss-stop-delimiters-list '("|" "`" ":" "<" ">" "." "," "\"" "-" "+" "_" "=" "/" "@" "$" "*"))

(setq-mode-local
 java-mode
 weiss-non-stop-delimiters-list '("	" " " "\n" "'" "\\")
 weiss-stop-delimiters-list '("|" "`" ":" ";" "." "," "\"" "-" "+" "_" "=" "/" "@" "$" "*"))

(defun weiss--check-two-char (isForward firstList &optional secondList)
  "Check two char"
  (interactive)
  (unless secondList (setq secondList firstList))
  (let ((firstChar)
        (secondChar))
    (if isForward
        (setq firstChar (char-to-string (char-after))
              secondChar (char-to-string (char-after (+ 1 (point)))))
      (setq firstChar (char-to-string (char-before))
            secondChar (char-to-string (char-before (- (point) 1))))
      )
    (and (member firstChar firstList) (member secondChar secondList))
    ;; (message "1:%s 2:%s" firstChar secondChar)
    ))


(defun weiss-right-key ()
  "smart decide whether move by word or by char"
  (interactive)
  (if current-prefix-arg
      (progn
        (setq current-prefix-arg nil)
        (unless (use-region-p) (push-mark nil t))
        (weiss-select-mode-turn-on)
        (forward-char)
        (setq mark-active t))

    (if (string= current-input-method "rime")
        (call-interactively 'right-char)
      (weiss-forward-and-select-word)
      )
    ))

(defun weiss-left-key ()
  "smart decide whether move by word or by char"
  (interactive)
  (if current-prefix-arg
      (progn
        (setq current-prefix-arg nil)
        (unless (use-region-p) (push-mark nil t))
        (backward-char)
        (setq mark-active t)
        (weiss-select-mode-turn-on))    
    (if (string= current-input-method "rime")
        (call-interactively 'left-char)
      (weiss-backward-and-select-word)
      )))

(defun weiss-forward-and-select-word ()
  "Forward and select word, if in quote, then select all"
  (interactive)
  (deactivate-mark)
  (let ((l (line-number-at-pos))
        (p (point))
        )
    (save-excursion
      (while (or (member (char-to-string (char-after)) (append
                                                        weiss-non-stop-delimiters-list
                                                        xah-right-brackets))
                 (weiss--check-two-char t xah-left-brackets))
        (forward-char))
      (when (member (char-to-string (char-after)) (append
                                                   xah-left-brackets
                                                   xah-right-brackets
                                                   weiss-non-stop-delimiters-list
                                                   weiss-stop-delimiters-list))
        (forward-char))
      (when (= l (line-number-at-pos))
        (setq p (point))
        )
      )    
    (goto-char p)
    )
  ;; (call-interactively 'set-mark-command)
  (push-mark nil t)
  (while (member (char-to-string (char-after)) uppercase-alphabet) (forward-char))

  (while (not (member (char-to-string (char-after)) (append
                                                     uppercase-alphabet
                                                     xah-left-brackets
                                                     xah-right-brackets
                                                     weiss-non-stop-delimiters-list
                                                     weiss-stop-delimiters-list)))
    (forward-char))
  (setq mark-active t))

(defun weiss-backward-and-select-word ()
  "Backward and select word"
  (interactive)
  (deactivate-mark)
  (setq case-fold-search t)
  (let ((l (line-number-at-pos))
        (p (point))
        )
    (save-excursion
      (while (or (member (char-to-string (char-before)) (append
                                                         weiss-non-stop-delimiters-list
                                                         xah-left-brackets))
                 (weiss--check-two-char nil xah-right-brackets)
                 )
        (backward-char))
      (when (member (char-to-string (char-before)) (append
                                                    xah-left-brackets
                                                    xah-right-brackets
                                                    weiss-non-stop-delimiters-list
                                                    weiss-stop-delimiters-list))
        (backward-char))   
      (when (= l (line-number-at-pos))
        (setq p (point))
        )
      )
    (goto-char p)
    )
  (push-mark nil t)

  (while (member (char-to-string (char-before)) uppercase-alphabet) (backward-char))

  (while (or (not (member (char-to-string (char-before)) (append
                                                          uppercase-alphabet
                                                          xah-left-brackets
                                                          xah-right-brackets
                                                          weiss-non-stop-delimiters-list
                                                          weiss-stop-delimiters-list)))
             ;; (weiss--check-two-char nil '("" ";" ))
             )
    (backward-char))
  (when (member  (char-to-string (char-before)) uppercase-alphabet)(backward-char))
  (setq mark-active t)
  )

(defun weiss-down-key ()
  "DOCSTRING"
  (interactive)
  (if current-prefix-arg
      (move-line-down)
    (weiss-next-line-and-select-current-word)      
    )
  )

(defun weiss-up-key ()
  "DOCSTRING"
  (interactive)
  (if current-prefix-arg
      (move-line-up)
    (weiss-previous-line-and-select-current-word)      
    )
  )

(defun weiss-next-line-and-select-current-word ()
  "weiss next line and select current word"
  (interactive)
  (deactivate-mark)
  (let ((line-number (line-number-at-pos)))
    (next-line)
    (unless (eq line-number (line-number-at-pos))
      (weiss-select-current-word) 
      )
    )
  )

(defun weiss-previous-line-and-select-current-word ()
  "weiss previous line and select current word"
  (interactive)
  (deactivate-mark)
  (previous-line)
  (weiss-select-current-word)
  )

(provide 'weiss_arrow-key<wks)
