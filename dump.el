(require 'package)
(package-initialize)
(setq use-package-ensure-function 'quelpa)
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
(add-to-list 'load-path "/home/weiss/.emacs.d/local-package/dired-video-preview/")
(add-to-list 'load-path "/usr/local/texlive/2020/bin/x86_64-linux")

(setq weiss-dumped-load-path load-path
      weiss-dumped-p t)

;;;;; We have to unload tramp in pdump, otherwise tramp will not work.
(tramp-unload-tramp)

;;; Disable GC
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(load "/home/weiss/.emacs.d/config/init_before_dump.el")

(load-theme 'doom-one-light t t)

(dolist (package  '(
                    weiss_abbrevs
                    diminish
                    bind-key
                    esup
                    switch-buffer-functions
                    hydra
                    ;; weiss_lang
                    weiss_completion
                    weiss_magit
                    doom-themes
                    weiss_ui_before_dump
                    weiss_xfk
                    weiss_rime
                    weiss_web
                    weiss_telega
                    weiss_edit
                    weiss_dired
                    weiss_ivy
                    weiss_keybinding
                    weiss_pdf_tools
                    weiss_translation
                    xfk-functions
                    weiss_org
                    +org
                    weiss_flycheck
                    weiss_latex
                    ;; weiss_lsp
                    weiss_sql
                    weiss_snails
                    weiss_project
                    weiss_cal
                    weiss_jupyter
                    ;; weiss_shell_or_terminal
                    ;; weiss_read
                    ;; weiss_eaf
                    ;; weiss_flyspell
                    ))
  (require package)
  )

(save-place-mode -1)
(load "/home/weiss/.emacs.d/recentf")
;; (recentf-unload-function)
;; (recentf-mode -1)
;; (load-theme 'doom-one-light t t)
;; (require 'weiss_ui)
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
