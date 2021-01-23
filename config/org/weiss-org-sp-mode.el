;; -*- lexical-binding: t -*-
;; define mode

;; [[file:../emacs-config.org::*define mode][define mode:1]]
(defvar weiss-org-sp-mode-map (make-sparse-keymap))

(define-minor-mode weiss-org-sp-mode
  "weiss-org-sp-mode"
  :keymap weiss-org-sp-mode-map
  (if weiss-org-sp-mode
      (progn
        (weiss-overriding-ryo-push-map weiss-org-sp-mode weiss-org-sp-mode-map)
        (add-hook 'ryo-modal-mode-hook 'weiss-org-sp--push-keymap)
        )
    (setq minor-mode-overriding-map-alist (assq-delete-all 'weiss-org-sp-mode minor-mode-overriding-map-alist))
    (remove-hook 'ryo-modal-mode 'weiss-org-sp--push-keymap)
    )
  )

(defun weiss-org-sp--push-keymap ()
  "DOCSTRING"
  (interactive)
  (when ryo-modal-mode
    (weiss-overriding-ryo-push-map weiss-org-sp-mode weiss-org-sp-mode-map))  
  )

;; only work in special position
(let ((key-cmd-list '(
                      ("j" weiss-org-sp-down)
                      ("k" weiss-org-sp-up)
                      ("i" weiss-org-sp-left)
                      ("l" weiss-org-sp-right)
                      ("r" weiss-org-refile)
                      ("v" org-paste-special)
                      ("w" org-narrow-to-subtree)
                      ))
      (fun (lambda (cmd) (interactive) (when (and ryo-modal-mode (weiss-org-sp--special-p))  cmd))))
  (weiss-overriding-ryo-define-key weiss-org-sp-mode-map key-cmd-list fun)  
  )

;; only work in heading or #+ block begin and there is no region
(let ((key-cmd-list '(
                      ("c" weiss-org-sp-copy)
                      ("d" weiss-org-sp-cut)
                      ))
      (fun (lambda (cmd) (interactive)
             (when (and ryo-modal-mode
                        (not (use-region-p))
                        (or (org-at-heading-p) (looking-at-p weiss-org-sp-sharp-begin))) cmd))))
  (weiss-overriding-ryo-define-key weiss-org-sp-mode-map key-cmd-list fun)  
  )
;; define mode:1 ends here

;; predicate


;; [[file:../emacs-config.org::*predicate][predicate:1]]
(defvar weiss-org-sp-sharp "^#\\+"
  "Shortcut for the org's #+ regex.")

(defvar weiss-org-sp-sharp-begin "^#\\+begin"
  "Shortcut for the org's #+ regex.")

(defvar weiss-org-sp-sharp-end "^#\\+end"
  "Shortcut for the org's #+ regex.")

(defvar weiss-org-sp-regex "^\\(?:\\*\\|#\\+\\)"
  "Shortcut for weiss-org-sp's special regex.")

(defvar weiss-org-sp-regex-full "^\\(?:\\*+ \\|#\\+\\|:\\)"
  "Shortcut for weiss-org-sp's special regex.")

(defun weiss-org-sp--special-p ()
  "Return t if point is special.
When point is special, alphanumeric keys call commands instead of
calling `self-insert-command'."
  (and (bolp)
       (or
        (looking-at weiss-org-sp-regex)
        (weiss-org-sp--at-property-p)
        (looking-back "^\\*+" (line-beginning-position))
        (looking-at "CLOCK:"))))

(defun weiss-org-sp--ensure-visible ()
  "Remove overlays hiding point."
  (let ((overlays (overlays-at (point)))
        ov expose)
    (while (setq ov (pop overlays))
      (if (and (invisible-p (overlay-get ov 'invisible))
               (setq expose (overlay-get ov 'isearch-open-invisible)))
          (funcall expose ov)))))

(defun weiss-org-sp--at-property-p ()
  "Return t if point is at property."
  (looking-at "^:"))

(defun weiss-org-sp--invisible-p ()
  "Test if point is hidden by an `org-block' overlay."
  (cl-some (lambda (ov) (memq (overlay-get ov 'invisible)
                              '(org-hide-block outline)))
           (overlays-at (point))))
;; predicate:1 ends here

;; functions

;; [[file:../emacs-config.org::*functions][functions:1]]
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

;; (defun weiss-org-sp-right ()
;;   "Move right. If cursor is at the begin of #+ block, edit it"
;;   (interactive)
;;   (if (looking-at-p weiss-org-sp-sharp-begin)
;;       (org-edit-special)  
;;     (let ((pt (point))
;;           result)
;;       (save-restriction
;;         (org-narrow-to-subtree)
;;         (forward-char)
;;         (if (re-search-forward weiss-org-sp-regex nil t)
;;             (progn
;;               (goto-char (match-beginning 0))
;;               (setq result t))
;;           (goto-char pt)))
;;       (weiss-org-sp--ensure-visible)
;;       result))
;;   )
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
                 (if (or (equal (org-element-property :type lineage) "img")
                         (and path (image-type-from-file-name path)))
                     (+org--toggle-inline-images-in-subtree
                      (org-element-property :begin lineage)
                      (org-element-property :end lineage))
                   (org-open-at-point))))
              (_ ignore)
              )
            (goto-char pt)
            )))
      (weiss-org-sp--ensure-visible)
      result))
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
;; functions:1 ends here

;; addvices

;; [[file:../emacs-config.org::*addvices][addvices:1]]
(advice-add 'xah-open-file-at-cursor
            :before
            '(lambda () (interactive)
               (ignore-errors
                 (when (or (weiss-org-sp--at-property-p)
                           (looking-at weiss-org-sp-sharp-begin))
                   (re-search-forward ":tangle " (line-end-position) t)
                   ))
               ))
;; addvices:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-org-sp-mode)
;; end:1 ends here
