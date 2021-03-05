(defun weiss-overriding-ryo-define-key (keymap key-cmd-list fun)
    (interactive)
    (mapc
     (lambda (cmd-key)
       (let ((cmd (nth 1 cmd-key))
             (key (nth 0 cmd-key))
             )
         (define-key keymap (kbd key)
           `(menu-item "" ,cmd
                       :filter ,fun)
           )
         )
       )
     key-cmd-list)
    )

  (defmacro weiss-overriding-ryo-push-map (mode keymap)
    `(progn
       (setq minor-mode-overriding-map-alist (assq-delete-all ',mode minor-mode-overriding-map-alist))
       (push '(,mode . ,(symbol-value keymap)) minor-mode-overriding-map-alist)
       )
    )

(provide 'weiss_bindkey<ks)
