(use-package dired
  :ensure nil
  :init
  (define-prefix-command 'weiss-dired-xfk-g-map)
  (weiss--define-keys
   weiss-dired-xfk-g-map
   '(
     ("d" . (lambda()(interactive)(find-file "/home/weiss/Downloads")))
     ("v" . (lambda()(interactive)(find-file "/home/weiss/Documents/Vorlesungen")))
     ("m" . (lambda()(interactive)(find-file "/run/media/weiss")))
     ("p" . (lambda()(interactive)(find-file "/run/media/weiss/Seagate_Backup/porn/")))
     ("c" . (lambda()(interactive)(find-file "/home/weiss/.config")))
     ("h" . (lambda()(interactive)(find-file "/home/weiss/")))
     ("t" . (lambda()(interactive)(find-file "/home/weiss/.telega/cache/")))
     ("e" . (lambda()(interactive)(find-file "/home/weiss/.emacs.d")))))
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
       ("RET" . dired-find-file)

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

       ("a" . dired-sort-toggle-or-edit)
       ("A" . hydra-dired-filter-actress/body)
       ;; ("b" . hydra-dired-filter-actress/body)
       ("c" . tda/rsync)
       ("C" . tda/rsync-sudo)
       ("d" . dired-do-delete)
       ;; ("e" . xah-backward-kill-word)
       ;; ("f" . xah-fly-insert-mode-activate)
       ;; ("F" . hydra-dired-filter-actress/body)
       ;; ("g" . revert-buffer)
       ("j" . dired-next-line)
       ("h" . dired-omit-mode)
       ("k" . dired-previous-line)
       ("i" . (lambda()(interactive)(find-alternate-file "..")))
       ("l" . dired-find-alternate-file)
       ;; ("l" . eaf-open-this-from-dired)
       ("L" . dired-do-symlink)
       ("m" . dired-mark)
       ;; ("n" . swiper-isearch)
       ("O" . xah-open-in-external-app)
       ("o" . eaf-open-this-from-dired)
       ("p" . peep-dired)
       ("q" . quit-window)
       ("r" . tda/rsync-delete)
       ("R" . tda/rsync-delete-sudo)
       ;; ("s" . dired-sort-toggle-or-edit)
       ("S" . hydra-dired-quick-sort/body)
       ("t" . dired-toggle-marks)
       ("u" . dired-unmark)
       ("U" . dired-unmark-all-marks)
       ;; ("v" . xah-paste-or-paste-previous)
       ("w" . (lambda()(interactive)(dired-copy-filename-as-kill 0)))
       ("x" . dired-do-flagged-delete)
       ;; ("y" . dired-copy-filename-as-kill)
       ("z" . tda/unzip)
       ("Z" . tda/zip))))
  :config
  (setq
   dired-dwim-target t
   dired-recursive-deletes 'always
   dired-recursive-copies (quote always)
   dired-auto-revert-buffer t
   dired-omit-files (concat dired-omit-files "\\|^\\..*$") ; a "\" for excape ".", another "\" for excape "\"
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

  (use-package dired-avfs)

  (use-package dired-collapse)

  (use-package dired-quick-sort)

  (require 'weiss_dired_filter)
  ;; (use-package dired-rsync)

  ;; Colourful dired
  (use-package diredfl
    ;; :disabled
    :init (diredfl-global-mode 1))

  (defun weiss-show-icons-in-dired ()
    "Don't show icons in some Dir due to low performance"
    (interactive)
    (let ((dired-icons-blacklist '("porn" "/lib/" "/lib64/"))
          r)
      (unless (dolist (x dired-icons-blacklist r)
                (when (string-match x dired-directory) (setq r t)))
        (all-the-icons-dired-mode))
      )
    )

  ;; Shows icons
  (use-package all-the-icons-dired
    ;; :disabled
    :diminish
    :hook (dired-mode . weiss-show-icons-in-dired) 
    ;; :hook (dired-mode . (lambda () (interactive) (message "path: %s" (string-match "x" dired-directory))))
    )

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


  (defun weiss-dired-mode-setup ()
    "to be run as hook for `dired-mode'."
    (dired-hide-details-mode 1)
    (dired-collapse-mode)
    (dired-utils-format-information-line-mode)
    ;; (all-the-icons-dired-mode)
    (dired-omit-mode)
    (setq dired-auto-revert-buffer 't)
    ;; (xah-fly-insert-mode-activate)
    )
  (add-hook 'dired-mode-hook 'weiss-dired-mode-setup)

  )  


(with-eval-after-load "wdired"
  (define-key wdired-mode-map (kbd "C-q") '(lambda()(interactive)(wdired-finish-edit)(dired-revert)(xah-fly-command-mode-activate))))

;; (define-key wdired-mode-map (kbd "C-q") '(lambda()(interactive)(wdired-finish-edit)(add-hook 'dired-after-readin-hook 'all-the-icons-dired--display t t)(all-the-icons-dired--display)(dired-revert)(xah-fly-command-mode-activate)))


(provide 'weiss_dired)
