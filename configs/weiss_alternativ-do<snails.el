(with-eval-after-load 'snails
  (cl-defmacro snails-create-sync-backend-with-alt-do (&rest args &key name candidate-filter candidate-icon candidate-do candidate-alt-do)
    "Macro to create sync backend code.

`name' is backend name, such 'Foo Bar'.
`candidate-filter' is function that accpet input string, and return candidate list, example format: ((display-name-1 candidate-1) (display-name-2 candidate-2))
`candidate-do-function' is function that confirm candidate, accpet candidate search, and do anything you want.
"
    (let* ((backend-template-name (string-join (split-string (downcase name)) "-"))
           (backend-name (intern (format "snails-backend-%s" backend-template-name)))
           (search-function (intern (format "snails-backend-%s-search" backend-template-name))))
      `(progn
         (defun ,search-function(input input-ticker update-callback)
           (funcall
            update-callback
            ,name
            input-ticker
            (funcall ,candidate-filter input)))

         (defvar ,backend-name nil)

         (setq ,backend-name
               '(("name" . ,name)
                 ("search" . ,search-function)
                 ("icon" . ,candidate-icon)
                 ("do" . ,candidate-do)
                 ("alt-do" . ,candidate-alt-do)
                 )
               )
         )))

  (defun snails-backend-alt-do (backend-name candidate)
    "Confirm candidate with special backend."
    (catch 'backend-do
      (dolist (backend snails-backends)
        (let ((name (cdr (assoc "name" (eval backend))))
              (do-func (cdr (assoc "alt-do" (eval backend)))))

          (when (equal (eval name) backend-name)
            ;; Quit frame first.
            (snails-quit)

            ;; Switch to init frame.
            (when snails-show-with-frame
              (select-frame snails-init-frame))

            ;; Do.
            (funcall do-func candidate)

            (throw 'backend-do nil)
            )))))

  (defun snails-candidate-alt-do ()
    "Confirm current candidate."
    (interactive)
    (let ((candidate-info (snails-candidate-get-info)))
      (if candidate-info
          (snails-backend-alt-do (nth 0 candidate-info) (nth 1 candidate-info))
        (message "Nothing selected."))))
  )

(provide 'weiss_alternativ-do<snails)
