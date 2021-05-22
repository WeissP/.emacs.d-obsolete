(setq wks-last-found nil)

(defun wks--find-symbol (symbol forward)
  "DOCSTRING"
  (interactive)
  (if forward
      (progn
        (search-forward symbol nil nil)
        (left-char)
        )
    (progn
      (search-backward symbol nil nil)
      (right-char)
      )
    )
  )

(defun wks-find-last-found ()
  "DOCSTRING"
  (interactive)
  (when wks-last-found
    (let ((symbol (car wks-last-found))
          (forward (string= (cdr wks-last-found) "forward")))
      (if forward
          (right-char)
        (left-char)
        )
      (wks--find-symbol symbol forward)
      )
    )  
  )

(defun wks-find-symbol-forward ()
  "DOCSTRING"
  (interactive)
  (let ((symbol (wks--set-find-symbol t (char-to-string (read-char "symbol: "))))         
        )
    (setq wks-last-found `(,symbol . "forward"))
    (wks--find-symbol symbol t)
    )
  )

(defun wks-find-symbol-backward ()
  "DOCSTRING"
  (interactive)
  (let ((symbol (wks--set-find-symbol nil (char-to-string (read-char "symbol: "))))         
        )
    (setq wks-last-found `(,symbol . "backward"))
    (wks--find-symbol symbol nil)
    )
  )

(defun wks--set-find-symbol (forward c)
  "DOCSTRING"
  (interactive)
  (pcase c
    ("j" (if forward "(" ")"))
    ("k" (if forward "[" "]"))
    ("l" (if forward "{" "}"))
    ("i" "\"")
    ("o" "'")
    ("m" (if forward "<" ">"))
    ("h" ";")
    ("u" ":")
    (_  c))
  )

(defun weiss-test ()
  "DOCSTRING"
  (interactive)
  (wks-find-last-found))

(provide 'weiss_wks-find<wks)
