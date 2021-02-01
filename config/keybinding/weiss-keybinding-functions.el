;; -*- lexical-binding: t -*-
;; editing

;; [[file:../emacs-config.org::*editing][editing:1]]
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
  (end-of-line)
  (insert ";")
  (weiss-indent-nearby-lines)
  )

(defun weiss-indent-paragraph()
  (interactive)
  (if (use-region-p)
      (progn
        (indent-region (region-beginning) (region-end))
        )
    (let ((start)
          (end))            
      (setq start (save-excursion
                    (backward-paragraph)
                    (point))
            end (save-excursion
                  (forward-paragraph)
                  (point)))
      (ignore-errors (nox-format))
      (indent-region start end)
      )    
    ))

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
    (ryo-modal-mode -1)
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
        (ryo-modal-mode -1))
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
      (put this-command 'state 0)))))

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
        (indent-region (region-beginning) (region-end))
        ;; (ignore-errors (nox-format))
        )
    (cond
     ;; ((ignore-errors is-nox-activate-p)
     ;; (nox-format))
     ((eq major-mode 'mhtml-mode)
      (deactivate-mark)
      (web-beautify-html-buffer)
      )
     ((eq major-mode 'go-mode)
      (gofmt))
     ((eq major-mode 'python-mode)
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
;; editing:1 ends here

;; kmacro

;; [[file:../emacs-config.org::*kmacro][kmacro:1]]
(defvar weiss/kmacro-info nil)

(defun weiss-call-kmacro ()
  "call kmacro once"
  (interactive)
  (weiss-before-kmacro)
  (call-interactively 'call-last-kbd-macro)
  )

(defun weiss-call-kmacro-infinite ()
  "call kmacro up to error"
  (interactive)
  (undo-collapse-begin)
  (call-last-kbd-macro 0 #'weiss-before-kmacro)
  (undo-collapse-end)
  )

(defun weiss-call-kmacro-dwim ()
  "DOCSTRING"
  (interactive)
  (undo-collapse-begin)
  (ignore-errors (shiftless-mode -1))
  (let ((echo-keystrokes nil)
        (single-line (eq
                      (line-number-at-pos (region-beginning))
                      (line-number-at-pos (region-end))))
        )
    (if single-line
        (call-last-kbd-macro 1 #'weiss-before-kmacro)
      (save-restriction
        (narrow-to-region (region-beginning) (region-end))
        (goto-char (point-min))
        (call-last-kbd-macro 999 #'weiss-before-kmacro)
        )
      )
    (ignore-errors (shiftless-mode 1))
    ))

(defun weiss-before-kmacro ()
  "go next line or search word according to weiss/kmacro-info"
  (interactive)
  (cond
   ((stringp (car weiss/kmacro-info))
    (let ((p (search-forward (car weiss/kmacro-info) nil t))
          )
      (when p
        (goto-char (- p (cdr weiss/kmacro-info)))
        )
      p)
    )
   ((numberp (cdr weiss/kmacro-info))
    (forward-line 1)
    (goto-char (+ (line-beginning-position) (cdr weiss/kmacro-info)))
    (not (eq (line-end-position) (point-max)))
    )
   (t t)
   )
  )

(defun weiss-start-kmacro ()
  "DOCSTRING"
  (interactive)
  (unless (or executing-kbd-macro defining-kbd-macro)
    (let ((current-prefix-arg)
          )
      (setq
       weiss/kmacro-info
       (if (use-region-p)
           (let ((b (region-beginning))
                 (e (region-end))
                 )
             (deactivate-mark)
             `(,(buffer-substring-no-properties b e)
               . ,(- e (point)))
             )
         `(nil . ,(- (point) (line-beginning-position)))
         ))))
  (call-interactively 'kmacro-start-macro-or-insert-counter)
  )

(defun weiss-end-kmacro ()
  "end kmacro and call hydra"
  (interactive)
  (when defining-kbd-macro
    (call-interactively 'kmacro-end-macro)
    )
  (hydra-kmacro/body)
  )

(defun weiss-apply-macro-1 ()
  "apply kmacro 1 times"
  (interactive)
  (call-last-kbd-macro 1 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-2 ()
  "apply kmacro 2 times"
  (interactive)
  (call-last-kbd-macro 2 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-3 ()
  "apply kmacro 3 times"
  (interactive)
  (call-last-kbd-macro 3 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-4 ()
  "apply kmacro 4 times"
  (interactive)
  (call-last-kbd-macro 4 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-5 ()
  "apply kmacro 5 times"
  (interactive)
  (call-last-kbd-macro 5 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-6 ()
  "apply kmacro 6 times"
  (interactive)
  (call-last-kbd-macro 6 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-7 ()
  "apply kmacro 7 times"
  (interactive)
  (call-last-kbd-macro 7 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-8 ()
  "apply kmacro 8 times"
  (interactive)
  (call-last-kbd-macro 8 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-9 ()
  "apply kmacro 9 times"
  (interactive)
  (call-last-kbd-macro 9 #'weiss-before-kmacro)
  )
(defun weiss-apply-macro-0 ()
  "apply kmacro 10 times"
  (interactive)
  (call-last-kbd-macro 10 #'weiss-before-kmacro)
  )
;; kmacro:1 ends here

;; cursor movement

;; [[file:../emacs-config.org::*cursor movement][cursor movement:1]]
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

(defun weiss-exange-point-or-beginning-of-line ()
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

(defun weiss-mark-brackets ()
  "DOCSTRING"
  (interactive)
  ;; (re-search-forward (regexp-opt xah-right-brackets) nil t)
  (when (eq last-command this-command)
    (when-let ((p1 (region-beginning))
               (p2 (region-end))
               (rb1 (save-excursion (re-search-backward (regexp-opt xah-left-brackets) nil t)))
               )

      )
    )
  (right-char 1)
  (re-search-forward (regexp-opt xah-right-brackets) nil t)
  ;; (left-char 1)
  (push-mark nil t)
  (xah-goto-matching-bracket)
  (setq mark-active t)
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

    (weiss-forward-and-select-word)))

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
    (weiss-backward-and-select-word)
    ))

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
;; cursor movement:1 ends here

;; buffer/frame switching

;; [[file:../emacs-config.org::*buffer/frame switching][buffer/frame switching:1]]
(defvar weiss-right-frame-pos 1690 "the position of left bord of right frame")
(defvar weiss-is-laptop nil)

;; (car (frame-edges))
;; (frame-width)
;; (frame-height)

(defvar weiss-desktop-left-frame-alist
  '((tool-bar-lines . 0)
    (width . 104) ; chars
    (height . 48) ; lines
    (left . 1680)
    (top . 0)))

(defvar weiss-desktop-right-frame-alist
  '((tool-bar-lines . 0)
    (width . 104) ; chars
    (height . 48) ; lines
    (left . 2639)
    (top . 0)))

(defvar weiss-laptop-left-frame-alist
  '((tool-bar-lines . 0)
    (width . 104) ; chars
    (height . 48) ; lines
    (left . 0)
    (top . 0)))

(defvar weiss-laptop-right-frame-alist
  '((tool-bar-lines . 0)
    (width . 104) ; chars
    (height . 48) ; lines
    (left . 840)
    (top . 0)))

(advice-add 'weiss-new-frame :after (lambda () (interactive) (weiss-update-top-windows t)))

(defun weiss-new-frame ()
  "make new frame on the same side of current frame or on the other side with prefix-arg"
  (interactive)
  (if (eq (weiss-is-frame-in-right-pos) (null current-prefix-arg))
      (make-frame initial-frame-alist)
    (make-frame default-frame-alist)
    )
  )

(defun weiss-delete-other-window ()
  "If the current buffer ist org src file, switch between maximize window size(but not delete other windows) and half window size, else delete other windows"
  (interactive)
  (if (string-prefix-p "*Org Src " (buffer-name))
      (if (< (/ (frame-height) (nth 1 (window-edges))) 3)
          (maximize-window)
        (balance-windows)  
        )
    (delete-other-windows)
    )
  )

(defun weiss-switch-laptop-and-desktop ()
  "DOCSTRING"
  (interactive)
  (if weiss-is-laptop
      (setq weiss-right-frame-pos 835
            default-frame-alist weiss-laptop-left-frame-alist
            initial-frame-alist weiss-laptop-right-frame-alist)  
    (setq weiss-right-frame-pos 1690
          default-frame-alist weiss-desktop-left-frame-alist
          initial-frame-alist weiss-desktop-right-frame-alist)  
    )
  (setq weiss-is-laptop (not weiss-is-laptop))
  )

(defun weiss-is-frame-in-right-pos (&optional frame)
  "check if the current is on the right side"
  (interactive)  
  (> (car (frame-edges frame)) weiss-right-frame-pos)
  )

(defun weiss--select-frame-with-check (frame)
  (let ((frames (visible-frame-list)))
    (if (member frame frames)
        (progn
          (select-frame-set-input-focus frame)
          (weiss-update-top-windows t)
          t
          )      
      (weiss-update-top-windows)
      nil
      )  
    )
  )

(defun weiss--find-frame (right &optional exclude-list)
  "DOCSTRING"
  (let ((current-frame (selected-frame))
        (target-frame (selected-frame))
        )
    (setq target-frame (next-frame target-frame))
    (while (not (or
                 (eq current-frame target-frame)
                 (and
                  (frame-live-p target-frame)                  
                  (frame-visible-p target-frame)                  
                  (or (not exclude-list) (not (member target-frame exclude-list))) 
                  (or (and right (weiss-is-frame-in-right-pos target-frame))
                      (and (not right) (not (weiss-is-frame-in-right-pos target-frame)))
                      )
                  )))
      ;; (message "%s" target-frame)
      (setq target-frame (next-frame target-frame)))    
    target-frame
    )
  )

(defun weiss--switch-to-right-or-left-frame (right &optional exclude-list)
  "DOCSTRING"
  (setq target-frame (weiss--find-frame right exclude-list))
  (weiss-update-top-windows t)
  (select-frame-set-input-focus target-frame)
  (weiss-update-top-windows t)
  )

(defun weiss-switch-to-right-frame () (interactive) (weiss--switch-to-right-or-left-frame t))
(defun weiss-switch-to-left-frame () (interactive) (weiss--switch-to-right-or-left-frame nil))


(defun weiss-update-otherside-top-window ()
  "DOCSTRING"
  (interactive)
  (let ((is-right (weiss-is-frame-in-right-pos))
        (target-frame))
    (setq target-frame (weiss--find-frame (not is-right)))    
    (if is-right
        (progn
          (if (weiss-is-frame-in-right-pos target-frame)
              (setq weiss-left-top-window nil)
            (setq weiss-left-top-window target-frame)  
            )
          )
      (if (weiss-is-frame-in-right-pos target-frame)
          (setq weiss-right-top-window target-frame)
        (setq weiss-right-top-window nil)  
        )            
      )
    ))

(defun weiss-update-top-windows (&optional shallow-update)
  "update the top window"
  (interactive)
  (let ((current-frame (selected-frame)))
    (if (weiss-is-frame-in-right-pos)
        (setq weiss-right-top-window current-frame)
      (setq weiss-left-top-window current-frame)      
      )
    (unless shallow-update (weiss-update-otherside-top-window))    
    ))

(defun weiss-switch-to-otherside-top-frame ()
  "DOCSTRING"
  (interactive)
  (let ((current-frame (selected-frame)))
    (cond
     ((and (not (weiss-is-frame-in-right-pos)) (eq current-frame weiss-left-top-window)) (unless (weiss--select-frame-with-check weiss-right-top-window) (weiss--select-frame-with-check weiss-right-top-window)))
     ((and (weiss-is-frame-in-right-pos) (eq current-frame weiss-right-top-window)) (unless (weiss--select-frame-with-check weiss-left-top-window) (weiss--select-frame-with-check weiss-left-top-window)))
     ((weiss-is-frame-in-right-pos)
      (weiss-update-top-windows)
      (weiss--select-frame-with-check weiss-left-top-window))
     (t
      (weiss-update-top-windows)
      (weiss--select-frame-with-check weiss-right-top-window))
     ) 
    )
  )

(defun weiss-switch-to-same-side-frame ()
  "DOCSTRING"
  (interactive)
  (let ((current-frame (selected-frame))) 
    (if (weiss-is-frame-in-right-pos)
        (weiss--switch-to-right-or-left-frame t (list current-frame))
      (weiss--switch-to-right-or-left-frame nil (list current-frame))    
      ))  
  )

(defun weiss-switch-buffer-or-otherside-frame-without-top ()
  "DOCSTRING"
  (interactive)
  (if (one-window-p)
      (progn
        (weiss-switch-to-otherside-top-frame)
        (weiss-switch-to-same-side-frame)  
        )
    (other-window 1)
    )
  )

(defun get-frame-name (&optional frame)
  "Return the string that names FRAME (a frame).  Default is selected frame."
  (unless frame (setq frame (selected-frame)))
  (if (framep frame)
      (cdr (assq 'name (frame-parameters frame)))
    (error "Function `get-frame-name': Argument not a frame: `%s'" frame)))

(defun get-a-frame (frame)
  "Return a frame, if any, named FRAME (a frame or a string).
  If none, return nil.
  If FRAME is a frame, it is returned."
  (cond ((framep frame) frame)
        ((stringp frame)
         (catch 'get-a-frame-found
           (dolist (fr (frame-list))
             (when (string= frame (get-frame-name fr))
               (throw 'get-a-frame-found fr)))
           nil))
        (t (error
            "Function `get-frame-name': Arg neither a string nor a frame: `%s'"
            frame))))
;; buffer/frame switching:1 ends here

;; weiss-buffer-frame-change-hook

;; [[file:../emacs-config.org::*weiss-buffer-frame-change-hook][weiss-buffer-frame-change-hook:1]]
(defun weiss-after-change-frame-or-window (&optional a b c)
  "run after change frame or window"
  (interactive)
  (dolist (x weiss/after-buffer-change-function-list)
    (eval (list x))
    )
  )

(let ((function-list '(
                       select-frame-set-input-focus
                       previous-buffer
                       next-buffer
                       switch-to-buffer
                       other-window
                       find-file
                       org-open-file
                       dired-goto-file
                       org-agenda-finalize
                       wdired-finish-edit
                       )))
  (dolist (x function-list)
    (advice-add x :after #'weiss-after-change-frame-or-window)
    )
  )

(defun weiss-after-major-mode ()
  "run after new major mode"
  (interactive)
  (dolist (x weiss/after-major-mode-function-list)
    (eval (list x))
    )
  )

(let ((hook-list '(
                   prog-mode-hook
                   text-mode-hook
                   fundamental-mode-hook
                   dired-mode-hook
                   wdired-mode-hook
                   special-mode-hook
                   conf-mode-hook
                   quickrun-after-run-hook
                   custom-mode-hook
                   )))
  (dolist (x hook-list)
    (add-hook x 'weiss-after-major-mode))
  )
;; weiss-buffer-frame-change-hook:1 ends here

;; select

;; [[file:../emacs-config.org::*select][select:1]]
(defun weiss-deactivate-mark ()
  "DOCSTRING"
  (interactive)
  (setq saved-region-selection nil)
  (let (select-active-regions)
    (deactivate-mark)))

(defun weiss-expand-region-by-word ()
  "expand region word by word on the same side of cursor"
  (interactive)
  (if current-prefix-arg
      (insert " ")
    (if (eq (point) (region-beginning))
        (backward-word)
      (forward-word))        
    )
  )

(defun weiss-contract-region-by-word ()
  "expand region word by word on the same side of cursor"
  (interactive)
  (if (eq (point) (region-beginning))
        (forward-word)
      (backward-word))
  ) 

(defun weiss-select-line-downward ()
  "Select current line. If current line is in region && cursor at region-end, extend selection downward by line."
  (interactive)
  (weiss-select-mode-turn-on)
  (if (and (region-active-p)
           (>= (line-beginning-position) (region-beginning))
           (eq (point) (line-end-position)))
      (progn
        (forward-line 1)
        (end-of-line))
    (progn
      (end-of-line)
      (set-mark (line-beginning-position)))))

(defun weiss-select-sexp ()
  "select single sexp first and select the next wenn you call this function again"
  (interactive)
  (if (and (use-region-p)
           (not (ignore-errors (bounds-of-thing-at-point 'list))))
      (progn
        (skip-syntax-forward " <>
          ")
        ;; skip the comment
        (while (string-match "^;+.*" (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
          (next-line))
        (while (ignore-errors (setq bounds (bounds-of-thing-at-point 'list)))
          (goto-char (cdr bounds))
          ))
    (weiss-select-single-sexp)
    )
  )

(defun weiss-select-single-sexp ()
  "select the biggest sexp and copy"
  (interactive)
  ;; It seems like that bounds-of-thing-at-point habe some problems with quote
  ;; (while (looking-at "[ \"]") (forward-char))
  (deactivate-mark)
  (skip-syntax-forward "\" <>
  ")
  (let ((bounds-temp)
        (bounds))
    (while (ignore-errors (setq bounds-temp (bounds-of-thing-at-point 'list)))
      (setq bounds bounds-temp)
      (goto-char (cdr bounds))
      (when (looking-at "[ \"]") (forward-char))
      )
    (push-mark (car bounds) t t)
    (setq mark-active t)
    (kill-new (buffer-substring-no-properties (region-beginning) (region-end)))
    ))

(defun xah-select-text-in-quote ()
  "Select text between the nearest left and right delimiters.
  Delimiters here includes the following chars: '\"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）
  This command select between any bracket chars, not the inner text of a bracket. For example, if text is

   (a(b)c▮)

   the selected char is “c”, not “a(b)c”.

  URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
  Version 2018-10-11"
  (interactive)
  (let (
        ($skipChars "^'\"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）〘〙")
        $p1
        )
    (skip-chars-backward $skipChars)
    (setq $p1 (point))
    (skip-chars-forward $skipChars)
    (set-mark $p1)))
;; select:1 ends here

;; save/open/new/copy

;; [[file:../emacs-config.org::*save/open/new/copy][save/open/new/copy:1]]
(defun xah-make-backup ()
  "Make a backup copy of current file or dired marked files.
If in dired, backup current file or marked files.
The backup file name is in this format
 x.html~2018-05-15_133429~
 The last part is hour, minutes, seconds.
in the same dir. If such a file already exist, it's overwritten.
If the current buffer is not associated with a file, nothing's done.

URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2018-06-06"
  (interactive)
  (let (($fname (buffer-file-name))
        ($date-time-format "%Y-%m-%d_%H%M%S"))
    (if $fname
        (let (($backup-name
               (concat $fname "~" (format-time-string $date-time-format) "~")))
          (copy-file $fname $backup-name t)
          (message (concat "Backup saved at: " $backup-name)))
      (if (eq major-mode 'dired-mode)
          (progn
            (mapc (lambda ($x)
                    (let (($backup-name
                           (concat $x "~" (format-time-string $date-time-format) "~")))
                      (copy-file $x $backup-name t)))
                  (dired-get-marked-files))
            (revert-buffer))
        (user-error "buffer not file nor dired")))))

(defun weiss-kill-append ()
  "append region to kill-ring"
  (interactive)
  (when (use-region-p)
    (let ((rbeg (region-beginning))
          (rend (region-end))
          )
      (kill-append (buffer-substring-no-properties rbeg rend) nil)
      )))

(defun weiss-exchange-region-kill-ring-car ()
  "insert pop current kill-ring and kill region"
  (interactive)
  (when (use-region-p)
    (when-let ((rbeg (region-beginning))
               (rend (region-end))
               (rep (pop kill-ring))
               )
      (push (delete-and-extract-region rbeg rend) kill-ring)
      (insert rep)
      )
    )
  )

(defun xah-make-backup-and-save ()
  "Backup of current file and save, or backup dired marked files.
For detail, see `xah-make-backup'.
If the current buffer is not associated with a file nor dired, nothing's done.
URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2015-10-14"
  (interactive)
  (if (buffer-file-name)
      (progn
        (xah-make-backup)
        (when (buffer-modified-p)
          (save-buffer)))
    (progn
      (xah-make-backup))))

(defun xah-clear-register-1 ()
  "Clear register 1.
  See also: `xah-paste-from-register-1', `copy-to-register'.

  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2015-12-08"
  (interactive)
  (progn
    (copy-to-register ?1 (point-min) (point-min))
    (message "Cleared register 1.")))

(defun xah-copy-to-register-1 ()
  "Copy current line or text selection to register 1.
  See also: `xah-paste-from-register-1', `copy-to-register'.

  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2017-01-23"
  (interactive)
  (let ($p1 $p2)
    (if (region-active-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (setq $p1 (line-beginning-position) $p2 (line-end-position)))
    (copy-to-register ?1 $p1 $p2)
    (message "Copied to register 1: 「%s」." (buffer-substring-no-properties $p1 $p2))))

(defun xah-append-to-register-1 ()
  "Append current line or text selection to register 1.
  When no selection, append current line, with newline char.
  See also: `xah-paste-from-register-1', `copy-to-register'.

  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2015-12-08"
  (interactive)
  (let ($p1 $p2)
    (if (region-active-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (setq $p1 (line-beginning-position) $p2 (line-end-position)))
    (append-to-register ?1 $p1 $p2)
    (with-temp-buffer (insert "\n")
                      (append-to-register ?1 (point-min) (point-max)))
    (message "Appended to register 1: 「%s」." (buffer-substring-no-properties $p1 $p2))))

(defun xah-paste-from-register-1 ()
  "Paste text from register 1.
  See also: `xah-copy-to-register-1', `insert-register'.
  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2015-12-08"
  (interactive)
  (when (use-region-p)
    (delete-region (region-beginning) (region-end)))
  (insert-register ?1 t))


(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
            When called repeatedly, append copy subsequent lines.
            When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

            URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
            Version 2019-10-30"
  (interactive)
  (let ((inhibit-field-text-motion nil))
    (if current-prefix-arg
        (progn
          (let (
                (current-point (point))
                (line (if weiss-select-mode
                          (concat (buffer-substring-no-properties (region-beginning) (region-end)) "\n")  
                        (buffer-substring-no-properties (line-beginning-position)(line-beginning-position 2))))
                (times  current-prefix-arg))
            (when weiss-select-mode
              (goto-char (region-end))
              (forward-line)
              (beginning-of-line)
              (open-line 1))
            (if (eq times 1)
                (setq times 4)
              (ignore-errors (when (member 4 times) (setq times 1)))
              )
            ;; (message "%s" times)
            (beginning-of-line)
            ;; (open-line 1)
            (dotimes (i times)
              ;; (next-line)
              (insert line)
              )
            (indent-region current-point (point))
            )          
          )
      (if (use-region-p)
          (progn
            (copy-region-as-kill (region-beginning) (region-end)))
        (if (eq last-command this-command)
            (if (eobp)
                (progn )
              (progn
                (kill-append "\n" nil)
                (kill-append
                 (buffer-substring-no-properties (line-beginning-position) (line-end-position))
                 nil)
                (progn
                  (end-of-line)
                  (forward-char))))
          (if (eobp)
              (if (eq (char-before) 10 )
                  (progn )
                (progn
                  (copy-region-as-kill (line-beginning-position) (line-end-position))
                  (end-of-line)))
            (progn
              (copy-region-as-kill (line-beginning-position) (line-end-position))
              (end-of-line)
              (forward-char))))))))

(defun xah-copy-file-path (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
    Result is full path.
    If `universal-argument' is called first, copy only the dir path.

    If in dired, copy the file/dir cursor is on, or marked files.

    If a buffer is not file and not dired, copy value of `default-directory' (which is usually the “current” dir when that buffer was created)

    URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
    Version 2018-06-18"
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (buffer-file-name)
             (expand-file-name default-directory)))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "Directory copied: %s" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: %s" $fpath)
         $fpath )))))

(defun weiss-save-current-content ()
  "save current content in temp buffer"
  (interactive)
  (let ((current-buffer-content (buffer-string))
        (current-buffer-name (buffer-name))
        )
    (setq newBuf (generate-new-buffer (format "backup_%s" current-buffer-name)))
    (set-buffer newBuf)
    (insert current-buffer-content)
    (when (eq major-mode 'help-mode) (quit-window))
    ))

(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
    New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.

    It returns the buffer (for elisp programing).

    URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
    Version 2017-11-01"
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf
    ))

(defun xah-open-in-external-app (&optional @fname)
  "Open the current file or dired marked files in external app.
    The app is chosen from your OS's preference.

    When called in emacs lisp, if @fname is given, open that.

    URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
    Version 2019-11-04"
  (interactive)
  (unless (eq major-mode 'dired-mode)
    (save-buffer))  
  (let* (
         ($file-list
          (if @fname
              (progn (list @fname))
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list (buffer-file-name)))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (w32-shell-execute "open" $fpath)) $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))  $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" $fpath))) $file-list))))))

(defun xah-open-file-at-cursor ()
  "Open the file path under cursor.
    If there is text selection, uses the text selection for path.
    If the path starts with “http://”, open the URL in browser.
    Input path can be {relative, full path, URL}.
    Path may have a trailing “:‹n›” that indicates line number, or “:‹n›:‹m›” with line and column number. If so, jump to that line number.
    If path does not have a file extension, automatically try with “.el” for elisp files.
    This command is similar to `find-file-at-point' but without prompting for confirmation.

    URL `http://ergoemacs.org/emacs/emacs_open_file_path_fast.html'
    Version 2019-07-16"
  (interactive)
  (let* (
         ($inputStr
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (let ($p0 $p1 $p2
                      ;; chars that are likely to be delimiters of file path or url, e.g. whitespace, comma. The colon is a problem. cuz it's in url, but not in file name. Don't want to use just space as delimiter because path or url are often in brackets or quotes as in markdown or html
                      ($pathStops "^  \t\n\"`'‘’“”|[]{}「」<>〔〕〈〉《》【】〖〗«»‹›❮❯❬❭〘〙·。\\"))
              (setq $p0 (point))
              (skip-chars-backward $pathStops)
              (setq $p1 (point))
              (goto-char $p0)
              (skip-chars-forward $pathStops)
              (setq $p2 (point))
              (goto-char $p0)
              (buffer-substring-no-properties $p1 $p2))))
         ($path
          (replace-regexp-in-string
           "^file:///" "/"
           (replace-regexp-in-string
            ":\\'" "" $inputStr))))
    (if (string-match-p "\\`https?://" $path)
        (if (fboundp 'xahsite-url-to-filepath)
            (let (($x (xahsite-url-to-filepath $path)))
              (if (string-match "^http" $x )
                  (browse-url $x)
                (find-file $x)))
          (progn (browse-url $path)))
      (progn ; not starting “http://”
        (if (string-match "#" $path )
            (let (
                  ( $fpath (substring $path 0 (match-beginning 0)))
                  ( $fractPart (substring $path (match-beginning 0))))
              (if (file-exists-p $fpath)
                  (progn
                    (find-file $fpath)
                    (goto-char 1)
                    (search-forward $fractPart ))
                (when (y-or-n-p (format "file no exist: 「%s」. Create?" $fpath))
                  (find-file $fpath))))
          (if (string-match "^\\`\\(.+?\\):\\([0-9]+\\)\\(:[0-9]+\\)?\\'" $path)
              (let (
                    ($fpath (match-string 1 $path))
                    ($line-num (string-to-number (match-string 2 $path))))
                (if (file-exists-p $fpath)
                    (progn
                      (find-file $fpath)
                      (goto-char 1)
                      (forward-line (1- $line-num)))
                  (when (y-or-n-p (format "file no exist: 「%s」. Create?" $fpath))
                    (find-file $fpath))))
            (if (file-exists-p $path)
                (progn ; open f.ts instead of f.js
                  (let (($ext (file-name-extension $path))
                        ($fnamecore (file-name-sans-extension $path)))
                    (if (and (string-equal $ext "js")
                             (file-exists-p (concat $fnamecore ".ts")))
                        (find-file (concat $fnamecore ".ts"))
                      (find-file $path))))
              (if (file-exists-p (concat $path ".el"))
                  (find-file (concat $path ".el"))
                (when (y-or-n-p (format "file no exist: 「%s」. Create?" $path))
                  (find-file $path ))))))))))
;; save/open/new/copy:1 ends here

;; keybinding

;; [[file:../emacs-config.org::*keybinding][keybinding:1]]
(defun weiss-overriding-ryo-define-key (keymap key-cmd-list fun)
  (interactive)
  (mapc
   (lambda (cmd-key)
     (let ((cmd (nth 1 cmd-key))
           (key (nth 0 cmd-key))
           )
       (define-key keymap (kbd key)
         `(menu-item "" ,cmd
                     :filter ,fun)
         )
       )
     )
   key-cmd-list)
  )

(defmacro weiss-overriding-ryo-push-map (mode keymap)
  `(progn
     (setq minor-mode-overriding-map-alist (assq-delete-all ',mode minor-mode-overriding-map-alist))
     (push '(,mode . ,(symbol-value keymap)) minor-mode-overriding-map-alist)
     )
  )
;; keybinding:1 ends here

;; misc

;; [[file:../emacs-config.org::*misc][misc:1]]
(defun weiss-is-today ()
  "return `t' if now is before 4AM"
  (< (string-to-number (format-time-string "%H")) 4)
  )

;; comes from https://stackoverflow.com/questions/14489848/emacs-name-of-current-local-keymap
(defun keymap-symbol (keymap)
  "Return the symbol to which KEYMAP is bound, or nil if no such symbol exists."
  (catch 'gotit
    (mapatoms (lambda (sym)
                (and (boundp sym)
                     (eq (symbol-value sym) keymap)
                     (not (eq sym 'keymap))
                     (throw 'gotit sym))))))

;; undo-collapse comes from
;; https://emacs.stackexchange.com/questions/7558/how-to-collapse-undo-history
(defun undo-collapse-begin ()
  "push a mark that do nothing to the undo list"
  (push (list 'apply 'identity nil) buffer-undo-list))

(defun undo-collapse-end ()
  "Collapse undo history until a matching marker."
  (let ((marker (list 'apply 'identity nil)))
    (cond
     ((equal (car buffer-undo-list) marker)
      (setq buffer-undo-list (cdr buffer-undo-list))
      ;; (message "success, car")
      )   
     (t
      (let ((l buffer-undo-list)
            (limit 0))
        (while (and (not (equal (cadr l) marker))
                    )
          (setq limit (1+ limit))
          (cond
           ((null (cdr l))
            (error "undo-collapse-end with no matching marker"))
           ((null (cadr l))
            (setf (cdr l) (cddr l)))
           (t (setq l (cdr l)))))
        (setf (cdr l) (cddr l))
        ))) 
    ))


(defmacro with-undo-collapse (&rest body)
  "Execute body, then collapse any resulting undo boundaries."
  (declare (indent 0))
  (let ((buffer-var (make-symbol "buffer")))
    `(let ((,buffer-var (current-buffer)))
       (unwind-protect
           (progn
             (undo-collapse-begin)
             ,@body)
         (with-current-buffer ,buffer-var
           (undo-collapse-end))))))


(defun read-char-picky (prompt chars &optional inherit-input-method seconds)
  "Read characters like in `read-char-exclusive', but if input is
  not one of CHARS, return nil.  CHARS may be a list of characters,
  single-character strings, or a string of characters."
  (let ((chars (mapcar (lambda (x)
                         (if (characterp x) x (string-to-char x)))
                       (append chars nil)))
        (char  (read-char-exclusive prompt inherit-input-method seconds)))
    (when (memq char chars)
      (char-to-string char))))

(defun weiss-read-char-picky-from-list (picky-list)
  "Get the inputed number and return the nth element of list"
  (interactive)
  (let ((ra "")
        (rb ""))
    (nth (- (string-to-number (read-char-picky
                               (dotimes (i (length picky-list) ra) (setq ra (format "%s %s:%s" ra (1+ i) (nth i picky-list))))
                               (dotimes (i (length picky-list) rb) (setq rb (format "%s%s" rb (1+ i)))))) 1) picky-list)))

(defun weiss-eval-last-sexp-this-line()
  "eval last sexp this line"
  (interactive)
  (end-of-line)
  (eval-last-sexp()))

(defun weiss-universal-argument ()
  "Simulate C-u"
  (interactive)
  (if current-prefix-arg
      (call-interactively 'universal-argument-more)
    (universal-argument)  
    )
  )

(defun weiss-show-all-major-mode ()
  "Show all major mode and it's parent mode"
  (interactive)
  (let ((mode major-mode)
        parents)
    (while mode
      (setq parents (cons mode parents)
            mode (get mode 'derived-mode-parent)))
    (message "%s" (reverse parents)))
  )

(defun xah-show-kill-ring ()
  "Insert all `kill-ring' content in a new buffer named *copy history*.

URL `http://ergoemacs.org/emacs/emacs_show_kill_ring.html'
Version 2019-12-02"
  (interactive)
  (let (($buf (generate-new-buffer "*copy history*")))
    (progn
      (switch-to-buffer $buf)
      (funcall 'fundamental-mode)
      (dolist (x kill-ring )
        (insert x "\n\nhh=============================================================================\n\n"))
      (goto-char (point-min)))))

(defun weiss-refresh ()
  "let flycheck refresh"
  (interactive)
  (save-buffer)
  (when flycheck-mode (flycheck-buffer))
  )

(defun weiss-call-kmacro-multi-times ()
  "DOCSTRING"
  (interactive)
  (let ((times (string-to-number (read-string (format "Repeat Times: ") nil nil nil))))
    (dotimes (i times)
      (next-line)
      (call-last-kbd-macro)
      )
    ))


(defun weiss-execute-buffer ()
  "If the current buffer is elisp mode, then eval-buffer, else quickrun"
  (interactive)
  (save-buffer)
  (cond
   ((or (eq major-mode 'xah-elisp-mode) (eq major-mode 'emacs-lisp-mode)) (eval-buffer))
   ((string= (file-name-directory (buffer-file-name)) "/home/weiss/KaRat/datenbank/")
    (message "compile: %s" (shell-command-to-string "javac -Werror -cp '.:commons-io-2.8.0.jar' QuizzesSearch.java"))
    (message "output: %s" (shell-command-to-string "java -cp postgresql-42.2.18.jar:commons-io-2.8.0.jar:. QuizzesSearch"))
    )
   ((string-prefix-p "/home/weiss/KaRat/datenbank/KaRat-Quizzes/" (file-name-directory (buffer-file-name)))
    ;; (message ": %s" 123)
    (message "%s" (shell-command-to-string "go run /home/weiss/KaRat/datenbank/KaRat-Quizzes/main.go -tomlPath=/home/weiss/KaRat/datenbank/KaRat-Quizzes/input.toml"))
    )
   (t (quickrun))
   )
  )


(defun weiss--execute-kbd-macro (kbd-macro)
  "Execute KBD-MACRO."
  (when-let ((cmd (key-binding (read-kbd-macro kbd-macro))))
    (call-interactively cmd)))
;; misc:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-keybinding-functions)
;; end:1 ends here
