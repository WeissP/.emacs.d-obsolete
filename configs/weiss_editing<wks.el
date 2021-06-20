(defun weiss-delete-current-block ()
  "DOCSTRING"
  (interactive)
  (skip-chars-forward " \n\t")
  (when (re-search-backward "\n[ \t]*\n" nil "move")
    (re-search-forward "\n[ \t]*\n"))
  (let ((pb (point))
        )
    (re-search-forward "\n[ \t]*\n" nil "move")    
    (kill-region pb (point))
    )
  )

(defun weiss-insert-space ()
  "DOCSTRING"
  (interactive)
  (save-excursion
    (insert " ")
    )
  )

(defun weiss-kill-line-backward ()
  "DOCSTRING"
  (interactive)
  (kill-region (line-beginning-position) (point))
  )

(defun weiss-deactivate-mark-and-new-line ()
  "DOCSTRING"
  (interactive)
  (deactivate-mark)
  (call-interactively 'newline)
  )

;; comes from xah-fly-key
(defun weiss-insert-pair (@left-bracket @right-bracket &optional @new-line)
  "Insert brackets around selection, word, at point, and maybe move cursor in between. If @new-line is non-nil, insert then with new line.
• if there's a region, add brackets around region.
• If cursor is at end of a word or buffer, one of the following will happen, insert brackets directly
• wrap brackets around word if any. e.g. xy▮z → (xyz▮). Or just (▮)
"
  (if (use-region-p)
      (progn ; there's active region
        (let (
              ($p1 (region-beginning))
              ($p2 (region-end)))
          (goto-char $p2)
          (when @new-line (insert "\n"))
          (insert @right-bracket)
          (goto-char $p1)
          (insert @left-bracket)
          (when @new-line (insert "\n"))
          (goto-char (+ 1 $p2 (length @left-bracket)))
          (when @new-line
            (insert "\n")
            (indent-region $p1 $p2)
            (indent-according-to-mode)
            )
          (goto-char $p1)
          )
        )
    (progn ; no text selection
      (let ($p1 $p2)
        (cond
         ((or ; cursor is not around "word"
           (not (looking-back "[w_\\-]"))
           (looking-at "[^-_[:alnum:]]")
           (eq (point) (point-max)))
          (progn
            (setq $p1 (point) $p2 (point))
            (if @new-line
                (insert @left-bracket "\n\n" @right-bracket)
              (insert @left-bracket @right-bracket)  
              )            
            (search-backward @right-bracket)
            (when @new-line (previous-line))
            ))
         (t (progn
              ;; wrap around “word”. basically, want all alphanumeric, plus hyphen and underscore, but don't want space or punctuations. Also want chinese chars
              (skip-chars-backward "-_[:alnum:]")
              (setq $p1 (point))
              (skip-chars-forward "-_[:alnum:]")
              (setq $p2 (point))
              (goto-char $p2)
              (when @new-line (insert "\n"))
              (insert @right-bracket)
              (goto-char $p1)
              (insert @left-bracket)
              (when @new-line (insert "\n"))
              (goto-char (+ $p2 (length @left-bracket)))))))))
  )



(defun xah-reformat-whitespaces-to-one-space (@begin @end)
  "Replace whitespaces by one space.

  URL `http://ergoemacs.org/emacs/emacs_reformat_lines.html'
  Version 2017-01-11"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region @begin @end)
      (goto-char (point-min))
      (while
          (search-forward "\n" nil "move")
        (replace-match " "))
      (goto-char (point-min))
      (while
          (search-forward "\t" nil "move")
        (replace-match " "))
      (goto-char (point-min))
      (while
          (re-search-forward "  +" nil "move")
        (replace-match " ")))))

(defun xah-reformat-to-multi-lines ( &optional @begin @end @min-length)
  "Replace spaces by a newline at places so lines are not long.
  When there is a text selection, act on the selection, else, act on a text block separated by blank lines.

  If `universal-argument' is called first, use the number value for min length of line. By default, it's 70.

  URL `http://ergoemacs.org/emacs/emacs_reformat_lines.html'
  Version 2018-12-16"
  (interactive)
  (let (
        $p1 $p2
        ($blanks-regex "\n[ \t]*\n")
        ($minlen (if @min-length
                     @min-length
                   (if current-prefix-arg (prefix-numeric-value current-prefix-arg) fill-column))))
    (if (and  @begin @end)
        (setq $p1 @begin $p2 @end)
      (if (region-active-p)
          (progn (setq $p1 (region-beginning) $p2 (region-end)))
        (save-excursion
          (if (re-search-backward $blanks-regex nil "move")
              (progn (re-search-forward $blanks-regex)
                     (setq $p1 (point)))
            (setq $p1 (point)))
          (if (re-search-forward $blanks-regex nil "move")
              (progn (re-search-backward $blanks-regex)
                     (setq $p2 (point)))
            (setq $p2 (point))))))
    (save-excursion
      (save-restriction
        (narrow-to-region $p1 $p2)
        (goto-char (point-min))
        (while
            (re-search-forward " +" nil "move")
          (when (> (- (point) (line-beginning-position)) $minlen)
            (replace-match "\n" )))))))
(defun xah-space-to-newline ()
  "Replace space sequence to a newline char.
Works on current block or selection.

URL `http://ergoemacs.org/emacs/emacs_space_to_newline.html'
Version 2017-08-19"
  (interactive)
  (let* ( $p1 $p2 )
    (if (use-region-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (save-excursion
        (if (re-search-backward "\n[ \t]*\n" nil "move")
            (progn (re-search-forward "\n[ \t]*\n")
                   (setq $p1 (point)))
          (setq $p1 (point)))
        (re-search-forward "\n[ \t]*\n" nil "move")
        (skip-chars-backward " \t\n" )
        (setq $p2 (point))))
    (save-excursion
      (save-restriction
        (narrow-to-region $p1 $p2)
        (goto-char (point-min))
        (while (re-search-forward " +" nil t)
          (replace-match "\n" ))))))

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun weiss-insert-semicolon ()
  "insert semicolon at the end of line"
  (interactive)
  (deactivate-mark)
  (end-of-line)
  (insert ";")
  (weiss-indent-nearby-lines)
  )

(defun weiss-indent-paragraph()
  (interactive)
  (save-excursion
    (let ((beg)
          (end)
          (continue t)
          )
      (if (use-region-p)
          (setq beg (region-beginning)
                end (region-end))        
        (backward-paragraph)
        (setq beg (point))
        (forward-paragraph)
        (forward-paragraph)
        (setq end (point))
        )
      (goto-char beg)
      (indent-region-line-by-line beg end)
      )
    )  
  )

(defun weiss-convert-sql-output-to-table ()
  "DOCSTRING"
  (interactive)
  (when (use-region-p)
    (let* ((output (delete-and-extract-region (region-beginning) (region-end)))
           (outputList (split-string output "\n"))
           (r ""))
      (insert (dolist (x outputList r)
                (when (> (length x) 3) (setq r (format "%s\n|%s|" r x)))))
      )
    (when (eq major-mode 'org-mode) (org-table-align))
    )
  )

(defun weiss-move-next-bracket-contents ()
  "Move next () to the left to the )"
  (interactive)
  (let ((insert-point)
        (bracket-beginning-point)
        (bracket-end-point))
    (search-forward ")")
    (setq insert-point (point))
    (search-forward "(")
    (backward-char)
    (setq bracket-beginning-point (point))
    (forward-sexp)
    (setq bracket-end-point (point))
    (goto-char (- insert-point 1))
    (insert (delete-and-extract-region bracket-beginning-point bracket-end-point))))

(defun xah-delete-blank-lines ()
  "Delete all newline around cursor.

        URL `http://ergoemacs.org/emacs/emacs_shrink_whitespace.html'
        Version 2018-04-02"
  (interactive)
  (let ($p3 $p4)
    (skip-chars-backward "\n")
    (setq $p3 (point))
    (skip-chars-forward "\n")
    (setq $p4 (point))
    (delete-region $p3 $p4)))

(defun xah-fly-delete-spaces ()
  "Delete space, tab, IDEOGRAPHIC SPACE (U+3000) around cursor.
          Version 2019-06-13"
  (interactive)
  (let (p1 p2)
    (skip-chars-forward " \t　")
    (setq p2 (point))
    (skip-chars-backward " \t　")
    (setq p1 (point))
    (delete-region p1 p2)))

(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
            When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region').

            URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
            Version 2015-06-10"
  (interactive)
  (if current-prefix-arg
      (progn ; not using kill-region because we don't want to include previous kill
        (kill-new (buffer-string))
        (delete-region (point-min) (point-max)))
    (progn (if (use-region-p)
               (kill-region (region-beginning) (region-end) t)
             (kill-region (line-beginning-position) (line-beginning-position 2))))))

(defun xah-delete-backward-char-or-bracket-text ()
  "Delete backward 1 character, but if it's a \"quote\" or bracket ()[]{}【】「」 etc, delete bracket and the inner text, push the deleted text to `kill-ring'.

              What char is considered bracket or quote is determined by current syntax table.

              If `universal-argument' is called first, do not delete inner text.

              URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
              Version 2017-07-02"
  (interactive)
  (if (and delete-selection-mode (region-active-p))
      (kill-region (region-beginning) (region-end))
    (cond
     ((looking-back "\\s)" 1)
      (if current-prefix-arg
          (xah-delete-backward-bracket-pairs)
        (xah-delete-backward-bracket-text)))
     ((looking-back "\\s(" 1)
      (progn
        (backward-char)
        (forward-sexp)
        (if current-prefix-arg
            (xah-delete-backward-bracket-pairs)
          (xah-delete-backward-bracket-text))))
     ((looking-back "\\s\"" 1)
      (if (nth 3 (syntax-ppss))
          (progn
            (backward-char )
            (xah-delete-forward-bracket-pairs (not current-prefix-arg)))
        (if current-prefix-arg
            (xah-delete-backward-bracket-pairs)
          (xah-delete-backward-bracket-text))))
     (t
      (delete-char -1)))))

(defun xah-delete-backward-bracket-text ()
  "Delete the matching brackets/quotes to the left of cursor, including the inner text.

              This command assumes the left of cursor is a right bracket, and there's a matching one before it.

              What char is considered bracket or quote is determined by current syntax table.

              URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
              Version 2017-09-21"
  (interactive)
  (progn
    (forward-sexp -1)
    (mark-sexp)
    (kill-region (region-beginning) (region-end))))

(defun xah-delete-forward-bracket-text ()
  "weiss: backward to forward.
              Delete the matching brackets/quotes to the left of cursor, including the inner text.

              This command assumes the left of cursor is a right bracket, and there's a matching one before it.

              What char is considered bracket or quote is determined by current syntax table.

              URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
              Version 2017-09-21"
  (interactive)
  (progn
    (backward-char)
    (mark-sexp)
    (kill-region (region-beginning) (region-end))))

(defun xah-delete-backward-bracket-pairs ()
  "Delete the matching brackets/quotes to the left of cursor.

              After the command, mark is set at the left matching bracket position, so you can `exchange-point-and-mark' to select it.

              This command assumes the left of point is a right bracket, and there's a matching one before it.

              What char is considered bracket or quote is determined by current syntax table.

              URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
              Version 2017-07-02"
  (interactive)
  (let (( $p0 (point)) $p1)
    (forward-sexp -1)
    (setq $p1 (point))
    (goto-char $p0)
    (delete-char -1)
    (goto-char $p1)
    (delete-char 1)
    (push-mark (point) t)
    (setq mark-active t)
    (setq deactivate-mark nil)
    (goto-char (- $p0 2))))

(defun xah-delete-forward-bracket-pairs ( &optional @delete-inner-text-p)
  "Delete the matching brackets/quotes to the right of cursor.
              If @delete-inner-text-p is true, also delete the inner text.

              After the command, mark is set at the left matching bracket position, so you can `exchange-point-and-mark' to select it.

              This command assumes the char to the right of point is a left bracket or quote, and have a matching one after.

              What char is considered bracket or quote is determined by current syntax table.

              URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
              Version 2017-07-02"
  (interactive)
  (if @delete-inner-text-p
      (progn
        (mark-sexp)
        (kill-region (region-beginning) (region-end)))
    (let (($pt (point)))
      (forward-sexp)
      (delete-char -1)
      (push-mark (point) t)
      (goto-char $pt)
      (delete-char 1)
      (setq mark-active t)
      (setq deactivate-mark nil))))

(defun xah-delete-forward-char-or-bracket-text ()
  "weiss: change backward to forward. 
              Delete backward 1 character, but if it's a \"quote\" or bracket ()[]{}【】「」 etc, delete bracket and the inner text, push the deleted text to `kill-ring'.

              What char is considered bracket or quote is determined by current syntax table.

              If `universal-argument' is called first, do not delete inner text.

              URL `http://ergoemacs.org/emacs/emacs_delete_backward_char_or_bracket_text.html'
              Version 2017-07-02"
  (interactive)
  (if (and delete-selection-mode (region-active-p))
      (kill-region (region-beginning) (region-end))
    (cond
     ((looking-at "\\s(")
      (if current-prefix-arg
          (xah-delete-forward-bracket-pairs)
        (forward-char)
        (xah-delete-forward-bracket-text)))
     ((looking-at "\\s)")
      (progn
        (forward-char)
        ;; (backward-sexp)
        (if current-prefix-arg
            (xah-delete-backward-bracket-pairs)
          (xah-delete-backward-bracket-text))))
     ((looking-at "\\s\"")
      (if (nth 3 (syntax-ppss))
          (progn
            (forward-char)
            (if current-prefix-arg
                (xah-delete-backward-bracket-pairs)
              (xah-delete-backward-bracket-text))
            )
        (if current-prefix-arg
            (xah-delete-forward-bracket-pairs)
          (forward-char)
          (xah-delete-forward-bracket-text))))
     (t
      (delete-char 1)))))

(defun xah-fill-or-unfill ()
  "Reformat current paragraph or region to `fill-column', like `fill-paragraph' or “unfill”.
                When there is a text selection, act on the selection, else, act on a text block separated by blank lines.
                URL `http://ergoemacs.org/emacs/modernization_fill-paragraph.html'
                Version 2017-01-08"
  (interactive)
  ;; This command symbol has a property “'compact-p”, the possible values are t and nil. This property is used to easily determine whether to compact or uncompact, when this command is called again
  (let ( ($compact-p
          (if (eq last-command this-command)
              (get this-command 'compact-p)
            (> (- (line-end-position) (line-beginning-position)) fill-column)))
         (deactivate-mark nil)
         ($blanks-regex "\n[ \t]*\n")
         $p1 $p2
         )
    (if (use-region-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (save-excursion
        (if (re-search-backward $blanks-regex nil "move")
            (progn (re-search-forward $blanks-regex)
                   (setq $p1 (point)))
          (setq $p1 (point)))
        (if (re-search-forward $blanks-regex nil "move")
            (progn (re-search-backward $blanks-regex)
                   (setq $p2 (point)))
          (setq $p2 (point)))))
    (if $compact-p
        (fill-region $p1 $p2)
      (let ((fill-column most-positive-fixnum ))
        (fill-region $p1 $p2)))
    (put this-command 'compact-p (not $compact-p))))

(defun xah-toggle-previous-letter-case ()
  "Toggle the letter case of the letter to the left of cursor.
                  URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
                  Version 2015-12-22"
  (interactive)
  (let ((case-fold-search nil))
    (left-char 1)
    (cond
     ((looking-at "[[:lower:]]") (upcase-region (point) (1+ (point))))
     ((looking-at "[[:upper:]]") (downcase-region (point) (1+ (point)))))
    (right-char)))

(defun weiss-delete-parent-sexp ()
  "Keep the current sexp and delete it's parent sexp"
  (interactive)
  (let ((start-pos)
        (end-pos)
        (insert-string)
        )
    (if (use-region-p)
        (setq start-pos (region-beginning)
              end-pos (region-end))
      (setq start-pos (car (bounds-of-thing-at-point 'list))
            end-pos (cdr (bounds-of-thing-at-point 'list))))
    (setq insert-string (delete-and-extract-region start-pos end-pos))
    (delete-region (car (bounds-of-thing-at-point 'list)) (cdr (bounds-of-thing-at-point 'list)))
    (insert insert-string)))

(defun weiss-add-parent-sexp ()
  "Wrap () to the selected region or the current sexp"
  (interactive)
  (let ((cursor-position)
        (start-pos)
        (end-pos))
    (if (use-region-p)
        (setq cursor-position (region-beginning)
              start-pos (region-beginning)
              end-pos (region-end))
      (let ((bounds (bounds-of-thing-at-point 'list)))
        (setq cursor-position (car bounds)
              start-pos (car bounds)
              end-pos (cdr bounds))))
    (insert (format "( %s)" (delete-and-extract-region start-pos end-pos)))
    (goto-char (1+ cursor-position))
    (wks-vanilla-mode 1)
    ))

(defun weiss-delete-or-add-parent-sexp ()
  "DOCSTRING"
  (interactive)
  (if current-prefix-arg
      (weiss-add-parent-sexp)
    (weiss-delete-parent-sexp)
    ))


(defun weiss-cut-line-or-delete-region ()
  "Cut line or delete region"
  (interactive)
  (weiss-select-mode-turn-off)
  (if current-prefix-arg
      (delete-char -1)
    (xah-cut-line-or-region)))

(defun xah-reformat-lines (&optional @length)
  "Reformat current text block into 1 long line or multiple short lines.
                    When there is a text selection, act on the selection, else, act on a text block separated by blank lines.

                    When the command is called for the first time, it checks the current line's length to decide to go into 1 line or multiple lines. If current line is short, it'll reformat to 1 long lines. And vice versa.

                    Repeated call toggles between formatting to 1 long line and multiple lines.

                    If `universal-argument' is called first, use the number value for min length of line. By default, it's 70.

                    URL `http://ergoemacs.org/emacs/emacs_reformat_lines.html'
                    Version 2019-06-09"
  (interactive)
  ;; This command symbol has a property “'is-longline-p”, the possible values are t and nil. This property is used to easily determine whether to compact or uncompact, when this command is called again
  (let* (
         (@length (if @length
                      @length
                    (if current-prefix-arg (prefix-numeric-value current-prefix-arg) fill-column )))
         (is-longline-p
          (if (eq last-command this-command)
              (get this-command 'is-longline-p)
            (> (- (line-end-position) (line-beginning-position)) @length)))
         ($blanks-regex "\n[ \t]*\n")
         $p1 $p2
         )
    (if (use-region-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (save-excursion
        (if (re-search-backward $blanks-regex nil "move")
            (progn (re-search-forward $blanks-regex)
                   (setq $p1 (point)))
          (setq $p1 (point)))
        (if (re-search-forward $blanks-regex nil "move")
            (progn (re-search-backward $blanks-regex)
                   (setq $p2 (point)))
          (setq $p2 (point)))))
    (progn
      (if current-prefix-arg
          (xah-reformat-to-multi-lines $p1 $p2 @length)
        (if is-longline-p
            (xah-reformat-to-multi-lines $p1 $p2 @length)
          (xah-reformat-whitespaces-to-one-space $p1 $p2)))
      (put this-command 'is-longline-p (not is-longline-p)))))

(defun xah-escape-quotes (@begin @end)
  "Replace 「\"」 by 「\\\"」 in current line or text selection.
                      See also: `xah-unescape-quotes'

                      URL `http://ergoemacs.org/emacs/elisp_escape_quotes.html'
                      Version 2017-01-11"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-end-position))))
  (save-excursion
    (save-restriction
      (narrow-to-region @begin @end)
      (goto-char (point-min))
      (while (search-forward "\"" nil t)
        (replace-match "\\\"" "FIXEDCASE" "LITERAL")))))

(defun weiss-remove-empty-lines ()
  "DOCSTRING"
  (interactive)
  (flush-lines "^\\s-*$")
  )


(defun xah-clean-whitespace ()
  "Delete trailing whitespace, and replace repeated blank lines to just 1.
                        Only space and tab is considered whitespace here.
                        Works on whole buffer or text selection, respects `narrow-to-region'.

                        URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
                        Version 2017-09-22"
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "[ \t]+\n" nil "move")
            (replace-match "\n")))
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))
        (progn
          (goto-char (point-max))
          (while (equal (char-before) 32) ; char 32 is space
            (delete-char -1))))
      (message "white space cleaned"))))

