(defconst weiss--eldoc-commands
  '(
    weiss-right-key
    weiss-up-key
    weiss-down-key
    weiss-left-key
    xah-backward-left-bracket
    xah-forward-right-bracket
    )
  "A list commands trigger eldoc.")

(setq eldoc-display-functions '(eldoc-display-in-echo-area weiss-show-eldoc))

(apply #'eldoc-add-command weiss--eldoc-commands)

(defun weiss-show-eldoc (docs _interactive)
  "just the main part of eldoc-display-in-echo-area"
  (interactive)
  (let*
      ((width (1- (window-width (minibuffer-window))))
       (val (if (and (symbolp eldoc-echo-area-use-multiline-p)
                     eldoc-echo-area-use-multiline-p)
                max-mini-window-height
              eldoc-echo-area-use-multiline-p))
       (available (cl-typecase val
                    (float (truncate (* (frame-height) val)))
                    (integer val)
                    (t 'just-one-line)))
       single-doc single-doc-sym)
    (let ((echo-area-message
           (cond
            (;; To output to the echo area, we handle the
             ;; `truncate-sym-name-if-fit' special case first, by
             ;; checking for a lot of special conditions.
             (and
              (eq 'truncate-sym-name-if-fit eldoc-echo-area-use-multiline-p)
              (null (cdr docs))
              (setq single-doc (caar docs))
              (setq single-doc-sym
                    (format "%s" (plist-get (cdar docs) :thing)))
              (< (length single-doc) width)
              (not (string-match "\n" single-doc))
              (> (+ (length single-doc) (length single-doc-sym) 2) width))
             single-doc)
            ((and (numberp available)
                  (cl-plusp available))
             ;; Else, given a positive number of logical lines, we
             ;; format the *eldoc* buffer, using as most of its
             ;; contents as we know will fit.
             (with-current-buffer (eldoc--format-doc-buffer docs)
               (save-excursion
                 (eldoc--echo-area-substring available))))
            (t ;; this is the "truncate brutally" situation
             (let ((string
                    (with-current-buffer (eldoc--format-doc-buffer docs)
                      (buffer-substring (goto-char (point-min))
                                        (line-end-position 1)))))
               (if (> (length string) width)  ; truncation to happen
                   (unless (eldoc--echo-area-prefer-doc-buffer-p t)
                     (truncate-string-to-width string width))
                 (unless (eldoc--echo-area-prefer-doc-buffer-p nil)
                   string)))))))
      (when echo-area-message
        (eldoc--message echo-area-message))))
  )

(provide 'weiss_eldoc<ui)
