(require 'org-roam)

(setq weiss-config-manager-after-dump-tags
  '("font-lock-face" "recentf" "emacs-yakuake" "tramp" "keybindings" "doom-modeline" "all-the-icons" "frame" "font"))

(defun weiss-process-git-link (link)
  "process git link as the format of quelpa"
  (interactive)
  (if (string-prefix-p "git@github.com" link)
      (substring link 15 -4)
    link
    )
  )

(defun weiss-process-provide (filename &optional package)
  "DOCSTRING"
  (interactive)
  (let ((name (file-name-nondirectory (file-name-sans-extension filename)))
        )
    (if package
        (replace-regexp-in-string "ƦEmacs_Config_" "weiss_" name t)
      (replace-regexp-in-string "ƦEmacs_Config>" "weiss_" name t)        
      )
    )
  )

(defun weiss-config-manager-process-tag (word)
  "add percentage around `word'"
  (interactive)
  `(,(format "%%=%s=%%" word)))

(defun weiss-config-manager-add-tag-conditions (tag)
  "DOCSTRING"
  (interactive)
  `(like tags:tags ',(weiss-config-manager-process-tag tag))
  )
;; (weiss-config-manager-get-after-dump-config '("ui"))
(defun weiss-config-manager-get-after-dump-config (tags)
  "DOCSTRING"
  (interactive)
  (org-roam-db-query
  ;; (emacsql-flatten-sql   
   (vconcat
    [:select :distinct tags:file :from tags]
    `[:where
      ,(append
        '(and)
        (mapcar 'weiss-config-manager-add-tag-conditions (append tags '("emacs" "dotfiles")))
        `(,(append
            '(or)
            (mapcar 'weiss-config-manager-add-tag-conditions weiss-config-manager-after-dump-tags)
            ))
        `((not ,(weiss-config-manager-add-tag-conditions "dumped")))
        `((not ,(weiss-config-manager-add-tag-conditions "keybindings")))
        )
      ]     
    )))

(defun weiss-config-manager-get-dumped-config (tags)
  "DOCSTRING"
  (interactive)
  (let ((l (org-roam-db-query
            (vconcat
             [:select :distinct [tags:file tags:tags] :from tags]             
             `[:where ,(append
                        '(and)
                        (mapcar 'weiss-config-manager-add-tag-conditions tags)
                        )]
             )))
        res after-dump)
    (dolist (x l res) 
      (setq after-dump t)
      (when (or
             (member "=dumped=" (nth 1 x))
             (dolist (tag (nth 1 x) after-dump) 
               (when (member (substring tag 1 -1) weiss-config-manager-after-dump-tags)
                 (setq after-dump nil)))
             )
        (push `(,(car x)) res)
        )
      )
    ))

(defun weiss-load-module (package-list after-dump &optional log-file)
  "DOCSTRING"
  (interactive)
  (dolist (package package-list)
    (if (listp package)
        (let ((name (car package))
              (plist (cdr package))
              (condition (plist-get (cdr package) :when))
              )
          (when (and (not (plist-get plist :disabled))
                     (or (not condition)
                         (if (listp (eval condition))
                             (eval (eval condition))
                           (eval condition)                           
                           )
                         )
                     )
            (weiss-load-module (plist-get plist :first) after-dump log-file)

            ;; (message "load: %s" name)
            (weiss-load-config (symbol-name name) after-dump log-file)

            (cond
             ((plist-get plist :local)
              (ignore)
              )
             ((plist-get plist :skip-install)
              (ignore)
              )
             ((plist-member plist :github)
              (quelpa `(,name :fetcher github-ssh
                              :repo ,(weiss-process-git-link (plist-get plist :github))))
              )
             ((plist-member plist :file)
              (quelpa `(,name :fetcher file
                              :path ,(plist-get plist :file)))
              )
             ((plist-member plist :quelpa)
              (quelpa (plist-get plist :quelpa))
              )
             (t (quelpa name))
             )

            (when (and (not (plist-get plist :skip-install))
                       (eq after-dump (plist-get plist :after-dump))) 
              (if log-file
                  (weiss-insert-require log-file (symbol-name name))
                (require name)
                )
              )

            (weiss-load-module (plist-get plist :then) after-dump log-file)
            ))        
      ;; (message "load: %s" (symbol-name package))
      (weiss-load-config (symbol-name package) after-dump log-file)
      (quelpa package)
      (if log-file
          (weiss-insert-require log-file (symbol-name package))
        (require package)
        )
      )
    )
  )
(defun weiss-insert-require (log-file name)
  "DOCSTRING"
  (interactive)
  (find-file log-file)                    
  (goto-char (point-max))
  (insert (format "\n(require '%s)" name))
  )

(defun weiss-load-keybindings ()
  "DOCSTRING"
  (interactive)
  (let ((query `[:select :distinct tags:file
                         :from tags
                         :where (like tags:tags '("%=emacs=%=dotfiles=%"))
                         :and (like tags:tags ',(weiss-config-manager-process-tag "keybindings"))
                         ]))
    (dolist (x (org-roam-db-query query))
      ;; (message "load kb: %s" (weiss-process-provide (car x)))
      (require (intern (weiss-process-provide (car x))))
      )
    ))

(defun weiss-roam-search-emacs-config (tags after-dump)
  "DOCSTRING"
  (interactive)
  (if after-dump
      (weiss-config-manager-get-after-dump-config tags)      
    (weiss-config-manager-get-dumped-config tags)
    )
  )

;; (weiss-require-config-by-tags `("server" "first-order") "server" nil "/home/weiss/.emacs.d/dumped-packages.el")
(defun weiss-require-config-by-tags (tags package after-dump  &optional log-file)
  "DOCSTRING"
  (interactive)
  (when-let ((files (weiss-roam-search-emacs-config tags after-dump))
             )
    ;; (message "files: %s" (reverse files))
    (dolist (file-list files)
      (let* ((file (car file-list))
             (first-module (nth 1 (split-string
                                   (file-name-nondirectory (file-name-sans-extension file)) "<")))
             )
        ;; (message "package: %s first-module: %s" package first-module)
        (when (string= first-module package)
          (if log-file
              (weiss-insert-require log-file (weiss-process-provide file))              
            (require (intern (weiss-process-provide file)))
            )
          ;; (message "require: %s" (weiss-process-provide file))
          )
        )
      )
    ))

(defun weiss-load-config (package after-dump &optional log-file)
  "DOCSTRING"
  (interactive)
  (weiss-require-config-by-tags `(,package "first-order") package after-dump log-file)
  (weiss-require-config-by-tags `(,package "second-order") package after-dump log-file)
  (weiss-require-config-by-tags `(,package "third-order") package after-dump log-file)
  (weiss-require-config-by-tags `(,package) package after-dump log-file)
  )

(defun weiss-insert-require-to-log-file ()
  "DOCSTRING"
  (interactive)
  (let ((file "/home/weiss/.emacs.d/dumped-packages.el")
        )
    (find-file file)
    (erase-buffer)
    (weiss-load-module weiss/modules nil file)    
    )
  )

(provide 'weiss-config-manager)

