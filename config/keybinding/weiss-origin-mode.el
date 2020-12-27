;; -*- lexical-binding: t -*-
;; weiss-origin-mode


;; [[file:~/.emacs.d/config/emacs-config.org::*weiss-origin-mode][weiss-origin-mode:1]]
(defvar weiss-origin-mode-map (make-sparse-keymap))
(defvar weiss-origin-keep-keys nil)

(defun weiss-origin-set-keep-keys (&optional keys)
  "set keys that also used in origin mode, if @keys is nil, only set spc key"
  (interactive)
  (unless keys
    (setq keys '("SPC")))
  (setq weiss-origin-keep-keys (mapcar (lambda (key) (string-to-char (kbd key))) keys))
  )

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
        (when (member (car x) weiss-origin-keep-keys)
          (push x weiss-origin-mode-map)          
          (when is-keymap
            (push 'keymap weiss-origin-mode-map))
          )
        (setq is-keymap nil)
        )
      )    
    (define-key weiss-origin-mode-map (kbd "SPC SPC") (lookup-key (symbol-value (keymap-symbol (current-local-map))) (kbd "SPC")))
    (push 'keymap weiss-origin-mode-map)
    (setq minor-mode-overriding-map-alist (assoc-delete-all 'weiss-origin-mode minor-mode-overriding-map-alist))
    (push `(weiss-origin-mode . ,weiss-origin-mode-map) minor-mode-overriding-map-alist)
    ))

(define-minor-mode weiss-origin-mode
  "keep origin keybindings and only change few keys (like leader key)"
  :keymap weiss-origin-mode-map
  (if weiss-origin-mode
      (progn
        (unless weiss-origin-keep-keys
          (weiss-origin-set-keep-keys))
        (weiss-origin-mode-push-keymap)        
        )
    (setq minor-mode-overriding-map-alist (assoc-delete-all 'weiss-origin-mode minor-mode-overriding-map-alist))
    (setq weiss-origin-keep-keys nil)
    )
  )

(provide 'weiss-origin-mode)
;; weiss-origin-mode:1 ends here
