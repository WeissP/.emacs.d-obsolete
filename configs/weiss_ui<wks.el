(defvar wks-command-mode-cursor-color weiss/cursor-color)
(defvar wks-insert-mode-cursor-color "#ff0000")

(defun meow-setup-indicator ()
  "Setup indicator appending the return of function `meow-indicator' to the modeline.
This function should be called after you setup other parts of the mode-line and will work well for most cases.
If this function is not enough for your requirements, use `meow-indicator' to get the raw text for indicator and put it anywhere you want."
  (unless (-contains? mode-line-format '(:eval (meow-indicator)))
    (setq-default mode-line-format (append '((:eval (meow-indicator)) " ") mode-line-format))))

;; (setq-default mode-line-format (append '((:eval (wks-indicator)) " ") mode-line-format))

(defun wks-indicator ()
  "DOCSTRING"
  (interactive)
  (if wks-vanilla-mode
      "vanilla"
    "commmand"
    )
  )

(provide 'weiss_ui<wks)
