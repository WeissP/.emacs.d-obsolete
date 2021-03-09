(defvar wks-command-mode-cursor-color weiss/cursor-color)
(defvar wks-vanilla-mode-cursor-color "#FF9239")

(defun weiss-update-cursor-face (&rest args)
  "disable cursor in dired-mode"
  (interactive)
  (if (eq major-mode 'dired-mode)
      (setq cursor-type nil)
    (if wks-vanilla-mode
        (progn
          (setq cursor-type 'hbar)
          (set-cursor-color wks-vanilla-mode-cursor-color)                  
          )
      (setq cursor-type 'bar)
      (set-cursor-color wks-command-mode-cursor-color)        
      )
    )

  )

(add-hook 'window-state-change-functions #'weiss-update-cursor-face)
(add-hook 'wks-switch-state-hook #'weiss-update-cursor-face)

(provide 'weiss_ui<wks)
