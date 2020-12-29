;; -*- lexical-binding: t -*-
;; weiss-overriding-ryo-mode

;; [[file:../emacs-config.org::*weiss-overriding-ryo-mode][weiss-overriding-ryo-mode:1]]
(define-minor-mode weiss-overriding-ryo-mode
  "weiss-overriding-ryo-mode"
  :keymap (make-sparse-keymap)
  (if weiss-overriding-ryo-mode
      (progn
        (push `(weiss-overriding-ryo-mode . ,weiss-overriding-ryo-mode-map) minor-mode-overriding-map-alist)
        (add-hook 'ryo-modal-mode-hook 'weiss--overriding-push-map-if-ryo-is-enabled)
        )
    (setq minor-mode-overriding-map-alist (assq-delete-all 'weiss-overriding-ryo-mode minor-mode-overriding-map-alist))
    (setq weiss-overriding-ryo-mode-map (make-sparse-keymap))
    )
  )

(defun weiss-overriding-define-key (key-cmd-list)
  (interactive)
  (mapc
   (lambda (cmd-key)
     (let ((cmd (nth 1 cmd-key))
           (key (nth 0 cmd-key))
           )
       (define-key weiss-overriding-ryo-mode-map (kbd key)
         `(menu-item "" ,cmd
                     :filter (lambda (cmd) (when ryo-modal-mode cmd)))
         )
       )
     )
   key-cmd-list)
  )

(defun weiss--overriding-push-map-if-ryo-is-enabled ()
  "DOCSTRING"
  (interactive)
  (when ryo-modal-mode
    (setq minor-mode-overriding-map-alist (assq-delete-all 'weiss-overriding-ryo-mode minor-mode-overriding-map-alist))
    (push `(weiss-overriding-ryo-mode . ,weiss-overriding-ryo-mode-map) minor-mode-overriding-map-alist)
    )  
  )

(provide 'weiss-overriding-ryo-mode)
;; weiss-overriding-ryo-mode:1 ends here
