(setq wks-vanilla-mode-map (make-sparse-keymap))
(set-keymap-parent wks-vanilla-mode-map wks-vanilla-keymap)  

(defun wks-vanilla-mode-enable ()
  "DOCSTRING"
  (interactive)
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
        (when (eq (caar (nth wks-init-emulation-order emulation-mode-map-alists)) 'wks-vanilla-mode)
          (pop emulation-mode-map-alists)
          )        
        (add-to-ordered-list 'emulation-mode-map-alists
		                     `((wks-vanilla-mode . ,wks-vanilla-mode-map)) (1+ wks-init-emulation-order))

        (set-cursor-color wks-vanilla-mode-cursor-color)
        )
    (set-cursor-color wks-command-mode-cursor-color)
    )
  )

(provide 'weiss_wks-vanilla-mode<wks)
