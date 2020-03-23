;; dired-video-preview-mode.el --- preview video with eaf.	-*- lexical-binding: t -*-
;; (dired-file-name-at-point)
(require 'eaf)

(add-to-list 'eaf-js-video-player-keybinding '("p" . "set_preview_time"))
(add-to-list 'eaf-js-video-player-keybinding '("m" . "mute"))
(add-to-list 'eaf-js-video-player-keybinding '("C-s" . "toggle_play")) ; space is maped to leader key.

(defun preview--play-video (video-name-with-path)
  "Start video always at 300s and without sound"
  (interactive)
  (eaf-open video-name-with-path)
  ;; (sleep-for 0.8)
  ;; (eaf-proxy-mute)
  (eaf-proxy-set_preview_time)
  ;; (sleep-for 5)
  )

(defun preview--play-video-background (current-dired-buf video-name-with-path)
  "Start video background always at 300s and without sound"
  (interactive)
  (when (string-match "\\.mp4" video-name-with-path)
    (setq eaf--monitor-configuration-p nil)
    (preview--play-video video-name-with-path)
    (switch-to-buffer current-dired-buf)
    (setq eaf--monitor-configuration-p t)
    ))

(defun preview--kill-all-video-buffer (current-video-name-with-path)
  "Kill all video buffer. FIXME: Now can only kill all eaf buffer"
  (interactive)
  (dolist (x (buffer-list) nil)
    (when (and (string-match "eaf" (format "%s" (with-current-buffer x major-mode)))
               (not (string-match (buffer-name x) current-video-name-with-path)))
      (kill-buffer x))))

(defun play-video-in-other-window (next-video-name-with-path nextp)
  "① switch to the buffer whose name is the current video's name
② kill all the video buffer without current video
③ open the next video background
"
  (interactive)
  (if nextp
      (dired-next-line 1)
    (dired-previous-line 1)
    )
  (let ((current-video-name-without-path (file-name-nondirectory (dired-file-name-at-point)))
        (current-video-name-with-path (dired-file-name-at-point))
        (current-dired-buf (current-buffer)))

    (other-window 1)
    
    ;; (if (get-buffer current-video-name-without-path)
    ;;     ;; (switch-to-buffer-other-window current-video-name-without-path) ; due to some unknow resaon, some times will focus not go back.
    ;;     ;; (progn
    ;;     (switch-to-buffer current-video-name-without-path)
    ;;   ;; )
    ;;   (when (string-match "\\.mp4" current-video-name-without-path)
    ;;     ;; (progn
    ;;     ;; (other-window 1)
    ;;     ;; (message "no current video!")
    ;;     (preview--play-video current-video-name-with-path)
    ;;     ;; (eaf-open current-video-name)
    ;;     ))
    (eaf-open current-video-name-with-path) ; eaf will auto check if this file is open
    ;; (eaf-proxy-mute)
    ;; (eaf-proxy-set_preview_time)
    
    (preview--kill-all-video-buffer current-video-name-with-path)
    (other-window 1)

    (preview--play-video-background current-dired-buf next-video-name-with-path)


    ))

(defun video-preview-next-file ()
  "Next line and preview"
  (interactive)
  (dired-next-line 2) ; to get the next video name
  (play-video-in-other-window (dired-file-name-at-point) nil)
  )

(defun video-preview-previous-file ()
  "Next line and preview"
  (interactive)
  (dired-previous-line 2) ; to get the next video name
  (play-video-in-other-window (dired-file-name-at-point) t)
  )



(defun toggle-play-video-in-other-window ()
  "toggle video in other window"
  (interactive)
  (other-window 1)
  (eaf-proxy-toggle_play)
  (other-window 1)
  )

(defun preview-open-file ()
  "open file in external app"
  (interactive)
  (xah-open-in-external-app)
  (preview--kill-all-video-buffer "")
  )

(defun check-cursor-color (prev sur)
  "if preview mode is on, change the cursor color"
  (interactive)
  (if dired-video-preview-mode
      (set-cursor-color "orange")
    (set-cursor-color "#4078f2")
    )
  )

(defun dired-video-preview-mode-enable ()
  "enable dired video preview mode"
  (interactive)
  (xah-fly-command-mode-activate)
  (set-cursor-color "orange")
  (add-hook 'switch-buffer-functions 'check-cursor-color)
  )

(defun dired-video-preview-mode-disable ()
  "disable dired video preview mode"
  (interactive)
  (preview--kill-all-video-buffer "")
  (xah-fly-command-mode-activate)
  (set-cursor-color "#4078f2")
  (remove-hook 'switch-buffer-functions 'check-cursor-color nil)
  )

;;;###autoload
(define-minor-mode dired-video-preview-mode
  "only for video preview"
  :lighter " video" ; set a simple mode name in the minor-mode-alist
  (if dired-video-preview-mode
      (dired-video-preview-mode-enable)
    (dired-video-preview-mode-disable)
    )
  )

(provide 'dired-video-preview-mode)
;;; dired-video-preview-mode.el ends here

(defun weiss-test ()
  "DOCSTRING"
  (interactive)
  (call-process video-preview-next-file))

