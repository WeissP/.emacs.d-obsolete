;; -*- lexical-binding: t -*-
;; weiss-origin-mode


;; [[file:../emacs-config.org::*weiss-origin-mode][weiss-origin-mode:1]]
(defvar weiss-origin-mode-map (make-sparse-keymap))
(defvar weiss-origin-keep-keys nil)

(defun weiss-origin-mode-push-keymap (&optional key-list)
  "push origin-mode keymap, the first element in `weiss-origin-keep-keys' will be the only leader key"
  (interactive)
  (setq weiss-origin-mode-map nil)
  (unless key-list (setq key-list '("SPC" "9" "s" "-" "<deletechar>")))
  (let ((ryo-keymap
         (eval (intern-soft (concat "ryo-" (symbol-name (car ryo-modal-mode-keymaps)) "-map"))))
        (is-keymap)
        )
    (dolist (x ryo-keymap) 
      (if (eq x 'keymap)
          (setq is-keymap t)
        (when (member (help-key-description (make-vector 1 (car x)) nil) key-list)
          (push x weiss-origin-mode-map)          
          (when is-keymap
            (push 'keymap weiss-origin-mode-map))
          )
        (setq is-keymap nil)
        )
      )    
    (push 'keymap weiss-origin-mode-map)
    (mapc 
     (lambda (key)       
       (define-key weiss-origin-mode-map (kbd (format "%s %s" (car key-list) key)) (lookup-key (symbol-value (keymap-symbol (current-local-map))) (kbd key)))
       ) key-list)
    (setq minor-mode-overriding-map-alist (assoc-delete-all 'weiss-origin-mode minor-mode-overriding-map-alist))
    (push `(weiss-origin-mode . ,weiss-origin-mode-map) minor-mode-overriding-map-alist)
    ))


(defun weiss-origin-mode-enable ()
  "enable origin mode"
  (interactive)
  (unless weiss-origin-mode (weiss-origin-mode 1))
  )

(define-minor-mode weiss-origin-mode
  "keep origin keybindings and only change few keys (like leader key)"
  :keymap weiss-origin-mode-map
  (if weiss-origin-mode
      (progn        
        (weiss-origin-mode-push-keymap (cdr (assoc major-mode weiss-origin-keep-keys)))        
        (when ryo-modal-mode (ryo-modal-mode -1))
        )
    (setq minor-mode-overriding-map-alist (assoc-delete-all 'weiss-origin-mode minor-mode-overriding-map-alist))
    )
  )

(provide 'weiss-origin-mode)
;; weiss-origin-mode:1 ends here
