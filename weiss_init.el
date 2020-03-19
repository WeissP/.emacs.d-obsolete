;;; ~/Documents/pi/weiss_init.el -*- lexical-binding: t; -*-

;;; code:
(let (;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))
  (require 'cl-lib)
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
    (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path)
    )

  (add-to-list 'load-path "/home/weiss/.emacs.d/local-package/")

  (setq-default c-basic-offset   4
                tab-width        4
                indent-tabs-mode nil)
  (setq
   large-file-warning-threshold 100000000
   ring-bell-function 'ignore
   auto-save-default nil ; Disable auto save
   make-backup-files nil ; Forbide to make backup files
   display-line-numbers 't
   )


  (fset 'yes-or-no-p 'y-or-n-p)


  ;; UI
  (setq initial-frame-alist (quote ((fullscreen . maximized)))) 
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
    ;; (run-at-time nil (* 5 60) 'snug/recentf-save-list-silence)

    (setq
     recentf-max-menu-items 150
     recentf-max-saved-items 150
     recentf-auto-cleanup '60
     ;; Recentf blacklist
     recentf-exclude '(
                       ".*autosave$"
                       "/ssh:"
                       ;; "/sudo:"
                       "recentf$"
                       ".*archive$"
                       ".*.jpg$"
                       ".*.png$"
                       ".*.gif$"
                       ".cache"
                       "cache"
                       ))
    )

  ;;Bookmarks
  (bookmark-delete "org-capture-last-stored")
  (bookmark-delete "org-refile-last-stored")
  ;; (bookmark-delete "Emacs China")

  ;; Basic modes
  (ignore-errors (savehist-mode 1))
  (global-linum-mode 1)
  (save-place-mode 1)
  (show-paren-mode 1)
  (delete-selection-mode 1)
  (global-auto-revert-mode 1)



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

  (defun weiss-eval-last-sexp()
    (interactive)
    (end-of-line)
    (eval-last-sexp()))

  ;; abbrev
  (setq-default abbrev-mode t)
  (setq save-abbrevs 'silently)
  

  ;; (require 'org)

  (load (xah-get-fullpath "weiss_ui"))
  (load (xah-get-fullpath "weiss_edit"))
  (load (xah-get-fullpath "weiss_keybinding"))
  (load (xah-get-fullpath "weiss_completion"))
  (load (xah-get-fullpath "weiss_lang"))
  (load (xah-get-fullpath "weiss_ivy"))
  (load (xah-get-fullpath "weiss_magit"))
  (load (xah-get-fullpath "weiss_shell_or_terminal"))
  (load (xah-get-fullpath "weiss_dired"))
  (load (xah-get-fullpath "weiss_org"))   
  (load (xah-get-fullpath "weiss_pdf"))   
  ;; (load (xah-get-fullpath "weiss_calendar"))
  (load (xah-get-fullpath "weiss_flycheck"))
  (load (xah-get-fullpath "weiss_translation"))
  (load (xah-get-fullpath "weiss_eaf"))
  (load (xah-get-fullpath "weiss_snails"))
  (load (xah-get-fullpath "weiss_rime"))
  (load (xah-get-fullpath "weiss_telega"))
  
  ;; (setq tramp-verbose '6)
  ;; (update-file-autoloads  "/home/weiss/.emacs.d/autoloads/+org.el" t "/home/weiss/.emacs.d/autoloads/+org-autoloads.el")
  ;; (require '+org-autoloads)

  ;; (weiss-xfk-addon-command)               

  (add-hook 'prog-mode-hook 'color-outline-mode)
  ;; (add-hook 'elisp-mode-hook 'xah-fly-command-mode-activate)
  ;; (add-hook 'org-mode-hook 'xah-fly-command-mode-activate)

  (add-hook 'switch-buffer-functions 
            (lambda (prev cur) 
              (interactive)
              (change-keybinding)
              ;; (weiss-activate-rime)
              ))
  )


