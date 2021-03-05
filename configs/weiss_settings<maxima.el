;; use maxima-git to avoid latex-error
(add-to-list 'load-path "/usr/share/emacs/site-lisp/maxima/")
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(setq imaxima-use-maxima-mode-flag t)
(add-to-list 'auto-mode-alist '("\\.ma[cx]\\'" . maxima-mode))

(advice-add 'inferior-maxima-check-and-send-line :before 'weiss-add-semicolon)
(defun weiss-add-semicolon ()
  "insert semicolon at the end of line then send line"
  (interactive)
  (beginning-of-line)
  (unless (string-match-p ";" (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
    (end-of-line)
    (insert ";")
    )
  )

(provide 'weiss_settings<maxima)