(defun weiss-insert-date()
  "When the time now is 0-4 AM, insert yesterday's date"
  (interactive)
  (if (weiss-is-today)
      (let ((date (format "%s%s" (- (string-to-number (format-time-string "%d")) 1) (format-time-string ".%m.%Y"))))
        (if (< (length date) 10)
            (insert (concat "0" date))
          (insert date)))
    (insert (format-time-string "%0d.%m.%Y"))))


(defun weiss-comment-dwim ()
  "in weiss-select-mode  -> comment region
                            with prefix-arg  -> add comment at end of line and activate insert mode
                            t -> comment current line"
  (interactive)
  (if current-prefix-arg
      (progn
        (end-of-line)
        (comment-dwim nil)
        (wks-vanilla-mode))
    (let (($lbp (line-beginning-position))
          ($lep (line-end-position)))
      (if (and (region-active-p)
               (string-match "\n" (buffer-substring-no-properties (region-beginning) (region-end))))
          (comment-dwim nil)
        (if (eq $lbp $lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region $lbp $lep)
            (forward-line ))))
      ))
  )

(defun weiss-comment-downward ()
  "DOCSTRING"
  (interactive)
  (let ((beg (point))
        (commented (comment-only-p (line-beginning-position) (line-end-position)))
        (continue t)
        end 
        )    
    (while (and continue (eq commented (comment-only-p (line-beginning-position) (line-end-position))))
      (forward-line)
      (when (or (weiss-line-empty-p)
                (eq (line-end-position) (point-max)))
        (setq continue nil))
      )    
    (previous-line)    
    (setq end (line-end-position))
    (comment-or-uncomment-region beg end)
    )
  )

