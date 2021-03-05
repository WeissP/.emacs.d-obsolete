(defun xah-make-backup ()
  "Make a backup copy of current file or dired marked files.
If in dired, backup current file or marked files.
The backup file name is in this format
 x.html~2018-05-15_133429~
 The last part is hour, minutes, seconds.
in the same dir. If such a file already exist, it's overwritten.
If the current buffer is not associated with a file, nothing's done.

URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2018-06-06"
  (interactive)
  (let (($fname (buffer-file-name))
        ($date-time-format "%Y-%m-%d_%H%M%S"))
    (if $fname
        (let (($backup-name
               (concat $fname "~" (format-time-string $date-time-format) "~")))
          (copy-file $fname $backup-name t)
          (message (concat "Backup saved at: " $backup-name)))
      (if (eq major-mode 'dired-mode)
          (progn
            (mapc (lambda ($x)
                    (let (($backup-name
                           (concat $x "~" (format-time-string $date-time-format) "~")))
                      (copy-file $x $backup-name t)))
                  (dired-get-marked-files))
            (revert-buffer))
        (user-error "buffer not file nor dired")))))

(defun weiss-kill-append ()
  "append region to kill-ring"
  (interactive)
  (when (use-region-p)
    (let ((rbeg (region-beginning))
          (rend (region-end))
          )
      (kill-append (buffer-substring-no-properties rbeg rend) nil)
      )))

(defun weiss-exchange-region-kill-ring-car ()
  "insert pop current kill-ring and kill region"
  (interactive)
  (when (use-region-p)
    (when-let ((rbeg (region-beginning))
               (rend (region-end))
               (rep (pop kill-ring))
               )
      (push (delete-and-extract-region rbeg rend) kill-ring)
      (insert rep)
      )
    )
  )

(defun xah-make-backup-and-save ()
  "Backup of current file and save, or backup dired marked files.
For detail, see `xah-make-backup'.
If the current buffer is not associated with a file nor dired, nothing's done.
URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2015-10-14"
  (interactive)
  (if (buffer-file-name)
      (progn
        (xah-make-backup)
        (when (buffer-modified-p)
          (save-buffer)))
    (progn
      (xah-make-backup))))

(defun xah-clear-register-1 ()
  "Clear register 1.
  See also: `xah-paste-from-register-1', `copy-to-register'.

  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2015-12-08"
  (interactive)
  (progn
    (copy-to-register ?1 (point-min) (point-min))
    (message "Cleared register 1.")))

(defun xah-copy-to-register-1 ()
  "Copy current line or text selection to register 1.
  See also: `xah-paste-from-register-1', `copy-to-register'.

  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2017-01-23"
  (interactive)
  (let ($p1 $p2)
    (if (region-active-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (setq $p1 (line-beginning-position) $p2 (line-end-position)))
    (copy-to-register ?1 $p1 $p2)
    (message "Copied to register 1: 「%s」." (buffer-substring-no-properties $p1 $p2))))

(defun xah-append-to-register-1 ()
  "Append current line or text selection to register 1.
  When no selection, append current line, with newline char.
  See also: `xah-paste-from-register-1', `copy-to-register'.

  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2015-12-08"
  (interactive)
  (let ($p1 $p2)
    (if (region-active-p)
        (setq $p1 (region-beginning) $p2 (region-end))
      (setq $p1 (line-beginning-position) $p2 (line-end-position)))
    (append-to-register ?1 $p1 $p2)
    (with-temp-buffer (insert "\n")
                      (append-to-register ?1 (point-min) (point-max)))
    (message "Appended to register 1: 「%s」." (buffer-substring-no-properties $p1 $p2))))

(defun xah-paste-from-register-1 ()
  "Paste text from register 1.
  See also: `xah-copy-to-register-1', `insert-register'.
  URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
  Version 2015-12-08"
  (interactive)
  (when (use-region-p)
    (delete-region (region-beginning) (region-end)))
  (insert-register ?1 t))


(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
            When called repeatedly, append copy subsequent lines.
            When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

            URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
            Version 2019-10-30"
  (interactive)
  (let ((inhibit-field-text-motion nil))
    (if current-prefix-arg
        (progn
          (let (
                (current-point (point))
                (line (if weiss-select-mode
                          (concat (buffer-substring-no-properties (region-beginning) (region-end)) "\n")  
                        (buffer-substring-no-properties (line-beginning-position)(line-beginning-position 2))))
                (times  current-prefix-arg))
            (when weiss-select-mode
              (goto-char (region-end))
              (forward-line)
              (beginning-of-line)
              (open-line 1))
            (if (eq times 1)
                (setq times 4)
              (ignore-errors (when (member 4 times) (setq times 1)))
              )
            ;; (message "%s" times)
            (beginning-of-line)
            ;; (open-line 1)
            (dotimes (i times)
              ;; (next-line)
              (insert line)
              )
            (indent-region current-point (point))
            )          
          )
      (if (use-region-p)
          (progn
            (copy-region-as-kill (region-beginning) (region-end)))
        (if (eq last-command this-command)
            (if (eobp)
                (progn )
              (progn
                (kill-append "\n" nil)
                (kill-append
                 (buffer-substring-no-properties (line-beginning-position) (line-end-position))
                 nil)
                (progn
                  (end-of-line)
                  (forward-char))))
          (if (eobp)
              (if (eq (char-before) 10 )
                  (progn )
                (progn
                  (copy-region-as-kill (line-beginning-position) (line-end-position))
                  (end-of-line)))
            (progn
              (copy-region-as-kill (line-beginning-position) (line-end-position))
              (end-of-line)
              (forward-char))))))))

(defun xah-copy-file-path (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
    Result is full path.
    If `universal-argument' is called first, copy only the dir path.

    If in dired, copy the file/dir cursor is on, or marked files.

    If a buffer is not file and not dired, copy value of `default-directory' (which is usually the “current” dir when that buffer was created)

    URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
    Version 2018-06-18"
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (buffer-file-name)
             (expand-file-name default-directory)))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "Directory copied: %s" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: %s" $fpath)
         $fpath )))))

