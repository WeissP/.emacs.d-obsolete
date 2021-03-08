(set-default 'abbrev-mode nil)
(abbrev-mode -1)
(setq save-abbrevs nil)

(defconst expand-abbrev-maybe
  '(menu-item "" expand-abbrev
              :filter (lambda (cmd) (and (weiss-check-or-expand-abbrev t) cmd)))
  "A conditional key definition for `expand-abbrev'.
When  this was bound, it will expand abbrev at point if there're any possible
abbrev.")

(defun weiss-check-or-expand-abbrev (&optional check)
  "Check the string between the cursor and the last space"
  (interactive)
  (when (xah-abbrev-enable-function)
    (let ((local-abbrev-table local-abbrev-table)
          p1 p2 abrStr abrSymbol current-table)
      (save-excursion
        (setq p2 (point))
        ;; (setq p1 (if (re-search-backward "[[:space:]]" (line-beginning-position) t)
        ;; (1+ (point))            
        ;; (line-beginning-position)))
        (skip-syntax-backward "\\w\\_")
        ;; (skip-syntax-backward "\\w")
        (setq p1 (point))
        )
      (setq abrStr (buffer-substring-no-properties p1 p2))
      ;; (message "matched string: %s" abrStr)
      (when (and
             (eq major-mode 'org-mode)
             (eq 'latex-fragment (org-element-type (org-element-context (org-element-at-point)))))          
        (setq local-abbrev-table latex-mode-abbrev-table)
        (when (string-prefix-p "$" abrStr)
          (setq abrStr (string-remove-prefix "$" abrStr)
                p1 (+ p1 1))          
          )
        )
      (setq abrSymbol (abbrev-symbol abrStr))
      (when (and (not check) abrSymbol)            
        (abbrev-insert abrSymbol abrStr p1 p2)
        (xah-abbrev-position-cursor p1)
        )
      abrSymbol
      ))
  )  

(setq abbrev-expand-function 'weiss-check-or-expand-abbrev)

(defun xah-abbrev-enable-function ()
  "Return t if not in string or comment. Else nil.
This is for abbrev table property `:enable-function'.
Version 2016-10-24"
  (let (($syntax-state (syntax-ppss)))
    (not (or (nth 3 $syntax-state) (nth 4 $syntax-state))
         )))


(defun xah-abbrev-position-cursor (&optional @pos)
  "Move cursor back to ▮ if exist, else put at end.
Return true if found, else false.
Version 2016-10-24"
  (interactive)
  (let (($found-p (search-backward "▮" (if @pos @pos (max (point-min) (- (point) 100))) t )))
    (when $found-p (delete-char 1))
    $found-p
    ))

(defun weiss--ahf-avoid-casease ()
  "indent after abbrev expand"
  (casease--end)
  t)

(defun weiss--ahf-indent ()
  "indent after abbrev expand"
  (indent-region (- (point) 50) (+ (point) 50))
  t)

(defun weiss--ahf ()
  "Abbrev hook function, used for `define-abbrev'.
 Our use is to prevent inserting the char that triggered expansion. Experimental.
 the “ahf” stand for abbrev hook function.
Version 2016-10-24"
  t)

(define-minor-mode weiss-abbrev-mode
  "weiss-abbrev-mode"
  :keymap
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd ",") expand-abbrev-maybe)
    keymap
    )
  (when weiss-abbrev-mode
    (when (eq (caar (nth (1- wks-init-emulation-order) emulation-mode-map-alists)) 'weiss-abbrev-mode)
      (pop emulation-mode-map-alists)
      )    
    (add-to-ordered-list 'emulation-mode-map-alists
		                 `((weiss-abbrev-mode . ,weiss-abbrev-mode-map)) wks-init-emulation-order)    
    )
  (abbrev-mode -1)
  )

(define-globalized-minor-mode
  weiss-abbrev-global-mode
  weiss-abbrev-mode
  (lambda () (interactive) (abbrev-mode -1) (weiss-abbrev-mode)))

(weiss-abbrev-global-mode)

(provide 'weiss_settings<abbrevs)
