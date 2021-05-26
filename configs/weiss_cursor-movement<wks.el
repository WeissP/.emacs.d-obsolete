(defun weiss-move-to-next-block ()
  "DOCSTRING"
  (interactive)
  (re-search-forward "\n[\t\n ]*\n+" nil "move")
  )

(defun weiss-move-to-previous-block ()
  "DOCSTRING"
  (interactive)
  (re-search-backward "\n[\t\n ]*\n+" nil "move")
  )

(defun weiss-move-to-next-punctuation ()
  "DOCSTRING"
  (interactive)
  (skip-chars-forward "[a-zA-Z\\-_]")  
  )

(defun weiss-move-to-previous-punctuation ()
  "DOCSTRING"
  (interactive)
  (skip-chars-backward "[a-zA-Z\\-_]")  
  )

(defun xah-beginning-of-line-or-block ()
  "Move cursor to beginning of line or previous paragraph.

• When called first time, move cursor to beginning of char in current line. (if already, move to beginning of line.)
• When called again, move cursor backward by jumping over any sequence of whitespaces containing 2 blank lines.

URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
Version 2018-06-04"
  (interactive)
  (let (($p (point)))
    (if (or (equal (point) (line-beginning-position))
            (eq last-command this-command))
        (if (re-search-backward "\n[\t\n ]*\n+" nil "move")
            (progn
              (skip-chars-backward "\n\t ")
              ;; (forward-char )
              )
          (goto-char (point-min)))
      (progn
        (back-to-indentation)
        (when (eq $p (point))
          (beginning-of-line))))))