(defun xah-shrink-whitespaces ()
  "Remove whitespaces around cursor to just one, or none.

                              Shrink any neighboring space tab newline characters to 1 or none.
                              If cursor neighbor has space/tab, toggle between 1 or 0 space.
                              If cursor neighbor are newline, shrink them to just 1.
                              If already has just 1 whitespace, delete it.

                              URL `http://ergoemacs.org/emacs/emacs_shrink_whitespace.html'
                              Version 2019-06-13"
  (interactive)
  (let* (
         ($eol-count 0)
         ($p0 (point))
         $p1 ; whitespace begin
         $p2 ; whitespace end
         ($charBefore (char-before))
         ($charAfter (char-after ))
         ($space-neighbor-p (or (eq $charBefore 32) (eq $charBefore 9) (eq $charAfter 32) (eq $charAfter 9)))
         $just-1-space-p
         )
    (skip-chars-backward " \n\t　")
    (setq $p1 (point))
    (goto-char $p0)
    (skip-chars-forward " \n\t　")
    (setq $p2 (point))
    (goto-char $p1)
    (while (search-forward "\n" $p2 t )
      (setq $eol-count (1+ $eol-count)))
    (setq $just-1-space-p (eq (- $p2 $p1) 1))
    (goto-char $p0)
    (cond
     ((eq $eol-count 0)
      (if $just-1-space-p
          (xah-fly-delete-spaces)
        (progn (xah-fly-delete-spaces)
               (insert " ")))
      )
     ((eq $eol-count 1)
      (if $space-neighbor-p
          (xah-fly-delete-spaces)
        (progn (xah-delete-blank-lines) (insert " "))))
     ((eq $eol-count 2)
      (if $space-neighbor-p
          (xah-fly-delete-spaces)
        (progn
          (xah-delete-blank-lines)
          (insert "\n"))))
     ((> $eol-count 2)
      (if $space-neighbor-p
          (xah-fly-delete-spaces)
        (progn
          (goto-char $p2)
          (search-backward "\n" )
          (delete-region $p1 (point))
          (insert "\n"))))
     (t (progn
          (message "nothing done. logic error 40873. shouldn't reach here" ))))))

(defun xah-paste-or-paste-previous ()
  "Paste. When called repeatedly, paste previous.
                              This command calls `yank', and if repeated, call `yank-pop'.

                              When `universal-argument' is called first with a number arg, paste that many times.

                              URL `http://ergoemacs.org/emacs/emacs_paste_or_paste_previous.html'
                              Version 2017-07-25"
  (interactive)
  (progn
    (when (and delete-selection-mode (region-active-p))
      (delete-region (region-beginning) (region-end)))
    (if current-prefix-arg
        (progn
          (dotimes (_ (prefix-numeric-value current-prefix-arg))
            (yank)))
      (if (eq real-last-command this-command)
          (yank-pop 1)
        (yank)))))

