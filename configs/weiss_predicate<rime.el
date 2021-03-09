(with-eval-after-load 'rime
  (defun +rime-predicate-current-uppercase-letter-p ()
    "If the current charactor entered is a uppercase letter.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'."
    (and rime--current-input-key
         (>= rime--current-input-key ?A)
         (<= rime--current-input-key ?Z)))

  (defun +rime-predicate-current-input-punctuation-p ()
    "If the current charactor entered is a punctuation.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'."
    (and rime--current-input-key
         (or (and (<= #x21 rime--current-input-key) (<= rime--current-input-key #x2f))
             (and (<= #x3a rime--current-input-key) (<= rime--current-input-key #x40))
             (and (<= #x5b rime--current-input-key) (<= rime--current-input-key #x60))
             (and (<= #x7b rime--current-input-key) (<= rime--current-input-key #x7f)))))

  (defun +rime-predicate-punctuation-after-space-cc-p ()
    "If input a punctuation after a Chinese charactor with whitespace.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'.\""
    (and (> (point) (save-excursion (back-to-indentation) (point)))
         (+rime-predicate-current-input-punctuation-p)
         (looking-back "\\cc +" 2)))

  (defun +rime-predicate-after-special-punctuation-p ()
    "If the cursor is after a string prefixed a special punctuation.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'."
    (and (> (point) (save-excursion (back-to-indentation) (point)))
         (looking-back "[@:/][a-zA-Z0-9-_]*" 1)))

  (defun weiss-rime-predicate-after-word-and-char-p ()
    "If the cursor is after [an ascii-word + space + an ascii-char]"
    (and (> (point) (save-excursion (back-to-indentation) (point)))
         (looking-back "[a-zA-Z] " 1)))

  (defun weiss-command-mode-p ()
    "DOCSTRING"
    (interactive)
    (not wks-vanilla-mode)
    )

  (setq rime-disable-predicates
        '(
          weiss-command-mode-p
          rime-predicate-after-alphabet-char-p
          rime-predicate-auto-english-p
          rime-predicate-punctuation-line-begin-p
          +rime-predicate-punctuation-after-space-cc-p
          +rime-predicate-after-special-punctuation-p
          ))

  (setq enter-rime-inline-predicates
        '(
          ;; rime-predicate-auto-english-p
          ;; rime--after-alphabet-char-p
          weiss-rime-predicate-after-word-and-char-p
          )
        )

  (defun enter-rime--should-inline-ascii-p ()
    "If we should toggle to inline ascii mode."
    (seq-find 'funcall enter-rime-inline-predicates))
  )

(provide 'weiss_predicate<rime)
