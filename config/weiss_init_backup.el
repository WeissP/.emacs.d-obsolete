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
  (setq-default abbrev-mode t)
(use-package doom-modeline 
  :diminish
  ;; :diminish doom-modeline-mode
  :init
  ;; (setq doom-modeline-modal-icon nil)
  (setq doom-modeline-window-width-limit fill-column)
  (setq doom-modeline-minor-modes t)
  :hook (after-init . doom-modeline-mode)
  ))
