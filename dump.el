(require 'package)
(package-initialize)
(setq quelpa-checkout-melpa-p nil)
(setq quelpa-update-melpa-p nil)
(setq use-package-always-demand t)
(setq use-package-always-ensure t)
(require 'use-package)
(require 'quelpa-use-package)
(quelpa-use-package-activate-advice)  


(add-to-list 'load-path "/home/weiss/.emacs.d/local-package/")
(add-to-list 'load-path "/home/weiss/.emacs.d/local-package/snails/")
(add-to-list 'load-path "/home/weiss/.emacs.d/local-package/keypad/")
(add-to-list 'load-path "/home/weiss/.emacs.d/config/")
(add-to-list 'load-path "/home/weiss/.emacs.d/emacs-application-framework/")

;; (require 'eaf)

(setq weiss-dumped-load-path load-path
      weiss-dumped-p t)

;;; We have to unload tramp in pdump, otherwise tramp will not work.
(tramp-unload-tramp)

;;; Disable GC
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;;; Misc in init.el
(defun xah-get-fullpath (@file-relative-path)
  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path)
  )

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

;;;; UI
(setq initial-frame-alist (quote ((fullscreen . maximized)))) 
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


;;;; Bookmarks
(bookmark-delete "org-capture-last-stored")
(bookmark-delete "org-refile-last-stored")
;; (bookmark-delete "Emacs China")

;;;; Basic modes
(ignore-errors (savehist-mode 1))
(global-linum-mode 1)
;; (save-place-mode 1)
;; (show-paren-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode 1)

(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(electric-pair-mode 1)

(add-hook 'prog-mode-hook #'subword-mode)
(add-hook 'minibuffer-setup-hook #'subword-mode)

;;;; Encoding
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
  :hook (after-init . server-mode))

(use-package super-save
  :diminish
  :config
  (add-to-list 'super-save-triggers 'find-file)
  (super-save-mode +1)
  )

(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  )

(use-package switch-buffer-functions
  ;; :disabled
  :quelpa (switch-buffer-functions :fetcher github
                                   :repo "10sr/switch-buffer-functions-el"))

;; (load "/home/weiss/weiss/switch-buffer-functions-el/switch-buffer-functions.elc") 

(defun weiss-eval-last-sexp()
  (interactive)
  (end-of-line)
  (eval-last-sexp()))

;;;; abbrev
(setq-default abbrev-mode t)
(setq save-abbrevs 'silently)


(use-package hydra 
  :diminish)

(defun weiss-dump ()
  "Dump Emacs."
  (interactive)
  (let ((buf "*dump process*"))
    (make-process
     :name "dump"
     :buffer buf
     :command (list "emacs" "--batch" "-q"
                    "-l" (expand-file-name "dump.el"
                                           user-emacs-directory)))
    (display-buffer buf)))

(defun read-char-picky (prompt chars &optional inherit-input-method seconds)
  "Read characters like in `read-char-exclusive', but if input is
not one of CHARS, return nil.  CHARS may be a list of characters,
single-character strings, or a string of characters."
  (let ((chars (mapcar (lambda (x)
                         (if (characterp x) x (string-to-char x)))
                       (append chars nil)))
        (char  (read-char-exclusive prompt inherit-input-method seconds)))
    (when (memq char chars)
      (char-to-string char))))


;; (dolist (package  '(
;;                     use-package
;;                     hydra
;;                     ;; ui
;;                     doom-themes 
;;                     doom-modeline
;;                     anzu
;;                     all-the-icons
;;                     emojify
;;                     dashboard
;;                     popwin
;;                     which-key
;;                     winner
;;                     ;; edit
;;                     subword
;;                     rotate-text
;;                     expand-region 
;;                     ;; completion
;;                     company
;;                     company-prescient
;;                     company-box
;;                     company-quickhelp
;;                     lsp-mode
;;                     ;; lsp-clients
;;                     lsp-ui
;;                     company-lsp
;;                     lsp-origami
;;                     lsp-python-ms
;;                     ccls
;;                     lsp-julia
;;                     lsp-java
;;                     yasnippet
;;                     ;; lang
;;                     python
;;                     live-py-mode
;;                     php-mode
;;                     xah-elisp-mode
;;                     ;; ivy
;;                     rg
;;                     ivy
;;                     counsel                     
;;                     amx
;;                     prescient
;;                     ivy-prescient
;;                     ivy-yasnippet
;;                     ivy-xref
;;                     flyspell-correct-ivy
;;                     counsel-world-clock
;;                     counsel-tramp
;;                     ivy-rich
;;                     ;; org
;;                     org
;;                     org-fancy-priorities
;;                     org-bullets
;;                     cdlatex
;;                     flycheck
;;                     telega
;;                     )) 
;;   (require package)
;;   )
(load-theme 'doom-one-light t t)
(dolist (package  '(
                    diminish
                    bind-key
                    esup
                    super-save
                    keyfreq
                    switch-buffer-functions
                    hydra
                    weiss_lang
                    weiss_completion
                    weiss_magit
                    doom-themes
                    weiss_ui_before_dump
                    anzu
                    all-the-icons
                    emojify
                    rainbow-mode
                    dashboard
                    popwin
                    which-key
                    ;; weiss_snails 
                    weiss_xfk
                    weiss_rime
                    weiss_web
                    weiss_abbrevs
                    weiss_telega
                    weiss_edit
                    weiss_dired
                    ;; weiss_flycheck
                    weiss_ivy 
                    weiss_keybinding
                    ;; weiss_pdf
                    weiss_shell_or_terminal
                    ;; weiss_translation
                    xfk-functions
                    weiss_org
                    +org
                    )) 
  (require package)
  )



;; (load-theme 'doom-one-light t t)
;; (require 'weiss_ui)
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
