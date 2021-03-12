(defvar wks-command-mode-cursor-color weiss/cursor-color)
(defvar wks-vanilla-mode-cursor-color "#FF9239")

(defvar wks-command-mode-cursor-type 'bar)
(defvar wks-vanilla-mode-cursor-type 'bar)

(defvar weiss/disable-cursor-list '(dired-mode pdf-view-mode))

(defun weiss-update-cursor-face (&rest args)
  "disable cursor in dired-mode"
  (interactive)
  (if (member major-mode weiss/disable-cursor-list)
      (setq cursor-type nil)
    (if wks-vanilla-mode
        (progn
          (setq cursor-type wks-vanilla-mode-cursor-type)
          (set-cursor-color wks-vanilla-mode-cursor-color)                  
          )
      (setq cursor-type wks-command-mode-cursor-type)
      (set-cursor-color wks-command-mode-cursor-color)        
      )
    )
  
  )

(add-hook 'window-state-change-functions #'weiss-update-cursor-face)
(add-hook 'wks-switch-state-hook #'weiss-update-cursor-face)

(provide 'weiss_ui<wks)
