;; -*- lexical-binding: t -*-
;; shell or terminal
;; :PROPERTIES:
;; :header-args: :tangle shell-or-terminal/weiss-shell-or-terminal.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*shell or terminal][shell or terminal:1]]
(use-package aweshell
  ;; :disabled                             
  :quelpa (aweshell
           :fetcher github
           :repo "manateelazycat/aweshell"))

(use-package vterm
  :disabled
  :config
  (setq vterm-shell "zsh")
  (add-hook 'vterm-set-title-functions 'vterm--rename-buffer-as-title))

;; (defun vterm--rename-buffer-as-title (title)
;; (rename-buffer (format "vterm @ %s" title) t))

(defun weiss-send-last-command ()
  "DOCSTRING"
  (interactive)
  (eshell-kill-output)
  (eshell-previous-matching-input-from-input 1)
  (eshell-send-input)
  )

(ryo-modal-keys
 (:mode 'eshell-mode)
 ("u" weiss-send-last-command))

(provide 'weiss-shell-or-terminal)
;; shell or terminal:1 ends here

;; after dump

;; [[file:../emacs-config.org::*after dump][after dump:1]]
(use-package emacs-yakuake
  :load-path "/home/weiss/.emacs.d/local-package/dropdown-remote/"
  :ensure nil
  :config
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
;; after dump:1 ends here
