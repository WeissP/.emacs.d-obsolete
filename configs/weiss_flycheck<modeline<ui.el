;; (defvar-local weiss-mode-line-flycheck-errors nil)

;; (defun doom-modeline--flycheck-count-errors ()
;;   "Count the number of ERRORS, grouped by level.

;; Return an alist, where each ITEM is a cons cell whose `car' is an
;; error level, and whose `cdr' is the number of errors of that
;; level."
;;   (let ((info 0) (warning 0) (error 0))
;;     (mapc
;;      (lambda (item)
;;        (let ((count (cdr item)))
;;          (pcase (flycheck-error-level-compilation-level (car item))
;;            (0 (cl-incf info count))
;;            (1 (cl-incf warning count))
;;            (2 (cl-incf error count)))))
;;      (flycheck-count-errors flycheck-current-errors))
;;     `((info . ,info) (warning . ,warning) (error . ,error))))

;; (defun weiss-test ()
;;   "DOCSTRING"
;;   (interactive)
;;   (message "%s" (cdr (assoc 'error (doom-modeline--flycheck-count-errors))) ))

;; (defun weiss-mode-line-update-flycheck-errors (&rest args)
;;   "DOCSTRING"
;;   (interactive)
;;   (if flycheck-mode 
;;       (let ((c (cdr (assoc 'error (doom-modeline--flycheck-count-errors))))
;;             )
;;         (if (eq c 0)
;;             (setq weiss-mode-line-flycheck-errors nil)
;;           (setq weiss-mode-line-flycheck-errors
;;                 (propertize "I" 'face
;;                             '(:foreground "red" :weight 'bold))
;;                 ;; (format "   Error:%s" c)
;;                 )          
;;           )
;;         )
;;     (setq weiss-mode-line-flycheck-errors nil)    
;;     )
;;   )

;; (add-hook 'flycheck-status-changed-functions #'weiss-mode-line-update-flycheck-errors)
;; (add-hook 'flycheck-mode-hook #'weiss-mode-line-update-flycheck-errors)

(provide 'weiss_flycheck<modeline<ui)
