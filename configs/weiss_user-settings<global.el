(setq-default c-basic-offset   4
              tab-width        4
              indent-tabs-mode nil)
(setq
 large-file-warning-threshold 100000000
 ring-bell-function 'ignore
 auto-save-default nil ; Disable auto save
 make-backup-files nil ; Forbide to make backup files
 )

(defun weiss--get-config-file-path (path)
  "get config path according to weiss/config-path"
  (interactive)
  (concat weiss/config-path path)
  )

(set-cursor-color weiss/cursor-color)
(setq-default cursor-type weiss/cursor-type)

(fset 'yes-or-no-p 'y-or-n-p)

;;Bookmarks
(bookmark-load "/home/weiss/.emacs.d/bookmarks" t t t)
(setq bookmark-save-flag 1)
(bookmark-delete "org-capture-last-stored")
(bookmark-delete "org-refile-last-stored")

(save-place-mode -1)
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

(provide 'weiss_user-settings<global)
