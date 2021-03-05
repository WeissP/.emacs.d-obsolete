(defun weiss-org-exchange-point-or-switch-to-sp ()
  "exchange point if region is aktiv otherwise switch to `weiss-org-sp-mode'"
  (interactive)
  (if (and (use-region-p) (> (- (region-end) (region-beginning)) 1)) 
      (exchange-point-and-mark)      
    (weiss-org-sp-switch)
    )
  )

(defun weiss-org-sp-up ()
  "Move ARG headings up."
  (interactive)
  (let ((p (point))
        (case-fold-search t))
    (cond ((weiss-org-sp--at-property-p)
           (weiss-org-sp--prev-property)
           )
          ((looking-at weiss-org-sp-sharp-begin)           
           (previous-line))
          ((looking-at weiss-org-sp-sharp-end)           
           (weiss-org-sp--sharp-up))
          (t
           (org-backward-heading-same-level 1 t)
           ))
    (if (eq p (point))
        (weiss-org-sp-backward)
      ))  
  )

(defun weiss-org-sp--prev-property ()
  "Move to the previous property line."
  (interactive)
  (let ((bnd (weiss-org-sp--bounds-subtree)))
    (while (and (> (point) (car bnd))
                (re-search-backward "^:" (car bnd) t)
                (weiss-org-sp--invisible-p)))
    ;; (org-speed-move-safe 'outline-previous-visible-heading)
    ))

(defun weiss-org-sp--sharp-up ()
  "Move up to the next #+."
  (let ((pt (point)))
    (while (and (re-search-backward weiss-org-sp-sharp (car (weiss-org-sp--bounds-subtree)) t)
                (weiss-org-sp--invisible-p)))
    (cond ((weiss-org-sp--invisible-p)
           (prog1 nil
             (goto-char pt)))
          ((= pt (point))
           nil)
          (t
           (goto-char
            (match-beginning 0))))))

(defun weiss-org-sp-down ()
  "Move ARG headings down."
  (interactive)
  (let ((p (point))
        (case-fold-search t))
    (cond ((weiss-org-sp--at-property-p)
           (weiss-org-sp--next-property))
          ((looking-at weiss-org-sp-sharp-begin)           
           (weiss-org-sp--sharp-down))
          ((looking-at weiss-org-sp-sharp-end)           
           (weiss-org-sp-forward))
          (t
           (org-forward-heading-same-level 1 t)
           ))
    (when (eq p (point))
      (next-line)
      (beginning-of-line)
      ))    
  )

(defun weiss-org-sp--next-property ()
  "Move to the next property line."
  (interactive)
  (let ((bnd (weiss-org-sp--bounds-subtree))
        (pt (point))
        (success nil))
    (forward-char 1)
    (while (and (null success)
                (< (point) (cdr bnd))
                (re-search-forward "^:" (cdr bnd) t))
      (backward-char 1)
      (if (weiss-org-sp--invisible-p)
          (forward-char 1)
        (setq success t)))
    (unless success
      (goto-char pt))))

(defun weiss-org-sp--sharp-down ()
  "Try to find the next visible #+, else find the next special position"
  (interactive)
  (let ((pt (point))
        (bnd (weiss-org-sp--bounds-subtree))
        )
    (forward-char 2)
    (unless (and (re-search-forward weiss-org-sp-sharp (cdr bnd) t)
                 (not (weiss-org-sp--invisible-p)))
      (goto-char pt)
      (while (and (weiss-org-sp-forward)
                  (weiss-org-sp--invisible-p)))
      )
    )
  )

(defun weiss-org-sp-backward ()
  "Go backwards to closest special position."
  (interactive)
  (re-search-backward weiss-org-sp-regex-full nil t)
  (while (or (weiss-org-sp--invisible-p)
             (not (looking-at "[*#]"))
             (not (bolp)))
    (weiss-org-sp-backward)))

(defun weiss-org-sp-forward ()
  "Go forwards to closest special position, return t if found"
  (interactive)
  (forward-char 1)
  (when (re-search-forward weiss-org-sp-regex-full nil t)
    (beginning-of-line) t
    )  
  )

(defun weiss-org-sp-right ()
  "If cursor is at the begin of #+ block, edit it, otherwise go to the child element, if there is no more child:
if on a: 
todo keyword: cycle it between todo and done
link: follow it
otherwise, go to next special position
"
  (interactive)
  (if (looking-at-p weiss-org-sp-sharp-begin)
      (org-edit-special)  
    (let ((pt (point))
          result)
      (save-restriction
        (org-narrow-to-subtree)
        (forward-char)
        (if (re-search-forward weiss-org-sp-regex nil t)
            (progn
              (goto-char (match-beginning 0))
              (setq result t))
          (widen)
          (re-search-forward " ")
          (let* ((context (org-element-context))
                 (type (org-element-type context)))
            (while (and context (memq type '(verbatim code bold italic underline strike-through subscript superscript)))
              (setq context (org-element-property :parent context)
                    type (org-element-type context)))
            (pcase type
              (`headline
               (when (or (org-element-property :todo-type context)
                         (org-element-property :scheduled context))
                 (org-todo
                  (if (eq (org-element-property :todo-type context) 'done)
                      '"TODO"
                    '"DONE")))
               )
              (`link
               (let* ((lineage (org-element-lineage context '(link) t))
                      (path (org-element-property :path lineage)))
                 (cond
                  ((or (equal (org-element-property :type lineage) "img")
                       (and path (image-type-from-file-name path)))
                   (+org--toggle-inline-images-in-subtree
                    (org-element-property :begin lineage)
                    (org-element-property :end lineage))
                   )
                  ((and
                    (ignore-errors (string-prefix-p "Ʀ" (file-name-nondirectory (buffer-file-name))))
                    (not (one-window-p)))
                   (delete-other-windows)
                   (org-open-at-point)
                   (split-window-below)
                   (org-mark-ring-goto)
                   (beginning-of-line)
                   (recenter nil t)
                   )
                  (t
                   (org-open-at-point)                   
                   )
                  )
                 ))
              (_ ignore)
              )
            (goto-char pt)
            )))
      (weiss-org-sp--ensure-visible)
      result
      ))
  )


(defun weiss-org-sp-left ()
  "Move one level up backwards."
  (interactive)
  (if (looking-at weiss-org-sp-sharp)
      (goto-char (car (weiss-org-sp--bounds-subtree)))
    (ignore-errors
      (org-up-heading-safe))))


(defun weiss-org-sp-switch ()
  "Switch between special position and normal position"
  (interactive)
  (if (weiss-org-sp--special-p)
      (re-search-forward " ")
    (weiss-org-sp-backward)
    )
  )

(defun weiss-org-sp--cut-or-copy-sharp (&optional is-copy)
  "try to cut or copy the all #+ block, else return nil"
  (interactive)
  (when (looking-at weiss-org-sp-sharp-begin)
    (save-excursion
      (let ((p1 (point))
            p2)
        (when (re-search-forward weiss-org-sp-sharp-end (cdr (weiss-org-sp--bounds-subtree)) t)
          (end-of-line)
          (setq p2 (point))
          (if is-copy
              (copy-region-as-kill p1 p2)          
            (kill-region p1 p2))
          t)
        ))    
    )
  )

(defun weiss-org-sp-cut ()
  "Cut #+ block or subtree"
  (interactive)
  (if (looking-at weiss-org-sp-sharp-begin)
      (weiss-org-sp--cut-or-copy-sharp)
    (org-cut-special)
    )
  )

(defun weiss-org-sp-copy ()
  "Cut #+ block or subtree"
  (interactive)
  (if (looking-at weiss-org-sp-sharp-begin)
      (weiss-org-sp--cut-or-copy-sharp t)
    (org-copy-special)
    )
  )

(defun weiss-org-sp--bounds-subtree ()
  "Return bounds of the current subtree as a cons."
  (save-excursion
    (save-match-data
      (condition-case e
          (cons
           (progn
             (org-back-to-heading t)
             (point))
           (progn
             (org-end-of-subtree t t)
             (when (and (org-at-heading-p)
                        (not (eobp)))
               (backward-char 1))
             (point)))
        (error
         (if (string-match
              "^Before first headline"
              (error-message-string e))
             (cons (point-min)
                   (or (ignore-errors
                         (org-speed-move-safe 'outline-next-visible-heading)
                         (point))
                       (point-max)))
           (signal (car e) (cdr e))))))))

(provide 'weiss_functions<weiss-org-sp-mode<org)
