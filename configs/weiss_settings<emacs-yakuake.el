(with-eval-after-load 'emacs-yakuake
  (defun weiss-dired-rsync ()
    "DOCSTRING"
    (interactive)
    (let ((marked-files (dired-get-marked-files))
          (target-path (or (car (dired-dwim-target-next)) "/home/weiss/Downloads/")))
      (cond
       ((string-prefix-p "/ssh:" (car marked-files))
        (dolist (x marked-files)
          (let ((file-paths (split-string x ":")))            
            (yakuake-run-command-in-session
             (yakuake-add-session)
             (format "rsync -PaAXv -e ssh \"%s:%s\" %s"
                     (nth 1 file-paths)
                     (nth 2 file-paths)
                     target-path)))          
          )
        )
       ((string-prefix-p "/docker:" (car marked-files))
        (dolist (x marked-files)
          (let ((file-paths (split-string x ":")))            
            (yakuake-run-command-in-session
             (yakuake-add-session)
             (format "docker cp \"%s:%s\" %s"
                     (nth 1 file-paths)
                     (nth 2 file-paths)
                     target-path)))          
          )
        )

       ((string-prefix-p "/docker:" target-path)
        (let* ((parse-path (split-string target-path ":"))
               (docker-path (format "%s:%s" (nth 1 parse-path) (nth 2 parse-path))))          
          (dolist (x marked-files)
            (yakuake-run-command-in-session (yakuake-add-session) (format "docker cp %s %s" (format "\"%s\"" x) docker-path))          
            ))        
        )
       (t (yakuake-run-command-in-session (yakuake-add-session) (format "rsync -aAXv %s %s" (format "\"%s\"" (mapconcat 'identity marked-files "\" \"")) target-path)))
       )      
      )
    (yakuake-toggle-window)        
    )

  (defun weiss-dired-git-clone ()
    "DOCSTRING"
    (interactive)
    (let* ((session (yakuake-add-session))
           (git-path (current-kill 0 t))
           (command (format "cd \"%s\" & git clone %s" (file-truename default-directory) git-path)))
      (if (string-prefix-p  "git@" git-path)
          (yakuake-run-command-in-session session command)
        (message "check your clipboard!" ))      
      ))
  )

(provide 'weiss_settings<emacs-yakuake)
