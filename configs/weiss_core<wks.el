(defmacro wks-create-function (name functions)
  `(defun ,name ()
     "auto generated by wks-create-function"
     (interactive)
     (dolist (x ',functions) (eval x))
     )
  )

(defun wks-define-key (keymap prefix key-cmd-alist)
  "DOCSTRING"
  (interactive)
  (mapc
   (lambda (pair)
     (if (listp (cdr pair))
         (let ((name (cadr pair))
               (functions (cddr pair))
               )
           (eval `(wks-create-function ,name ,functions))             
           (define-key keymap (kbd (concat prefix (car pair))) name)
           )
       (define-key keymap (kbd (concat prefix (car pair))) (cdr pair))
       )
     )
   key-cmd-alist)
  )

(defun wks-unset-key (map keys)
  "DOCSTRING"
  (interactive)
  (mapc '(lambda (x) (define-key map (kbd x) nil)) keys)
  )

(defun wks-define-vanilla-keymap (keymap)
  "DOCSTRING"
  (interactive)
  (let ((key-list
         (append
          '("SPC")
          (mapcar '(lambda (x) (format "%c" x)) (number-sequence 33 126))
          )
         )
        )
    (dolist (x key-list) 
      (define-key keymap (kbd x) #'self-insert-command)
      )
    )
  )

;; (require 'weiss_ui<wks)
;; (require 'weiss_insert-mode<wks)
(provide 'weiss_core<wks)
