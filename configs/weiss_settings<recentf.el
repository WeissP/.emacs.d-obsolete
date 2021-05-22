(with-eval-after-load 'weiss_after-dump-misc
  (add-hook 'after-init-hook #'recentf-mode)

  (load (weiss--get-config-file-path "recentf"))
  (setq recentf-save-file (weiss--get-config-file-path "recentf"))

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
  (run-at-time nil (* 5 60) 'snug/recentf-save-list-silence)
  (run-at-time nil (* 5 60) 'snug/recentf-cleanup-silence)
  (setq
   recentf-max-menu-items 150
   recentf-max-saved-items 300
   ;; recentf-auto-cleanup '60
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
                     ".*.mp4$"
                     ".cache"
                     "cache"
                     "<none>.tex"
                     "frag-master.tex"
                     "_region_.tex"
                     "COMMIT_EDITMSG\\'"
                     ".*Ʀ.*\\.org$"
                     ))
  (load (weiss--get-config-file-path "recentf"))
  )

(provide 'weiss_settings<recentf)
