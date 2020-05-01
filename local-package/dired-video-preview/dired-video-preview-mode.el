;; dired-video-preview-mode.el --- preview video with eaf.	-*- lexical-binding: t -*-
(require 'eaf)

(add-to-list 'eaf-js-video-player-keybinding '("p" . "set_preview_time"))
(add-to-list 'eaf-js-video-player-keybinding '("m" . "mute"))
(add-to-list 'eaf-js-video-player-keybinding '("C-s" . "toggle_play")) ; space is maped to leader key.

(setq eaf-js-video-player-keybinding
      '(
        ("M-g" . "exit_fullscreen")
        ("<f12>" . "open_dev_tool_page")
        ("h" . "backward")
        ("l" . "video_forward")
        ("r" . "restart")
        ("j" . "decrease_volume")
        ("k" . "increase_volume")
        ("x" . "close_buffer")
        ("c--" . "zoom_out")
        ("C-=" . "zoom_in")
        ("C-0" . "zoom_reset")
        ("p" . "set_preview_time")
        ("m" . "mute")
        ("C-s" . "toggle_play")
        )
      )

(eaf-bind-key xah-next-window-or-frame "0" eaf-js-video-player-keybinding)
(eaf-bind-key xah-fly-leader-key-map "SPC" eaf-js-video-player-keybinding)

(defun preview--play-video (video-name-with-path)
  "Start video always at 300s and without sound"
  (eaf-open video-name-with-path)
  ;; (eaf-proxy-mute)
  ;; (eaf-proxy-set_preview_time)
  )

(defun preview--check-if-playable (video-name-with-path)
  "check if this file's extension is in eaf-video-extension-list"
  (string-match "\\(mp4\\|rmvb\\|ogg\\|avi\\|mkv\\)" (file-name-extension video-name-with-path)))

(defun preview--play-video-background (current-dired-buf video-name-with-path)
  "Start video background always at 300s and without sound"
  (when (preview--check-if-playable video-name-with-path)
    (setq eaf--monitor-configuration-p nil)
    (preview--play-video video-name-with-path)
    (switch-to-buffer current-dired-buf)
    (setq eaf--monitor-configuration-p t)
    ))

(defun preview--kill-all-video-buffer (current-video-name-with-path)
  "Kill all video buffer. FIXME: Now can only kill all eaf buffer"
  (dolist (x (buffer-list) nil)
    (when (and (string-match "eaf" (format "%s" (with-current-buffer x major-mode)))
               (not (string-match (buffer-name x) current-video-name-with-path)))
      (kill-buffer x))))

(defun play-video-in-other-window (next-video-name-with-path nextp)
  "① switch to the buffer whose name is the current video's name
② kill all the video buffer without current video
③ open the next video background
"
  (if nextp
      (dired-next-line 1)
    (dired-previous-line 1)
    )
  (let ((current-video-name-without-path (file-name-nondirectory (dired-file-name-at-point)))
        (current-video-name-with-path (dired-file-name-at-point))
        (current-dired-buf (current-buffer)))
    
    (when (preview--check-if-playable current-video-name-with-path)
      (other-window 1)
      (eaf-open current-video-name-with-path) ; eaf will auto check if this file is open
      (eaf-proxy-set_preview_time)    
      (other-window 1)
      )

    (preview--kill-all-video-buffer current-video-name-with-path)

    
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

(defun forward-video-in-other-window ()
  "forward video in other window"
  (interactive)
  (other-window 1)
  (eaf-proxy-video_forward)
  (other-window 1)
  )

(defun backward-video-in-other-window ()
  "backward video in other window"
  (interactive)
  (other-window 1)
  (eaf-proxy-video_backward)
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

(defun weiss-dired-video-preview-command-mode-define-keys ()
  (weiss--define-keys
   xah-fly-key-map
   '(
     ;; ("~" . nil)
     ;; (":" . nil)

     ;; ("SPC" . xah-fly-leader-key-map)
     ;; ("DEL" . xah-fly-leader-key-map)

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
     ;; ("5" . revert-buffer)
     ;; ("6" . xah-select-block)
     ;; ("7" . xah-select-line)
     ;; ("8" . xah-extend-selection)
     ;; ("9" . dired-hide-details-mode)
     ;; ("0" . xah-pop-local-mark-ring)

     ("a" . backward-video-in-other-window)
     ;; ("b" . xah-toggle-letter-case)
     ("x" . hydra-dired-quick-sort/body)
     ;; ("C" . dired-do-compress-to)
     ("d" . video-preview-next-file)
     ("e" . video-preview-previous-file)
     ("f" . preview-open-file)
     ("g" . forward-video-in-other-window)
     ;; ("h" . (lambda()(interactive)(find-alternate-file "..")))
     ;; ("i" . dired-omit-mode)
     ;; ("j" . dired-next-line)
     ;; ("k" . dired-previous-line)
     ;; ("l" . dired-find-alternate-file)
     ;; ("l" . eaf-open-this-from-dired)
     ;; ("L" . dired-do-symlink)
     ;; ("m" . dired-mark)
     ;; ("n" . swiper-isearch)
     ;; ("O" . xah-open-in-external-app)
     ;; ("o" . eaf-open-this-from-dired)
     ;; ("p" . peep-dired)
     ("q" . dired-video-preview-mode)
     ("r" . dired-next-line)
     ;; ("R" . dired-rsync)
     ("s" . (lambda()(interactive)(find-alternate-file "..")))
     ;; ("S" . hydra-dired-quick-sort/body)
     ("t" . dired-toggle-marks)
     ("u" . dired-unmark)
     ("U" . dired-unmark-all-marks)
     ("v" . hydra-dired-filter-actress/body)
     ("w" . dired-previous-line)
     ("c" . hydra-dired-filter-tag/body)
     ;; ("y" . dired-copy-filename-as-kill)
     ;; ("z" . dired-atool-do-unpack)
     )))

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




