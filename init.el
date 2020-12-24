(load "/home/weiss/.emacs.d/config/init/weiss-init.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cU
   '("801a567c87755fe65d0484cb2bded31a4c5bb24fd1fe0ed11e6c02254017acb2" "dbade2e946597b9cda3e61978b5fcc14fa3afa2d3c4391d477bdaeff8f5638c5" "d4131a682c4436bb5a61103d9a850bf788cbf793f3fd8897de520d20583aeb58" default))
 '(company-F
   '(company-tng-frontend company-pseudo-tooltip-frontend company-echo-metadata-frontend))
 '(company-abort-manual-when-too-short t)
 '(company-begin-commands
   '(xah-fly-insert-mode-activate self-insert-command delete-backward-char org-self-insert-command org-delete-backward-char weiss-disable-abbrev-and-activate-insert-mode kill-line weiss-delete-forward-with-region weiss-delete-backward-with-region weiss-cut-line-or-delete-region delete-backward-char))
 '(company-dabbrev-downcase nil)
 '(company-frontends
   '(company-tng-frontend company-pseudo-tooltip-frontend company-echo-metadata-frontend))
 '(company-global-modes '(not dired-mode dired-sidebar-mode))
 '(company-idle-delay 0.01)
 '(company-minimum-prefix-length 3)
 '(company-require-match nil)
 '(default-input-method "rime")
 '(display-line-numbers-grow-only t)
 '(display-line-numbers-width 3)
 '(hs-special-modes-alI
   '((c-mode "{" "}" "/[*/]" nil nil)
     (c++-mode "{" "}" "/[*/]" nil nil)
     (rust-mode "{" "}" "/[*/]" nil nil)) t)
 '(hs-special-modes-alist
   '((c-mode "{" "}" "/[*/]" nil nil)
     (c++-mode "{" "}" "/[*/]" nil nil)
     (rust-mode "{" "}" "/[*/]" nil nil)) t)
 '(line-number-display-limit-width 200)
 '(org-file-apps
   '((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . emacs)
     ("\\.txt\\'" . "notepad.exe %s")))
 '(package-selected-packages
   '(selected ryo-modal web-beautify http edit-indirect multiple-cursors pdf-view-restore lsp-pyright bison-mode flex flex-mode explain-pause-mode fuz ein exec-path-from-shell polymode deferred anaphora jupyter websocket simple-httpd zmq docker-tramp cmake-ide levenshtein hl-todo dropdown-remote nyan-mode beacon nov esxml go-impl go-fill-struct go-dlv go-mode highlight-parentheses rainbow-blocks guess-language wucuo telega bitbake tao-theme yapfify magit use-package quelpa-use-package))
 '(safe-local-variable-values
   '((eval when
           (and
            (buffer-file-name)
            (not
             (file-directory-p
              (buffer-file-name)))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (unless
               (featurep 'package-build)
             (let
                 ((load-path
                   (cons "../package-build" load-path)))
               (require 'package-build)))
           (unless
               (derived-mode-p 'emacs-lisp-mode)
             (emacs-lisp-mode))
           (package-build-minor-mode)
           (setq-local flycheck-checkers nil)
           (set
            (make-local-variable 'package-build-working-dir)
            (expand-file-name "../working/"))
           (set
            (make-local-variable 'package-build-archive-dir)
            (expand-file-name "../packages/"))
           (set
            (make-local-variable 'package-build-recipes-dir)
            default-directory)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "#4078f2"))))
 '(flycheck-posframe-border-face ((t (:inherit default))))
 '(git-timemachine-minibuffer-author-face ((t (:inherit success))))
 '(git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
 '(hl-paren-face ((t (:weight bold))) t)
 '(ivy-minibuffer-match-face-1 ((t (:inherit font-lock-doc-face :foreground nil))))
 '(org-ellipsis ((t (:foreground nil)))))
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
