(defvar weiss/kmacro-info nil)

(defun weiss-call-kmacro ()
  "call kmacro once"
  (interactive)
  (undo-collapse-begin)
  (weiss-before-kmacro)
  (call-interactively 'call-last-kbd-macro)
  (undo-collapse-end)
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

(provide 'weiss_kmacro<ks)
