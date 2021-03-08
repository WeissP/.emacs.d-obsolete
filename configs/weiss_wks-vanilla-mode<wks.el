(setq wks-vanilla-mode-map (make-sparse-keymap))
(set-keymap-parent wks-vanilla-mode-map wks-vanilla-keymap)  

(defun wks-vanilla-mode-enable ()
  "DOCSTRING"
  (interactive)
  (message "last-command: %s" last-command)
  (deactivate-mark)
  (cond
   ((eq major-mode 'snails-mode)
    ;; (make-local-variable 'wks-vanilla-mode-map)
    (setq-local wks-vanilla-mode-map wks-snails-vanilla-mode-map)
    )
   )
  (wks-vanilla-mode 1)
  )

(defun wks-vanilla-mode-disable ()
  "DOCSTRING"
  (interactive)
  (wks-vanilla-mode -1)
  )

(defun wks-vanilla-mode-init ()
  "DOCSTRING"
  (interactive)
  (wks-vanilla-mode-enable)
  )

(dolist (x '(snails-mode-hook minibuffer-setup-hook)) 
  (add-hook x #'wks-vanilla-mode-enable)  
  )

(define-minor-mode wks-vanilla-mode
  "insert mode"
  :keymap wks-vanilla-mode-map
  (if wks-vanilla-mode
      (progn
        (setq minor-mode-overriding-map-alist (assq-delete-all 'wks-vanilla-mode minor-mode-overriding-map-alist))
        (push `(wks-vanilla-mode . ,wks-vanilla-mode-map) minor-mode-overriding-map-alist)        
        )    
    (set-cursor-color wks-command-mode-cursor-color)
    )
  )

(provide 'weiss_wks-vanilla-mode<wks)
