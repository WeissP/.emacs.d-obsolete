;; init-vcs.el --- Initialize version control system configurations.	-*- lexical-binding: t -*-
;;; https://github.com/seagle0128/.emacs.d/blob/8a55bb6fa0a88b0e17bc5f291de88707aa6a1a3f/lisp/init-vcs.el
;;; Code:

;; Git
(use-package magit
  :init
  (defun weiss-magit-commit-and-switch-to-that-buffer()
    (interactive)
    (magit-commit-create)
    (sleep-for 0.5)
    (switch-to-buffer "COMMIT_EDITMSG")
    (xah-fly-insert-mode-activate)
    )

  (defun weiss-magit-command-mode-define-keys ()
    (weiss--define-keys
     xah-fly-key-map
     '(
       ;; ("~" . nil)
       ;; (":" . nil)

       ;; ("SPC" . xah-fly-leader-key-map)
       ;; ("DEL" . xah-fly-leader-key-map)
       ;;   ("RET" . newline)

       ;; ("'" . xah-cycle-hyphen-underscore-space)
       ;; ("," . xah-next-window-or-frame)
       ;; ("-" . xah-backward-punct)
       ;; ("." . xah-forward-right-bracket)
       ;; (";" . xah-end-of-line-or-block)
       ;; ("/" . xah-goto-matching-bracket)
       ;; ("\\" . nil)
       ;; ("=" . xah-forward-equal-sign)
       ;; ("[" . hippie-expand )
       ;; ("]" . nil)
       ;; ("`" . other-frame)

       ;; ("<backtab>" . weiss-indent)
       ;; ("V" . weiss-paste-with-linebreak)
       ;; ("!" . rotate-text)
       ;; ("#" . xah-backward-quote)
       ;; ("$" . xah-forward-punct)

       ;; ("1" . scroll-down)
       ;; ("2" . scroll-up)
       ;; ("3" . delete-other-windows)
       ;; ("4" . split-window-below)
       ;; ("5" . delete-char)
       ;; ("6" . xah-select-block)
       ;; ("7" . xah-select-line)
       ;; ("8" . xah-extend-selection)
       ;; ("9" . xah-select-text-in-quote)
       ;; ("0" . xah-pop-local-mark-ring)

       ;; ("a" . execute-extended-command)
       ;; ("b" . xah-toggle-letter-case)
       ("c" . weiss-magit-commit-and-switch-to-that-buffer)
       ;; ("d" . xah-delete-backward-char-or-bracket-text)
       ;; ("e" . xah-backward-kill-word)
       ;; ("f" . xah-fly-insert-mode-activate)
       ;; ("g" . xah-delete-current-text-block)
       ;; ("h" . backward-char)
       ;; ("i" . xah-beginning-of-line-or-block)
       ;; ("j" . next-line)
       ;; ("k" . previous-line)
       ;; ("l" . forward-char)
       ;; ("m" . xah-backward-left-bracket)
       ;; ("n" . swiper-isearch)
       ;; ("o" . forward-word)
       ("p" . magit-push-current-to-pushremote)
       ("q" . magit-mode-bury-buffer)
       ;; ("r" . xah-kill-word)
       ;; ("s" . open-line)
       ;; ("t" . set-mark-command)
       ;; ("u" . backward-word)
       ;; ("v" . xah-paste-or-paste-previous)
       ;; ("w" . xah-shrink-whitespaces)
       ;; ("x" . xah-cut-line-or-region)
       ;; ("y" . undo)
       ;; ("z" . xah-comment-dwim)
       )))
  
  ;; open magit in current window
  (setq magit-display-buffer-function
        (lambda (buffer)
          (display-buffer
           buffer (if (and (derived-mode-p 'magit-mode)
                           (memq (with-current-buffer buffer major-mode)
                                 '(magit-process-mode
                                   magit-revision-mode
                                   magit-diff-mode
                                   magit-stash-mode
                                   magit-status-mode)))
                      nil
                    '(display-buffer-same-window)))))
  

  :config
  ;; Access Git forges from Magit
  (when (executable-find "cc")
    (use-package forge :demand))

  ;; ;; Show TODOs in magit
  ;; (use-package magit-todos
  ;;   :init
  ;;   (setq magit-todos-nice (if (executable-find "nice") t nil))
  ;;   (magit-todos-mode 1)))

  ;; Walk through git revisions of a file
  (use-package git-timemachine
    :custom-face
    (git-timemachine-minibuffer-author-face ((t (:inherit success))))
    (git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
    :bind (:map vc-prefix-map
                ("t" . git-timemachine)))

  ;; Pop up last commit information of current line
  (use-package git-messenger
    :bind (:map vc-prefix-map
                ("p" . git-messenger:popup-message)
                :map git-messenger-map
                ("m" . git-messenger:copy-message))
    :init (setq git-messenger:show-detail t
                git-messenger:use-magit-popup t)
    :config
    
    (with-no-warnings
      (defun my-git-messenger:format-detail (vcs commit-id author message)
        (if (eq vcs 'git)
            (let ((date (git-messenger:commit-date commit-id))
                  (colon (propertize ":" 'face 'font-lock-comment-face)))
              (concat
               (format "%s%s %s \n%s%s %s\n%s  %s %s \n"
                       (propertize "Commit" 'face 'font-lock-keyword-face) colon
                       (propertize (substring commit-id 0 8) 'face 'font-lock-comment-face)
                       (propertize "Author" 'face 'font-lock-keyword-face) colon
                       (propertize author 'face 'font-lock-string-face)
                       (propertize "Date" 'face 'font-lock-keyword-face) colon
                       (propertize date 'face 'font-lock-string-face))
               (propertize (make-string 38 ?─) 'face 'font-lock-comment-face)
               message
               (propertize "\nPress q to quit" 'face '(:inherit (font-lock-comment-face italic)))))
          (git-messenger:format-detail vcs commit-id author message)))
      (advice-add #'git-messenger:popup-close :override #'ignore)
      (advice-add #'git-messenger:popup-message :override #'my-git-messenger:popup-message)))
  )

;; Open github/gitlab/bitbucket page
(use-package browse-at-remote
  :bind (:map vc-prefix-map
              ("B" . browse-at-remote)))

;; Git related modes
(use-package gitattributes-mode)
(use-package gitconfig-mode)
(use-package gitignore-mode)

(provide 'weiss_magit.el)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-vcs.el ends here
