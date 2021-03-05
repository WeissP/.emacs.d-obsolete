(defvar weiss-dumped-p nil)
(if weiss-dumped-p
    (progn
      (setq load-path weiss-dumped-load-path)
      ;; Some shim code for tramp
      (defun tramp-file-name-method--cmacro (&rest args))
      (require 'tramp)
      (setq tramp-mode 1)
      (global-font-lock-mode t)
      (transient-mark-mode t)
      )
  (load "/home/weiss/.emacs.d/configs/weiss_startup.el")
  (weiss-load-module weiss/modules nil)
  )
  
(weiss-load-module weiss/modules t)

(bookmark-load "/home/weiss/.emacs.d/bookmarks" t t t)
(setq bookmark-save-flag 1)

(ignore-errors (savehist-mode 1))
(save-place-mode 1)
(winner-mode)

(weiss-load-keybindings)

(dbus-init-bus :session)   ; for EAF DUMP

(setq weiss-right-top-window (selected-frame))
(setq weiss-left-top-window (make-frame-command))
(select-frame-set-input-focus weiss-right-top-window)

(setq gc-cons-threshold (* (expt 1024 2) 32)
      gc-cons-percentage 0.5)

(message "Emacs is ready, startup cost: %.3f seconds." (time-to-seconds (time-since weiss/launch-time)))
(setq weiss/launch-time nil)
