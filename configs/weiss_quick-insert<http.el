(define-prefix-command 'wks-http-quick-insert-keymap)

(defun weiss-http-insert-pair-alist(new-line)
  `(
    ("b" . (,(if new-line 'weiss-http-insert-b-new-line 'weiss-http-insert-b)
            (weiss-insert-pair "<b>" "</b>" ,new-line)))
    ("i" . (,(if new-line 'weiss-http-insert-i-new-line 'weiss-http-insert-i)
            (weiss-insert-pair "<i>" "</i>" ,new-line)))
    ("u" . (,(if new-line 'weiss-http-insert-u-new-line 'weiss-http-insert-u)
            (weiss-insert-pair "<u>" "</u>" ,new-line)))
    ("p" . (,(if new-line 'weiss-http-insert-p-new-line 'weiss-http-insert-p)
            (weiss-insert-pair "<p>" "</p>" ,new-line)))
    ("l" . (,(if new-line 'weiss-http-insert-li-new-line 'weiss-http-insert-li)
            (weiss-insert-pair "<li>" "</li>" ,new-line)))
    ("m" . (,(if new-line 'weiss-http-insert-span-block-new-line 'weiss-http-insert-span-block)
            (weiss-insert-pair "<span class=\"block\">" "</span>" ,new-line)))
    ("s" . (,(if new-line 'weiss-http-span-new-line 'weiss-http-insert-span)
            (weiss-insert-pair "<span >" "</span>" ,new-line)))
    ("d" . (,(if new-line 'weiss-http-insert-div-new-line 'weiss-http-insert-div)
            (weiss-insert-pair "<div >" "</div>" ,new-line)))
    )
  )


(wks-define-key  wks-http-quick-insert-keymap ""
                 (weiss-http-insert-pair-alist nil)
                 )


(wks-define-key  wks-http-quick-insert-keymap "<end> "
                 (weiss-http-insert-pair-alist t)
                 )

(provide 'weiss_quick-insert<http)
