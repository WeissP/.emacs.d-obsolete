;; -*- lexical-binding: t -*-
;; vcs
;; :PROPERTIES:
;; :header-args: :tangle vcs/weiss-vcs.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*vcs][vcs:1]]
;; Git
(use-package magit
  :init
  (setq magit-log-section-commit-count 15)

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
  ;; (when (executable-find "cc")
  ;; (use-package forge :demand))

  ;; ;; Show TODOs in magit
  ;; (use-package magit-todos
  ;;   :init
  ;;   (setq magit-todos-nice (if (executable-find "nice") t nil))
  ;;   (magit-todos-mode 1)))

  ;; Walk through git revisions of a file
  (use-package git-timemachine
    :defer t
    :custom-face
    (git-timemachine-minibuffer-author-face ((t (:inherit success))))
    (git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
    :bind (:map vc-prefix-map
                ("t" . git-timemachine)))

  ;; Pop up last commit information of current line
  (use-package git-messenger
    :defer t
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
  :defer t
  :bind (:map vc-prefix-map
              ("B" . browse-at-remote)))

;; Git related modes
(use-package gitattributes-mode
  )
(use-package gitconfig-mode
  )
(use-package gitignore-mode
  )

(provide 'weiss-vcs)
;; vcs:1 ends here
;; vcs:1 ends here