(defun weiss-delete-parent-sexp ()
  "Keep the current sexp and delete it's parent sexp"
  (interactive)
  (let ((start-pos)
        (end-pos)
        (insert-string)
        )
    (if (use-region-p)
        (setq start-pos (region-beginning)
              end-pos (region-end))
      (setq start-pos (car (bounds-of-thing-at-point 'list))
            end-pos (cdr (bounds-of-thing-at-point 'list))))
    (setq insert-string (delete-and-extract-region start-pos end-pos))
    (delete-region (car (bounds-of-thing-at-point 'list)) (cdr (bounds-of-thing-at-point 'list)))
    (insert insert-string)))

(defun weiss-delete-forward-with-region ()
  "Like xah delete forward char or bracket text, but ignore region"
  (interactive)
  (deactivate-mark)
  (cond
   ((eq major-mode 'org-mode) 
    (while (and (string= (char-to-string (char-after)) " ")
                (not (weiss--check-two-char t '(" ") weiss-org-special-markers)))
      (delete-char 1))
    (when (weiss--check-two-char t '(" ") weiss-org-special-markers) (forward-char))
    (if current-prefix-arg
        (weiss-delete-forward-bracket-and-mark-bracket-text-org-mode)
      (weiss-delete-forward-bracket-and-text-org-mode))
    )
   ((eq major-mode 'latex-mode)
    (while (and (string= (char-to-string (char-after)) " ")
                (not (weiss--check-two-char t '(" ") weiss-org-special-markers)))
      (delete-char 1))
    (when (weiss--check-two-char t '(" ") weiss-org-special-markers) (forward-char))
    (weiss-delete-forward-bracket-and-mark-bracket-text-latex-mode))
   (t
    (while (string= (char-to-string (char-after)) " ") (delete-char 1))
    (xah-delete-forward-char-or-bracket-text))
   )
  )

(defun weiss-insert-line()
  (interactive)
  (end-of-line)
  (insert "
                                    ")
  (indent-according-to-mode)
  )

(defun weiss-before-insert-mode ()
  "if cursor is at the begining of line, then jump to the indent position. Insert space right side if with prefix-arg"
  (interactive)
  (deactivate-mark)
  (if current-prefix-arg
      (progn
        (insert " ")
        (left-char)
        )
    (when (and (eq (point) (line-beginning-position))
               (derived-mode-p 'prog-mode))
      (indent-according-to-mode))    
    )
  )


(defun weiss-delete-backward-with-region ()
  "Like xah delete backward char or bracket text, but ignore region"
  (interactive)
  (deactivate-mark)
  (while (string= (char-to-string (char-before)) " ") (delete-char -1))
  (cond
   ((eq major-mode 'org-mode) 
    (if current-prefix-arg
        (weiss-delete-backward-bracket-and-mark-bracket-text-org-mode)
      (weiss-delete-backward-bracket-and-text-org-mode)
      ))
   ((eq major-mode 'latex-mode)
    (weiss-delete-backward-bracket-and-mark-bracket-text-latex-mode))
   (t (xah-delete-backward-char-or-bracket-text))
   )
  )

(defun weiss-downcase-region ()
  "DOCSTRING"
  (interactive)
  (let (
        (deactivate-mark nil)
        $p1 $p2)
    (if (use-region-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (save-excursion
        (skip-chars-backward "0-9A-Za-z")
        (setq $p1 (point))
        (skip-chars-forward "0-9A-Za-z")
        (setq $p2 (point))))
    (downcase-region $p1 $p2))
  )

(defun xah-toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
                                      Always cycle in this order: Init Caps, ALL CAPS, all lower.

                                      URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
                                      Version 2019-11-24"
  (interactive)
  (let (
        (deactivate-mark nil)
        $p1 $p2)
    (if (use-region-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (save-excursion
        (skip-chars-backward "0-9A-Za-z")
        (setq $p1 (point))
        (skip-chars-forward "0-9A-Za-z")
        (setq $p2 (point))))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region $p1 $p2)
      (put this-command 'state 1))
     ((equal 1 (get this-command 'state))
      (upcase-region $p1 $p2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region $p1 $p2)
      (upcase-initials-region $p1 $p2)
      (put this-command 'state 1)))))

(defun weiss-indent-nearby-lines ()
  "DOCSTRING"
  (interactive)
  (indent-region (- (point) 20) (+ (point) 20)))

(defun weiss-open-line-and-indent ()
  "open line and indent"
  (interactive)
  (beginning-of-line)
  (open-line 1)
  )

(defun weiss-indent()
  (interactive)
  (if (use-region-p)
      (progn
        (indent-region-line-by-line (region-beginning) (region-end))
        ;; (ignore-errors (nox-format))
        )
    (cond
     ((eq major-mode 'c++-mode)
      (deactivate-mark)
      (indent-region-line-by-line (point-min) (point-max))
      )
     ;; ((ignore-errors is-nox-activate-p)
     ;; (nox-format))
     ((eq major-mode 'mhtml-mode)
      (deactivate-mark)
      (web-beautify-html-buffer)
      )
     ((eq major-mode 'haskell-mode)
      (ormolu-format-buffer))
     ((eq major-mode 'go-mode)
      (gofmt))
     ((eq major-mode 'python-mode)
      (indent-region (point-min) (point-max))
      (yapfify-buffer))
     (t
      (deactivate-mark)
      (indent-region (point-min) (point-max)))
     )
    (ignore-errors (flycheck-buffer))
    ))

(defun weiss-paste-with-linebreak()
  (interactive)
  (beginning-of-line)
  (progn
    (when (and delete-selection-mode (region-active-p))
      (delete-region (region-beginning) (region-end)))
    (if current-prefix-arg
        (progn
          ;; (open-line 1)
          (dotimes (_ (prefix-numeric-value current-prefix-arg))
            (progn (yank) (newline)) )
          ;; (yank)
          )
      (if (eq real-last-command this-command)
          (progn (yank-pop 1)) 
        (progn (open-line 1)  (yank)))))
  (if (eq major-mode 'org-mode) nil (weiss-indent))
  )


(defun xah-cycle-hyphen-underscore-space ( &optional @begin @end )
  "Cycle {underscore, space, hyphen} chars in selection or inside quote/bracket or line.
                                          When called repeatedly, this command cycles the {“_”, “-”, “ ”} characters, in that order.

                                          The region to work on is by this order:
                                           ① if there's active region (text selection), use that.
                                           ② If cursor is string quote or any type of bracket, and is within current line, work on that region.
                                           ③ else, work on current line.

                                          URL `http://ergoemacs.org/emacs/elisp_change_space-hyphen_underscore.html'
                                          Version 2019-02-12"
  (interactive)
  ;; this function sets a property 「'state」. Possible values are 0 to length of $charArray.
  (let ($p1 $p2)
    (if (and @begin @end)
        (progn (setq $p1 @begin $p2 @end))
      (if (use-region-p)
          (setq $p1 (region-beginning) $p2 (region-end))
        (if (nth 3 (syntax-ppss))
            (save-excursion
              (skip-chars-backward "^\"")
              (setq $p1 (point))
              (skip-chars-forward "^\"")
              (setq $p2 (point)))
          (let (
                ($skipChars
                 (if (boundp 'xah-brackets)
                     (concat "^\"" xah-brackets)
                   "^\"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）")))
            (skip-chars-backward $skipChars (line-beginning-position))
            (setq $p1 (point))
            (skip-chars-forward $skipChars (line-end-position))
            (setq $p2 (point))
            (set-mark $p1)))))
    (let* (
           ($charArray ["_" "-" " "])
           ($length (length $charArray))
           ($regionWasActive-p (region-active-p))
           ($nowState
            (if (eq last-command this-command)
                (get 'xah-cycle-hyphen-underscore-space 'state)
              0 ))
           ($changeTo (elt $charArray $nowState)))
      (save-excursion
        (save-restriction
          (narrow-to-region $p1 $p2)
          (goto-char (point-min))
          (while
              (re-search-forward
               (elt $charArray (% (+ $nowState 2) $length))
               ;; (concat
               ;;  (elt $charArray (% (+ $nowState 1) $length))
               ;;  "\\|"
               ;;  (elt $charArray (% (+ $nowState 2) $length)))
               (point-max)
               "move")
            (replace-match $changeTo "FIXEDCASE" "LITERAL"))))
      (when (or (string= $changeTo " ") $regionWasActive-p)
        (goto-char $p2)
        (set-mark $p1)
        (setq deactivate-mark nil))
      (put 'xah-cycle-hyphen-underscore-space 'state (% (+ $nowState 1) $length)))))

(provide 'weiss_editing<wks)
