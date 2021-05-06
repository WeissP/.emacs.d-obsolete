(with-eval-after-load 'dired
  (defun weiss-dired-unzip-with-password ()
    "DOCSTRING"
    (interactive)
    (let ((file (car (dired-get-marked-files nil nil nil nil t)))
          (pw (read-string "Password: " (substring-no-properties (car kill-ring))))
          )
      (dired-shell-command
       (format "unzip -P %s %s" pw file))
      (revert-buffer)
      ))
  
  (defun weiss-dired-do-compress-to-zip (&optional file)
    "compress single `file' to zip, if `file' is nil, then using dired-get-marked-files"
    (interactive)
    (let* ((in-files (or (list file) (dired-get-marked-files nil nil nil nil t)))
           (out-file (if (= (length in-files) 1)
                         (format "%s.zip" (file-name-sans-extension (car in-files)))
                       (concat (expand-file-name (read-string "zip name: ")) ".zip")))
           (rule (assoc "\\.zip\\'" dired-compress-files-alist)))
      (cond ((not rule)
             (error
              "No compression rule found for %s, see `dired-compress-files-alist'"
              out-file))
            ((and (file-exists-p out-file)
                  (not (y-or-n-p
                        (format "%s exists, overwrite?"
                                (abbreviate-file-name out-file)))))
             (message "Compression aborted"))
            (t
             (when (zerop
                    (dired-shell-command
                     (format-spec (cdr rule)
                                  `((?o . ,(shell-quote-argument out-file))
                                    (?i . ,(mapconcat
                                            (lambda (in-file)
                                              (shell-quote-argument
                                               (file-name-nondirectory in-file)))
                                            in-files " "))))))
               (message (ngettext "Compressed %d file to %s"
			                      "Compressed %d files to %s"
			                      (length in-files))
                        (length in-files)
                        (file-name-nondirectory out-file))
               out-file)))
      )
    )

  (defun dired-compress-file (file)
    "weiss: compress file to zip instead of tar.gz
Compress or uncompress FILE.
Return the name of the compressed or uncompressed file.
Return nil if no change in files."
    (let ((handler (find-file-name-handler file 'dired-compress-file))
          suffix newname
          (suffixes dired-compress-file-suffixes)
          command)
      ;; See if any suffix rule matches this file name.
      (while suffixes
        (let (case-fold-search)
          (if (string-match (car (car suffixes)) file)
              (setq suffix (car suffixes) suffixes nil))
          (setq suffixes (cdr suffixes))))
      ;; If so, compute desired new name.
      (if suffix
          (setq newname (concat (substring file 0 (match-beginning 0))
                                (nth 1 suffix))))
      (cond (handler
             (funcall handler 'dired-compress-file file))
            ((file-symlink-p file)
             nil)
            ((and suffix (setq command (nth 2 suffix)))
             (if (string-match "%[io]" command)
                 (prog1 (setq newname (file-name-as-directory newname))
                   (dired-shell-command
                    (replace-regexp-in-string
                     "%o" (shell-quote-argument newname)
                     (replace-regexp-in-string
                      "%i" (shell-quote-argument file)
                      command
                      nil t)
                     nil t)))
               ;; We found an uncompression rule.
               (let ((match (string-match " " command))
                     (msg (concat "Uncompressing " file)))
                 (unless (if match
                             (dired-check-process msg
                                                  (substring command 0 match)
                                                  (substring command (1+ match))
                                                  file)
                           (dired-check-process msg
                                                command
                                                file))
                   newname))))
            (t
             ;; We don't recognize the file as compressed, so compress it.
             ;; Try gzip; if we don't have that, use compress.
             (weiss-dired-do-compress-to-zip file)
             ))))

  (with-eval-after-load 'dired-aux
    (add-to-list 'dired-compress-file-suffixes '("\\.rar\\'" "" "unrar e %i"))
    )
  )

(provide 'weiss_compress<dired)