(defun weiss-save-current-content ()
  "save current content in temp buffer"
  (interactive)
  (let ((current-buffer-content (buffer-string))
        (current-buffer-name (buffer-name))
        )
    (setq newBuf (generate-new-buffer (format "backup_%s" current-buffer-name)))
    (set-buffer newBuf)
    (insert current-buffer-content)
    (when (eq major-mode 'help-mode) (quit-window))
    ))

(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
    New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.

    It returns the buffer (for elisp programing).

    URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
    Version 2017-11-01"
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf
    ))

(defun xah-open-in-external-app (&optional @fname)
  "Open the current file or dired marked files in external app.
    The app is chosen from your OS's preference.

    When called in emacs lisp, if @fname is given, open that.

    URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
    Version 2019-11-04"
  (interactive)
  (unless (eq major-mode 'dired-mode)
    (save-buffer))  
  (let* (
         ($file-list
          (if @fname
              (progn (list @fname))
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list (buffer-file-name)))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (w32-shell-execute "open" $fpath)) $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))  $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" $fpath))) $file-list))))))

(defun xah-open-file-at-cursor ()
  "Open the file path under cursor.
    If there is text selection, uses the text selection for path.
    If the path starts with “http://”, open the URL in browser.
    Input path can be {relative, full path, URL}.
    Path may have a trailing “:‹n›” that indicates line number, or “:‹n›:‹m›” with line and column number. If so, jump to that line number.
    If path does not have a file extension, automatically try with “.el” for elisp files.
    This command is similar to `find-file-at-point' but without prompting for confirmation.

    URL `http://ergoemacs.org/emacs/emacs_open_file_path_fast.html'
    Version 2019-07-16"
  (interactive)
  (let* (
         ($inputStr
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (let ($p0 $p1 $p2
                      ;; chars that are likely to be delimiters of file path or url, e.g. whitespace, comma. The colon is a problem. cuz it's in url, but not in file name. Don't want to use just space as delimiter because path or url are often in brackets or quotes as in markdown or html
                      ($pathStops "^  \t\n\"`'‘’“”|[]{}「」<>〔〕〈〉《》【】〖〗«»‹›❮❯❬❭〘〙·。\\"))
              (setq $p0 (point))
              (skip-chars-backward $pathStops)
              (setq $p1 (point))
              (goto-char $p0)
              (skip-chars-forward $pathStops)
              (setq $p2 (point))
              (goto-char $p0)
              (buffer-substring-no-properties $p1 $p2))))
         ($path
          (replace-regexp-in-string
           "^file:///" "/"
           (replace-regexp-in-string
            ":\\'" "" $inputStr))))
    (if (string-match-p "\\`https?://" $path)
        (if (fboundp 'xahsite-url-to-filepath)
            (let (($x (xahsite-url-to-filepath $path)))
              (if (string-match "^http" $x )
                  (browse-url $x)
                (find-file $x)))
          (progn (browse-url $path)))
      (progn ; not starting “http://”
        (if (string-match "#" $path )
            (let (
                  ( $fpath (substring $path 0 (match-beginning 0)))
                  ( $fractPart (substring $path (match-beginning 0))))
              (if (file-exists-p $fpath)
                  (progn
                    (find-file $fpath)
                    (goto-char 1)
                    (search-forward $fractPart ))
                (when (y-or-n-p (format "file no exist: 「%s」. Create?" $fpath))
                  (find-file $fpath))))
          (if (string-match "^\\`\\(.+?\\):\\([0-9]+\\)\\(:[0-9]+\\)?\\'" $path)
              (let (
                    ($fpath (match-string 1 $path))
                    ($line-num (string-to-number (match-string 2 $path))))
                (if (file-exists-p $fpath)
                    (progn
                      (find-file $fpath)
                      (goto-char 1)
                      (forward-line (1- $line-num)))
                  (when (y-or-n-p (format "file no exist: 「%s」. Create?" $fpath))
                    (find-file $fpath))))
            (if (file-exists-p $path)
                (progn ; open f.ts instead of f.js
                  (let (($ext (file-name-extension $path))
                        ($fnamecore (file-name-sans-extension $path)))
                    (if (and (string-equal $ext "js")
                             (file-exists-p (concat $fnamecore ".ts")))
                        (find-file (concat $fnamecore ".ts"))
                      (find-file $path))))
              (if (file-exists-p (concat $path ".el"))
                  (find-file (concat $path ".el"))
                (when (y-or-n-p (format "file no exist: 「%s」. Create?" $path))
                  (find-file $path ))))))))))

(provide 'weiss_save-open-new-copy<ks)
