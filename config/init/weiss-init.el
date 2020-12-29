;; -*- lexical-binding: t -*-
;; init for dump

;; [[file:../emacs-config.org::*init for dump][init for dump:1]]
(defvar weiss/launch-time (current-time))
(defvar weiss-dumped-load-path nil)
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
  (load "/home/weiss/.emacs.d/config/init/weiss-startup.el")
  )

(load (weiss--get-config-file-path "after-dump/weiss-after-dump.el"))

(message "Emacs is ready, startup cost: %.3f seconds." (time-to-seconds (time-since weiss/launch-time)))
(setq weiss/launch-time nil)
;; init for dump:1 ends here