(defun xah-end-of-line-or-block ()
  "Move cursor to end of line or next paragraph.

• When called first time, move cursor to end of line.
• When called again, move cursor forward by jumping over any sequence of whitespaces containing 2 blank lines.

URL `http://ergoemacs.org/emacs/emacs_keybinding_design_beginning-of-line-or-block.html'
Version 2018-06-04"
  (interactive)
  (if (or (equal (point) (line-end-position))
          (eq last-command this-command))
      (progn
        (re-search-forward "\n[\t\n ]*\n+" nil "move" ))
    (end-of-line)))

(defvar xah-brackets nil "string of left/right brackets pairs.")
(setq xah-brackets "()[]{}<>＜＞（）［］｛｝⦅⦆〚〛⦃⦄“”‘’‹›«»「」〈〉《》【】〔〕⦗⦘『』〖〗〘〙｢｣⟦⟧⟨⟩⟪⟫⟮⟯⟬⟭⌈⌉⌊⌋⦇⦈⦉⦊❛❜❝❞❨❩❪❫❴❵❬❭❮❯❰❱❲❳〈〉⦑⦒⧼⧽﹙﹚﹛﹜﹝﹞⁽⁾₍₎⦋⦌⦍⦎⦏⦐⁅⁆⸢⸣⸤⸥⟅⟆⦓⦔⦕⦖⸦⸧⸨⸩｟｠⧘⧙⧚⧛⸜⸝⸌⸍⸂⸃⸄⸅⸉⸊᚛᚜༺༻༼༽⏜⏝⎴⎵⏞⏟⏠⏡﹁﹂﹃﹄︹︺︻︼︗︘︿﹀︽︾﹇﹈︷︸")

(defvar xah-left-brackets '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«" )
  "List of left bracket chars.")
(progn
  ;; make xah-left-brackets based on xah-brackets
  (setq xah-left-brackets '())
  (dotimes ($x (- (length xah-brackets) 1))
    (when (= (% $x 2) 0)
      (push (char-to-string (elt xah-brackets $x))
            xah-left-brackets)))
  (setq xah-left-brackets (reverse xah-left-brackets)))

(defvar xah-right-brackets '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»")
  "list of right bracket chars.")
(progn
  (setq xah-right-brackets '())
  (dotimes ($x (- (length xah-brackets) 1))
    (when (= (% $x 2) 1)
      (push (char-to-string (elt xah-brackets $x))
            xah-right-brackets)))
  (setq xah-right-brackets (reverse xah-right-brackets)))

(defvar xah-punctuation-regex nil "A regex string for the purpose of moving cursor to a punctuation.")
(setq xah-punctuation-regex "[!\?\"\.,`'#$%&*+:;=@^|~]+")

(defun xah-backward-punct (&optional n)
  "Move cursor to the previous occurrence of punctuation.
  See `xah-forward-punct'

  URL `http://ergoemacs.org/emacs/emacs_jump_to_punctuations.html'
  Version 2017-06-26"
  (interactive "p")
  (re-search-backward xah-punctuation-regex nil t n))

(defun xah-forward-punct (&optional n)
  "Move cursor to the next occurrence of punctuation.
    The list of punctuations to jump to is defined by `xah-punctuation-regex'

    URL `http://ergoemacs.org/emacs/emacs_jump_to_punctuations.html'
    Version 2017-06-26"
  (interactive "p")
  (re-search-forward xah-punctuation-regex nil t n))

(defun weiss-exchange-point-or-beginning-of-line ()
  "if there is nothing or only one point selected, move to beginning-of-line , else exchange point"
  (interactive)
  (if (or (not (use-region-p))
          (< (- (region-end) (region-beginning)) 1)) 
      (progn
        (deactivate-mark)
        (beginning-of-line)
        (push-mark nil t)
        (back-to-indentation)
        (setq mark-active t)
        (weiss-select-mode-turn-on)
        )
    (exchange-point-and-mark)  
    )
  )


(defun weiss-select-current-word ()
  "select current word, if current char is not word, backward char until it's a word"
  (interactive)
  (deactivate-mark)
  ;; (if (and (not (looking-back "\\w\\|\n")) (looking-at "\n"))
  (if (or (looking-back "\\w\\|\n") (looking-at "\\w"))
      (let ((current-point (point))
            (lbpo (line-beginning-position))
            )
        (progn
          (skip-syntax-backward "\\w" (- current-point lbpo))
          (push-mark nil t)
          (skip-syntax-forward "\\w")
          ;; (forward-word)
          (setq mark-active t))        
        )
    (progn
      ;; (message "%s" "back")
      (backward-char 1)
      (weiss-select-current-word))))

(defun xah-backward-left-bracket ()
  "Weiss: move cursor to the right of left bracket, because i have two delete keys
                Move cursor to the previous occurrence of left bracket.
                The list of brackets to jump to is defined by `xah-left-brackets'.
                URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
                Version 2015-10-01"
  (interactive)
  (unless (use-region-p) (call-interactively 'set-mark-command))
  (backward-char )
  (re-search-backward (regexp-opt xah-left-brackets) nil t)
  (forward-char )
  )

(defun xah-forward-right-bracket ()
  "Weiss: move cursor to the left of right bracket, because i have two delete keys
              Move cursor to the next occurrence of right bracket.
              The list of brackets to jump to is defined by `xah-right-brackets'.
              URL `http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html'
              Version 2015-10-01"
  (interactive)
  (unless (use-region-p) (call-interactively 'set-mark-command))
  (forward-char)
  (let ((forward-search-symbols (append (list "\n" ";") xah-right-brackets)))
    (re-search-forward (regexp-opt forward-search-symbols) nil t) 
    )
  (backward-char)
  )

(defun weiss-mark-brackets ()
  "mark the nearst brackets"
  (interactive)
  (deactivate-mark)
  (cond
   ((eq last-command this-command)
    (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)
    (push-mark nil t)
    (forward-sexp)    
    )
   ((looking-at (regexp-opt xah-left-brackets))
    (push-mark nil t)
    (forward-sexp))
   ((looking-back (regexp-opt xah-right-brackets) (max (- (point) 1) 1))
    (push-mark nil t)
    (backward-sexp))
   (t
    (backward-up-list 1 'ESCAPE-STRINGS 'NO-SYNTAX-CROSSING)
    (push-mark nil t)
    (forward-sexp)
    ))
  (setq mark-active t)
  )

(provide 'weiss_cursor-movement<wks)
