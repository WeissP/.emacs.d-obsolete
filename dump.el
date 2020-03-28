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
                    company
                    ivy
                    counsel 
                    org 
                    which-key
                    swiper 
                    ivy-prescient 
                    doom-themes 
                    ;; doom-one-light-theme
                    doom-modeline
                    popwin
                    winner
                    elec-pair 
                    expand-region 
                    flyspell 
                    hydra
                    )) 
  (straight-use-package package))

;; (load-theme 'doom-one-light-theme t t)
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
