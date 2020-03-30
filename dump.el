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
(add-to-list 'load-path "/home/weiss/.emacs.d/local-package/snails/")
(add-to-list 'load-path "/home/weiss/.emacs.d/config/")

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

;; (add-to-list 'load-path "/home/weiss/.emacs.d/local-package/")
;; (add-to-list 'load-path "/home/weiss/.emacs.d/local-package/snails/")

(setq weiss-dumped-load-path load-path
      weiss-dumped-p t)

(dolist (package  '(
                    ;; use-package
                    hydra
                    ;; ui
                    doom-themes 
                    doom-modeline
                    anzu
                    all-the-icons
                    highlight-indent-guides
                    emojify
                    dashboard
                    popwin
                    which-key
                    winner
                    ;; edit
                    subword
                    rotate-text
                    expand-region 
                    ;; completion
                    company
                    company-prescient
                    company-box
                    company-quickhelp
                    lsp-mode
                    ;; lsp-clients
                    lsp-ui
                    company-lsp
                    lsp-origami
                    lsp-python-ms
                    ccls
                    lsp-julia
                    lsp-java
                    yasnippet
                    ;; lang
                    python
                    live-py-mode
                    yapfify
                    php-mode
                    xah-elisp-mode
                    ;; ivy
                    rg
                    ivy
                    counsel                     
                    amx
                    prescient
                    ivy-prescient
                    ivy-yasnippet
                    ivy-xref
                    flyspell-correct-ivy
                    counsel-world-clock
                    counsel-tramp
                    ivy-rich
                    ;; org
                    org
                    org-fancy-priorities
                    org-bullets
                    cdlatex
                    flycheck
                    telega
                    )) 
  ;; (straight-use-package package)
  (use-package package)
  )

;; (dolist (package  '(
;;                     ;; lsp-clients
;;                     weiss_org
;;                     weiss_lang
;;                     weiss_completion
;;                     weiss_magit
;;                     weiss_ui
;;                     weiss_snails
;;                     weiss_xfk
;;                     weiss_rime
;;                     weiss_eaf
;;                     weiss_web
;;                     weiss_abbrevs
;;                     weiss_telega
;;                     weiss_edit
;;                     weiss_dired
;;                     weiss_flycheck
;;                     weiss_ivy
;;                     weiss_keybinding
;;                     weiss_pdf
;;                     weiss_shell_or_terminal
;;                     weiss_translation
;;                     xfk-functions
;;                     +org
;;                     weiss_company
;;                     )) 
;;   (require package)
;;   )

;; (load-theme 'doom-one-light t t)
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
