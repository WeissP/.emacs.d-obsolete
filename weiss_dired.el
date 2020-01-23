(use-package dired
  :straight nil
  :init
  
  (define-prefix-command 'weiss-dired-xfk-g-map)
  (weiss--define-keys
   weiss-dired-xfk-g-map
   '(
     ("d" . (lambda()(interactive)(find-file "~/Downloads")))
     ("v" . (lambda()(interactive)(find-file "/home/weiss/Documents/Vorlesungen")))
     ("m" . (lambda()(interactive)(find-file "/run/media/weiss")))
     ("c" . (lambda()(interactive)(find-file "/home/weiss/.config")))
     )
   )  
  (defun weiss-dired-command-mode-define-keys ()
    ;; (define-key xah-fly-key-map (kbd "f") dired-filter-map) 
    (define-key xah-fly-key-map (kbd "g") weiss-dired-xfk-g-map) 

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
       ("5" . revert-buffer)
       ;; ("6" . xah-select-block)
       ;; ("7" . xah-select-line)
       ;; ("8" . xah-extend-selection)
       ("9" . dired-hide-details-mode)
       ;; ("0" . xah-pop-local-mark-ring)

       ;; ("a" . execute-extended-command)
       ;; ("b" . xah-toggle-letter-case)
       ("c" . dired-do-copy)
       ("C" . dired-do-compress-to)
       ("d" . dired-flag-file-deletion)
       ;; ("e" . xah-backward-kill-word)
       ;; ("f" . xah-fly-insert-mode-activate)
       ;; ("g" . revert-buffer)
       ("h" . (lambda()(interactive)(find-alternate-file "..")))
       ("i" . dired-omit-mode)
       ("j" . dired-next-line)
       ("k" . dired-previous-line)
       ("l" . dired-find-alternate-file)
       ("m" . dired-mark)
       ;; ("n" . swiper-isearch)
       ("o" . xah-open-in-external-app)
       ("p" . peep-dired)
       ("q" . quit-window)
       ("r" . dired-do-rename)
       ("R" . dired-rsync)
       ("s" . dired-sort-toggle-or-edit)
       ("S" . hydra-dired-quick-sort/body)
       ("t" . dired-toggle-marks)
       ("u" . dired-unmark)
       ("U" . dired-unmark-all-marks)
       ;; ("v" . xah-paste-or-paste-previous)
       ;; ("w" . xah-shrink-whitespaces)
       ("x" . dired-do-flagged-delete)
       ;; ("y" . dired-copy-filename-as-kill)
       ("z" . dired-atool-do-unpack)
       )))
  :config
  (setq
   dired-dwim-target t
   dired-recursive-deletes 'always 
   dired-recursive-copies (quote always)
   dired-auto-revert-buffer t
   dired-omit-files (concat dired-omit-files "\\|^\\..*$")   ; a "\" for excape ".", another "\" for excape "\"
   ;; dired-omit-files ""
   )
  ;; Dired listing switches
  ;;  -a : Do not ignore entries starting with .
  ;;  -l : Use long listing format.
  ;;  -t : sort by time
  ;;  -G : Do not print group names like 'users'
  ;;  -h : Human-readable sizes like 1K, 234M, ..
  ;;  -v : Do natural sort .. so the file names starting with . will show up first.
  ;;  -F : Classify filenames by appending '*' to executables,
  ;;       '/' to directories, etc.
  ;; --group-directories-first
  (setq dired-listing-switches "-altGh") ; default: "-al"
  

  (use-package dired-hacks-utils)

  (use-package dired-filter)

  (use-package dired-avfs)

  (use-package dired-atool)

  (use-package dired-open
    :disabled)

  (use-package dired-rainbow
    :disabled)

  (use-package dired-narrow
    :disabled)

  (use-package dired-collapse)

  (use-package dired-quick-sort)

  (use-package dired-rsync)

  (use-package ivy-dired-history
    :init
    (add-to-list 'savehist-additional-variables 'ivy-dired-history-variable)
    )

  ;; Colourful dired
  (use-package diredfl
    :init (diredfl-global-mode 1))

  ;; Shows icons
  (use-package all-the-icons-dired
    :diminish
    :hook (dired-mode . all-the-icons-dired-mode)
    :config
    (with-no-warnings
      (defun my-all-the-icons-dired--display ()
        "Display the icons of files in a dired buffer."
        (when dired-subdir-alist
          (let ((inhibit-read-only t))
            (save-excursion
              ;; TRICK: Use TAB to align icons
              (setq-local tab-width 1)
              (goto-char (point-min))
              (while (not (eobp))
                (when (dired-move-to-filename nil)
                  (insert " ")
                  (let ((file (dired-get-filename 'verbatim t)))
                    (unless (member file '("." ".."))
                      (let ((filename (dired-get-filename nil t)))
                        (if (file-directory-p filename)
                            (insert (all-the-icons-icon-for-dir filename nil ""))
                          (insert (all-the-icons-icon-for-file file :v-adjust -0.05))))
                      ;; Align and keep one space for refeshing after some operations
                      (insert "\t "))))
                (forward-line 1))))))
      (advice-add #'all-the-icons-dired--display
                  :override #'my-all-the-icons-dired--display)))

  (use-package peep-dired                 ;preview files
    ;; :disabled                             
    :init
    ;; (setq peep-dired-cleanup-eagerly t)   
    ;; (setq peep-dired-enable-on-directories t)
    (setq peep-dired-cleanup-on-disable t)
    (setq peep-dired-ignored-extensions nil)
    )

  (defun weiss-dired-mode-setup ()
    "to be run as hook for `dired-mode'."
    (dired-hide-details-mode 1)
    (dired-collapse-mode)
    (dired-utils-format-information-line-mode)
    (dired-omit-mode)
    (setq dired-auto-revert-buffer 't)
    ;; (xah-fly-insert-mode-activate)
    )
  (add-hook 'dired-mode-hook 'weiss-dired-mode-setup)

  )

(with-eval-after-load "wdired"
  (define-key wdired-mode-map (kbd "C-q") '(lambda()(interactive)(wdired-finish-edit)(xah-fly-command-mode-activate))))

