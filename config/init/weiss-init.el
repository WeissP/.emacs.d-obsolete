;; -*- lexical-binding: t -*-
;; init for dump

;; [[file:~/.emacs.d/config/emacs-config.org::*init for dump][init for dump:1]]
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
  (load "/home/weiss/.emacs.d/config/init/weiss-basic-and-misc.el")  

  (require 'weiss-keybinding)
  (require 'weiss-edit)
  (require 'weiss-completion)
  (require 'weiss-lang)
  (require 'weiss-ivy)
  (require 'weiss-vcs)
  (require 'weiss-shell-or-terminal)
  (require 'weiss-dired)
  (require 'weiss-org)
  (require 'weiss-pdf)
  (require 'weiss-flycheck)
  (require 'weiss-translation)
  (require 'weiss-snails)
  (require 'weiss-sql)
  (require 'weiss-rime)
  (require 'weiss-latex)
  (require 'weiss-telega)
  (require 'weiss-abbrev-mode)
  (require 'weiss-project)
  (require 'weiss-lsp)
  (require 'weiss-ui)

  )

(load (weiss--get-config-file-path "after-dump/weiss-after-dump.el"))

(message "Emacs is ready, startup cost: %.3f seconds." (time-to-seconds (time-since weiss/launch-time)))
(setq weiss/launch-time nil)
;; init for dump:1 ends here
