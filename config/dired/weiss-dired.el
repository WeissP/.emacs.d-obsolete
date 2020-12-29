;; -*- lexical-binding: t -*-
;; dired
;; :PROPERTIES:
;; :header-args: :tangle dired/weiss-dired.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*dired][dired:1]]
(use-package dired
  :ensure nil
;; dired:1 ends here

;; hook

;; [[file:../emacs-config.org::*hook][hook:1]]
:hook
(dired-mode . (lambda () (interactive)
                (dired-hide-details-mode 1)
                (dired-collapse-mode)
                (dired-utils-format-information-line-mode)
                ;; (all-the-icons-dired-mode)
                (dired-omit-mode)
                (setq dired-auto-revert-buffer 't)))
;; hook:1 ends here

;; keybinding 

;; [[file:../emacs-config.org::*keybinding][keybinding:1]]
:ryo
(:mode 'dired-mode)
("SPC" (
        ("l" (
              ("r" dired-toggle-read-only
               :first (revert-buffer)
               :then (ryo-modal-restart)  
               )
              ("v" weiss-dired-single-handed-mode)
              )))
 )
("e" ora-ediff-files)
("g" (
      ("d" ignore
       :then ((lambda()(interactive)(find-file "/home/weiss/Downloads")))
       :name "Downloads"
       )
      ("v"  ignore
       :then ((lambda()(interactive)(find-file "/home/weiss/Documents/Vorlesungen")))
       :name "Vorlesungen"
       )
      ("m"  ignore
       :then ((lambda()(interactive)(find-file "/run/media/weiss")))
       :name "usb"
       )
      ("p"  ignore
       :then ((lambda()(interactive)(find-file "/run/media/weiss/Seagate_Backup/porn/")))
       :name "Seagate_Backup"
       )
      ("c"  ignore
       :then ((lambda()(interactive)(find-file "/home/weiss/.config")))
       :name "config"
       )
      ("h"  ignore
       :then ((lambda()(interactive)(find-file "/home/weiss/")))
       :name "home"
       )
      ("t"  ignore
       :then ((lambda()(interactive)(find-file "/home/weiss/.telega/cache/")))
       :name "telega"
       )
      ("s"  ignore
       :then ((lambda()(interactive)(find-file "/ssh:root@95.179.243.76:/usr/config/.aria2c/downloads/")))
       :name "vultr"
       )
      ("k"  ignore
       :then ((lambda()(interactive)(find-file "/docker:14a4442774f8:/home/ubuntu/catkin_ws/src/")))
       :name "catkin_ws"
       )
      ("e"  ignore
       :then ((lambda()(interactive)(find-file "/home/weiss/.emacs.d")))       
       :name ".emacs.d"        
       )))
("RET" dired-find-file)
(","  beginning-of-buffer)
("."  end-of-buffer)
(";"  dired-maybe-insert-subdir)
("5"  revert-buffer)
("8"  dired-hide-details-mode)
("a"  dired-sort-toggle-or-edit)
("A"  hydra-dired-filter-actress/body)
("c"  dired-do-copy)
("C"  weiss-dired-rsync)
("d"  dired-do-delete)
("f"  dired-toggle-read-only :exit t :first '(revert-buffer))
("j"  dired-next-line)
("h"  dired-omit-mode)
("k"  dired-previous-line)
("i"  ignore
 :then '((lambda()(interactive)(find-alternate-file "..")))
 :name "up directory")
("l"  dired-find-alternate-file)
("L"  dired-do-symlink)
("m"  dired-mark)
("o"  xah-open-in-external-app)
("O"  eaf-open-this-from-dired)
("p"  peep-dired)
("q"  quit-window)
("r"  dired-do-rename)
("S"  hydra-dired-quick-sort/body)
("t"  dired-toggle-marks)
("u"  dired-unmark)
("U"  dired-unmark-all-marks :then '(revert-buffer))
("v"  weiss-dired-git-clone)
("w"  weiss-dired-copy-file-name)
;; ("w" ignore
;;  :then '((lambda()(interactive)(dired-copy-filename-as-kill 0)))
;;  :name "copy filename with path")
("x"  dired-do-flagged-delete)
("z"  dired-do-compress)
("Z"  dired-do-compress-to)
(:mode 'wdired-mode)
("C-q" weiss-exit-wdired-mode)

(with-eval-after-load 'wdired
  (define-key wdired-mode-map (kbd "C-q") 'weiss-exit-wdired-mode))
;; keybinding:1 ends here

;; config

;; [[file:../emacs-config.org::*config][config:1]]
:config
;; config:1 ends here

;; functions

;; [[file:../emacs-config.org::*functions][functions:1]]
(defun ora-ediff-files ()
  (interactive)
  (let ((files (dired-get-marked-files))
        (wnd (current-window-configuration)))
    (if (<= (length files) 2)
        (let ((file1 (car files))
              (file2 (if (cdr files)
                         (cadr files)
                       (read-file-name
                        "file: "
                        (dired-dwim-target-directory)))))
          (if (file-newer-than-file-p file1 file2)
              (ediff-files file2 file1)
            (ediff-files file1 file2))
          (add-hook 'ediff-after-quit-hook-internal
                    (lambda ()
                      (setq ediff-after-quit-hook-internal nil)
                      (set-window-configuration wnd))))
      (error "no more than 2 files should be marked"))))

(defun weiss-dired-copy-file-name ()
  "copy file name or copy path with prefix-arg"
  (interactive)
  (if current-prefix-arg
      (let ((current-prefix-arg 0))
        (dired-copy-filename-as-kill)
        )
    (let ((current-prefix-arg nil))
      (dired-copy-filename-as-kill)      
      )
    ))

(defun weiss-exit-wdired-mode ()
  "exit wdired mode"
  (interactive)
  (wdired-finish-edit)
  (dired-revert)
  (ryo-modal-restart))

(defun weiss-dired-delete-files-force ()
  "delete files without ask"
  (interactive)
  (dired-delete-file weiss-dired-marked-files)
  ;; (dired-delete-file "/home/weiss/Downloads/mp1.pdf")
  ;; (message "%s" "123")
  )
;; (dired-get-marked-files)

(defun weiss-revert-all-dired-buffer ()
  "DOCSTRING"
  (interactive)
  (dolist (x (buffer-list) nil)
    (when (string-match "dired" (format "%s" (with-current-buffer x major-mode)))
      (with-current-buffer x
        (revert-buffer))
      ))
  )

(defun weiss-show-icons-in-dired ()
  "Don't show icons in some Dir due to low performance"
  (interactive)
  (let ((dired-icons-blacklist '("ssh:" "porn" "/lib/" "/lib64/" "/etc/" "/usr/share/texmf-dist/tex/latex/" "/usr/"))
        r)
    (unless (dolist (x dired-icons-blacklist r)
              (when (string-match x dired-directory) (setq r t)))
      (all-the-icons-dired-mode))
    )
  )

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
      )))
;; functions:1 ends here

;; variable

;; [[file:../emacs-config.org::*variable][variable:1]]
(setq
 dired-dwim-target t
 dired-recursive-deletes 'always
 dired-recursive-copies (quote always)
 dired-auto-revert-buffer t
 dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\'|\\|.*aria2$\\|^.*frag-master.*$\\|^\\."
 dired-listing-switches "-altGh"
 )
;; variable:1 ends here

;; ui

;; [[file:../emacs-config.org::*ui][ui:1]]
;; Colourful dired
(use-package diredfl
  ;; :disabled
  :init (diredfl-global-mode 1))

;; Shows icons
(use-package all-the-icons-dired
  ;; :disabled
  :diminish
  :hook (dired-mode . weiss-show-icons-in-dired) 
  :config
  (with-no-warnings
    (advice-add #'dired-do-create-files :around #'all-the-icons-dired--refresh-advice)
    (advice-add #'dired-create-directory :around #'all-the-icons-dired--refresh-advice)
    (advice-add #'wdired-abort-changes :around #'all-the-icons-dired--refresh-advice))

  (with-no-warnings
    (defun my-all-the-icons-dired--refresh ()
      "Display the icons of files in a dired buffer."
      (all-the-icons-dired--remove-all-overlays)
      ;; NOTE: don't display icons it too many items
      (if (<= (count-lines (point-min) (point-max)) 1000)
          (save-excursion
            (goto-char (point-min))
            (while (not (eobp))
              (when (dired-move-to-filename nil)
                (let ((file (file-local-name (dired-get-filename 'relative 'noerror))))
                  (when file
                    (let ((icon (if (file-directory-p file)
                                    (all-the-icons-icon-for-dir file
                                                                :face 'all-the-icons-dired-dir-face
                                                                :height 0.9
                                                                :v-adjust all-the-icons-dired-v-adjust)
                                  (all-the-icons-icon-for-file file :height 0.9 :v-adjust all-the-icons-dired-v-adjust))))
                      (if (member file '("." ".."))
                          (all-the-icons-dired--add-overlay (point) "  \t")
                        (all-the-icons-dired--add-overlay (point) (concat icon "\t")))))))
              (forward-line 1)))
        (message "Not display icons because of too many items.")))
    (advice-add #'all-the-icons-dired--refresh :override #'my-all-the-icons-dired--refresh))
;; :hook (dired-mode . (lambda () (interactive) (message "path: %s" (string-match "x" dired-directory))))
)
;; ui:1 ends here

;; misc packages

;; [[file:../emacs-config.org::*misc packages][misc packages:1]]
(use-package dired-hacks-utils)

(use-package dired-avfs)

(use-package dired-collapse)

(use-package dired-quick-sort)

(use-package peep-dired ;preview files
  ;; :diminish "2"
  ;; :disabled
  :init
  ;; (setq peep-dired-cleanup-eagerly t)
  ;; (setq peep-dired-enable-on-directories t)
  (setq
   peep-dired-cleanup-on-disable t
   peep-dired-ignored-extensions nil
   peep-dired-max-size (* 10 1024 1024)))

(require 'weiss-dired-filter)
(require 'weiss-dired-single-handed-mode)
;; misc packages:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
)
(provide 'weiss-dired)
;; end:1 ends here
