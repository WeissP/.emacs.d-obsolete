(define-prefix-command 'wks-global-quick-insert-keymap)

(defun weiss-global-insert-pair-alist(new-line)
  `(
    ("j" . (,(if new-line 'weiss-insert-paren-new-line 'weiss-insert-paren)
            (weiss-insert-pair "(" ")" ,new-line)))
    ("k" . (,(if new-line 'weiss-insert-bracket-new-line 'weiss-insert-bracket)
            (weiss-insert-pair "[" "]" ,new-line)))
    ("l" . (,(if new-line 'weiss-insert-brace-new-line 'weiss-insert-brace)
            (weiss-insert-pair "{" "}" ,new-line)))
    ("i" . (,(if new-line 'weiss-insert-double-quote-new-line 'weiss-insert-double-quote)
            (weiss-insert-pair "\"" "\"" ,new-line)))
    ("o" . (,(if new-line 'weiss-insert-single-quote-new-line 'weiss-insert-single-quote)
            (weiss-insert-pair "'" "'" ,new-line)))
    ("-" . (,(if new-line 'weiss-insert-underline-new-line 'weiss-insert-underline)
            (weiss-insert-pair "_" "_" ,new-line)))
    ("=" . (,(if new-line 'weiss-insert-equals-new-line 'weiss-insert-equals)
            (weiss-insert-pair "=" "=" ,new-line)))
    ("a" . (,(if new-line 'weiss-insert-bar-new-line 'weiss-insert-bar)
            (weiss-insert-pair "|" "|" ,new-line)))
    ("q" . (,(if new-line 'weiss-insert-markdown-quote-new-line 'weiss-insert-markdown-quote)
            (weiss-insert-pair "`" "`" ,new-line)))
    ("w" . (,(if new-line 'weiss-insert-elisp-quote-new-line 'weiss-insert-elisp-quote)
            (weiss-insert-pair "`" "'" ,new-line)))
    ("s" . (,(if new-line 'weiss-insert-star-new-line 'weiss-insert-star)
            (weiss-insert-pair "*" "*" ,new-line)))
    ("/" . (,(if new-line 'weiss-insert-slash-new-line 'weiss-insert-slash)
            (weiss-insert-pair "/" "/" ,new-line)))
    ("$" . (,(if new-line 'weiss-insert-dollar-new-line 'weiss-insert-dollar)
            (weiss-insert-pair "$" "$" ,new-line)))
    ("7" . (,(if new-line 'weiss-insert-and-new-line 'weiss-insert-and)
            (weiss-insert-pair "&" "&" ,new-line)))
    ("m" . (,(if new-line 'weiss-insert-angle-bracket-new-line 'weiss-insert-angle-bracket)
            (weiss-insert-pair "<" ">" ,new-line)))
    ("<deletechar>" . (,(if new-line 'weiss-insert-back-slash-new-line 'weiss-insert-back-slash)
                       (weiss-insert-pair "\\" "\\" ,new-line)))
    )
  )

(defun weiss-global-insert-escape-pair-alist(new-line)
  `(
    ("j" . (,(if new-line 'weiss-insert-escape-paren-new-line 'weiss-insert-escape-paren)
            (weiss-insert-pair "\\(" "\\)" ,new-line)))
    ("k" . (,(if new-line 'weiss-insert-escape-bracket-new-line 'weiss-insert-escape-bracket)
            (weiss-insert-pair "\\[" "\\]" ,new-line)))
    ("l" . (,(if new-line 'weiss-insert-escape-brace-new-line 'weiss-insert-escape-brace)
            (weiss-insert-pair "\\{" "\\}" ,new-line)))
    ("i" . (,(if new-line 'weiss-insert-escape-quote-new-line 'weiss-insert-escape-quote)
            (weiss-insert-pair "\\\"" "\\\"" ,new-line)))
    ("o" . (,(if new-line 'weiss-insert-escape-single-quote-new-line 'weiss-insert-escape-single-quote)
            (weiss-insert-pair "\\'" "\\'" ,new-line)))
    )
  )

(wks-define-key  wks-global-quick-insert-keymap ""
                 (weiss-global-insert-pair-alist nil)
                 )

(wks-define-key  wks-global-quick-insert-keymap ""
                 '(
                   ("RET" . (weiss-insert-new-line (insert "\\n")))
                   )
                 )

(wks-define-key  wks-global-quick-insert-keymap "e "
                 (weiss-global-insert-escape-pair-alist nil)
                 )

(wks-define-key  wks-global-quick-insert-keymap "<end> "
                 (weiss-global-insert-pair-alist t)
                 )

(wks-define-key  wks-global-quick-insert-keymap "<end> e "
                 (weiss-global-insert-escape-pair-alist t)
                 )


(provide 'weiss_quick-insert<wks)
