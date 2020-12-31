;; -*- lexical-binding: t -*-
;; basic and misc 

;; [[file:../emacs-config.org::*basic and misc][basic and misc:1]]
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

(require 'cl)
(require 'cl-lib)
(require 'package)
(require 'mode-local)

;; Package & use-package & Quelpa initialize

(package-initialize)
(setq package-archives
      '(("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq package-selected-packages
      '(use-package quelpa-use-package))

(setq use-package-ensure-function 'quelpa)
(setq quelpa-checkout-melpa-p nil)
(setq quelpa-update-melpa-p nil)
(setq use-package-always-demand t)
(setq use-package-always-ensure t)
(require 'use-package)
(require 'quelpa-use-package)
(quelpa-use-package-activate-advice)

;; Required by `use-package'
(use-package diminish)
(use-package bind-key)

(add-to-list 'load-path weiss/config-path)
(add-to-list 'load-path weiss/local-package-path)
(let ((default-directory weiss/config-path))
  (normal-top-level-add-subdirs-to-load-path)
  )
(let ((default-directory weiss/local-package-path))
  (normal-top-level-add-subdirs-to-load-path)
  )
(add-to-list 'load-path "/usr/local/texlive/2020/bin/x86_64-linux")

(setq weiss-dumped-load-path load-path)

(setq-default c-basic-offset   4
              tab-width        4
              indent-tabs-mode nil)
(setq
 large-file-warning-threshold 100000000
 ring-bell-function 'ignore
 auto-save-default nil ; Disable auto save
 make-backup-files nil ; Forbide to make backup files
 display-line-numbers 'relative
 )

(fset 'yes-or-no-p 'y-or-n-p)

;; UI
;; (setq initial-frame-alist (quote ((fullscreen . maximized))))
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(use-package esup
  :commands (esup))

(use-package which-key 
  :diminish
  :hook (after-init . which-key-mode)
  )

;;Bookmarks
(bookmark-load "/home/weiss/.emacs.d/bookmarks" t t t)
(setq bookmark-save-flag 1)
(bookmark-delete "org-capture-last-stored")
(bookmark-delete "org-refile-last-stored")

;; Basic modes
;; (ignore-errors (savehist-mode 1))
;; (global-linum-mode 1)
(save-place-mode -1)
(require 'recentf)
(recentf-mode 1)
;; (recentf-unload-function) 
;; (show-paren-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode 1)
(blink-cursor-mode -1)

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
  :ensure nil
  :hook (after-init . (lambda () (interactive) (unless (or server-name server-mode) (ignore-errors (server-mode))))))

(use-package super-save
  :diminish
  :config
  (add-to-list 'super-save-triggers 'find-file)
  (add-to-list 'super-save-triggers 'org-edit-special)
  (add-to-list 'super-save-triggers 'other-frame)
  (add-to-list 'super-save-triggers 'select-frame-set-input-focus)
  (super-save-mode +1))

(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(defun weiss-empty-defun-list (fun-list)
  "Ryo don't support void function, so we need define some functions before."
  (interactive)
  (dolist (fun fun-list)
    (defalias fun (lambda ()
                    (interactive)
                    (message "function [%s] is void!" (symbol-name fun))))))

;; save sh file auto with executable permission
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(defvar ryo-void-fun-list '(org-noter-sync-current-note weiss-add-enumerate-to-all-headlines weiss-test))
(weiss-empty-defun-list ryo-void-fun-list)
;; basic and misc:1 ends here
