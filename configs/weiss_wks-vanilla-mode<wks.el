(defvar wks-vanilla-mode-map (make-sparse-keymap))
(wks-define-vanilla-keymap wks-vanilla-mode-map)

(defun wks-vanilla-mode-enable ()
  "DOCSTRING"
  (interactive)
  (deactivate-mark)
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
        ;; (add-to-ordered-list 'emulation-mode-map-alists
		;; `((wks-vanilla-mode . ,wks-vanilla-mode-map)))
        (add-to-ordered-list 'minor-mode-overriding-map-alist
		                     `((wks-vanilla-mode . ,wks-vanilla-mode-map)))

        (set-cursor-color wks-vanilla-mode-cursor-color)
        )
    (set-cursor-color wks-command-mode-cursor-color)
    )
  )

(provide 'weiss_wks-vanilla-mode<wks)
