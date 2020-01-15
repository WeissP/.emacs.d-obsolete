;;; ~/Documents/pi/weiss_init.el -*- lexical-binding: t; -*-

;;; code:
;;; straight.el
(setq
 straight-recipes-gnu-elpa-use-mirror    t
 straight-repository-branch              "develop"
 straight-vc-git-default-clone-depth     1
 ;; straight-enable-use-package-integration nil
 straight-check-for-modifications        '(find-when-checking)
 straight-use-package-by-default  t
 )
(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; use-package.el
(straight-use-package 'use-package)


;; Should set before loading `use-package'
;; (setq use-package-always-defer t)
;; (setq use-package-expand-minimally t)
;; (setq use-package-enable-imenu-support t)

(require 'use-package)

;; Required by `use-package'
(use-package diminish)
(use-package bind-key)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))


(defun xah-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location.

Example: If you have this line
 (xah-get-fullpath \"../xyz.el\")
in the file at
 /home/mary/emacs/emacs_lib.el
then the return value is
 /home/mary/xyz.el
Regardless how or where emacs_lib.el is called.

This function solves 2 problems.

① If you have file A, that calls the `load' on a file at B, and B calls `load' on file C using a relative path, then Emacs will complain about unable to find C. Because, emacs does not switch current directory with `load'.

To solve this problem, when your code only knows the relative path of another file C, you can use the variable `load-file-name' to get the current file's full path, then use that with the relative path to get a full path of the file you are interested.

② To know the current file's full path, emacs has 2 ways: `load-file-name' and `buffer-file-name'. If the file is loaded by `load', then `load-file-name' works but `buffer-file-name' doesn't. If the file is called by `eval-buffer', then `load-file-name' is nil. You want to be able to get the current file's full path regardless the file is run by `load' or interactively by `eval-buffer'."

  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path)
  )

(setq make-backup-files nil)               ; Forbide to make backup files
(setq auto-save-default nil)               ; Disable auto save
(setq-default c-basic-offset   4
              tab-width        4
              indent-tabs-mode nil)
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)

;; UI
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))


;; Recent files
;; recentf-cleanup will update recentf-list
(use-package recentf
  :straight nil
  :hook (after-init . recentf-mode)
  :preface
  (defun snug/recentf-save-list-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-save-list))
        (recentf-save-list)))
    (message ""))
  (defun snug/recentf-cleanup-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-cleanup))
        (recentf-cleanup)))
    (message ""))
  :config
  (run-at-time nil (* 5 60) 'snug/recentf-save-list-silence)

  (setq
   ;; recentf-max-menu-items 150
   recentf-max-saved-items 150
   recentf-auto-cleanup '60
   ;; Recentf blacklist
   recentf-exclude '(
                     ".*autosave$"
                     ".*archive$"
                     ".*.jpg$"
                     ".*.png$"
                     ".*.gif$"
                     ".cache"
                     "cache"
                     ))
  )

;; Basic modes
(ignore-errors (savehist-mode 1))
(global-linum-mode 1)
(save-place-mode 1)
(show-paren-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode 1)

(setq display-line-numbers 't)

(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(electric-pair-mode 1)

(add-hook 'prog-mode-hook #'subword-mode)
(add-hook 'minibuffer-setup-hook #'subword-mode)

;; Encoding
;; UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))

;; Explicitly set the prefered coding systems to avoid annoying prompt
;; from emacs (especially on Microsoft Windows)
(prefer-coding-system 'utf-8)

(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

(setq locale-coding-system 'utf-8
      default-process-coding-system '(utf-8 . utf-8))


;; Start server
(use-package server
  :straight nil
  :hook (after-init . server-mode))

(use-package super-save
  :config
  (add-to-list 'super-save-triggers 'find-file)
  (super-save-mode +1)
  )

(use-package german-holidays
  :config
  (setq calendar-holidays holiday-german-RP-holidays)
  )

(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  )

(use-package save-place
  :straight nil
  :init (setq save-place t)
  :hook (after-init . save-place-mode)
  )

(use-package switch-buffer-functions
  ;; :disabled
  :straight (switch-buffer-functions :type git
                                     :host github
                                     :repo "10sr/switch-buffer-functions-el"))

;; (load "/home/weiss/weiss/switch-buffer-functions-el/switch-buffer-functions.elc") 
(defun test-bind (prev cur)
  (define-key xah-fly-key-map (kbd "0") 'nil)  
  )

(add-hook 'switch-buffer-functions 'test-bind)

(defun weiss-eval-last-sexp()
  (interactive)
  (end-of-line)
  (eval-last-sexp()))

;; (use-package xah-fly-keys
;; :config
;; (xah-fly-keys-set-layout "qwerty")
;; (xah-fly-keys 1)
;; (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
;; )



(load (xah-get-fullpath "weiss_ui"))
(load (xah-get-fullpath "weiss_dired"))
(load (xah-get-fullpath "weiss_edit"))
(load (xah-get-fullpath "weiss_keybinding"))
(load (xah-get-fullpath "weiss_company"))
(load (xah-get-fullpath "weiss_lang"))
(load (xah-get-fullpath "weiss_ivy"))
(load (xah-get-fullpath "weiss_org"))   
(load (xah-get-fullpath "weiss_magit"))
(load (xah-get-fullpath "weiss_pdf"))   
(load (xah-get-fullpath "weiss_shell_or_terminal"))

(require 'org)
;; (update-file-autoloads  "/home/weiss/.emacs.d/autoloads/+org.el" t "/home/weiss/.emacs.d/autoloads/+org-autoloads.el")
;; (require '+org-autoloads)

;; (weiss-xfk-addon-command)               

;; (add-hook 'prog-mode-hook 'xah-fly-command-mode-activate)
;; (add-hook 'elisp-mode-hook 'xah-fly-command-mode-activate)
;; (add-hook 'org-mode-hook 'xah-fly-command-mode-activate)

