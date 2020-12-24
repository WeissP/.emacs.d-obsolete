;; -*- lexical-binding: t -*-
;; init for dump

;; [[file:~/.emacs.d/config/emacs-config.org::*init for dump][init for dump:1]]
(defvar weiss/launch-time (current-time))
(defvar weiss/after-buffer-change-function-list nil)
(defvar weiss/after-major-mode-function-list nil)
(defvar weiss/config-path "/home/weiss/.emacs.d/config/")
(defvar weiss/local-package-path "/home/weiss/.emacs.d/local-package/")
(defun weiss--get-config-file-path (path)
  "get config path according to weiss/config-path"
  (interactive)
  (concat weiss/config-path path)
  )

(defvar weiss/cursor-color "#4078f2")
(set-cursor-color weiss/cursor-color)

(defvar weiss/cursor-type '(bar . 2))
(setq-default cursor-type weiss/cursor-type)

(require 'cl-lib)

(defvar weiss-dumped-load-path nil)
(if weiss-dumped-load-path
    (progn
      (setq load-path weiss-dumped-load-path)
      ;; Some shim code for tramp
      (defun tramp-file-name-method--cmacro (&rest args))
      (require 'tramp)
      (setq tramp-mode 1)
      (global-font-lock-mode t)
      (transient-mark-mode t)
      )
  (load (weiss--get-config-file-path "init/weiss-basic-and-misc.el"))  

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
