;; -*- lexical-binding: t -*-
;; weiss-origin-mode


;; [[file:~/.emacs.d/config/emacs-config.org::*weiss-origin-mode][weiss-origin-mode:1]]
(defvar weiss-origin-mode-map (make-sparse-keymap))
(defvar weiss-origin-keep-keys nil)

(defun weiss-origin-mode-push-keymap ()
  "push origin-mode keymap"
  (interactive)
  (setq weiss-origin-mode-map nil)
  (let ((ryo-keymap
         (eval (intern-soft (concat "ryo-" (symbol-name (car ryo-modal-mode-keymaps)) "-map"))))
        (is-keymap)
        )
    (dolist (x ryo-keymap) 
      (if (eq x 'keymap)
          (setq is-keymap t)
        (when (member (help-key-description (make-vector 1 (car x)) nil) weiss-origin-keep-keys)
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
       (define-key weiss-origin-mode-map (kbd (format "SPC %s" key)) (lookup-key (symbol-value (keymap-symbol (current-local-map))) (kbd key)))
       ) weiss-origin-keep-keys)
    (setq minor-mode-overriding-map-alist (assoc-delete-all 'weiss-origin-mode minor-mode-overriding-map-alist))
    (push `(weiss-origin-mode . ,weiss-origin-mode-map) minor-mode-overriding-map-alist)
    ))

(define-minor-mode weiss-origin-mode
  "keep origin keybindings and only change few keys (like leader key)"
  :keymap weiss-origin-mode-map
  (if weiss-origin-mode
      (progn
        (unless weiss-origin-keep-keys
          (setq weiss-origin-keep-keys '("SPC" "9" "-")))
        (weiss-origin-mode-push-keymap)        
        )
    (setq minor-mode-overriding-map-alist (assoc-delete-all 'weiss-origin-mode minor-mode-overriding-map-alist))
    (setq weiss-origin-keep-keys nil)
    )
  )

(provide 'weiss-origin-mode)
;; weiss-origin-mode:1 ends here
