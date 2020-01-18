
;;; ~/Documents/pi/+keybinding.el -*- lexical-binding: t; -*-

(use-package which-key
  :hook (after-init . which-key-mode)
  )

(use-package xah-fly-keys
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1)
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  )

(use-package key-chord
  :config
  (key-chord-define-global "jk" 'xah-fly-command-mode-activate)
  (key-chord-mode 1)
  )

(defun weiss-xfk-ret-key ()
  (interactive)
  (cond
   ((eq major-mode 'org-mode) (call-interactively 'doom-org-dwim-at-point))
   (t nil)))


(defun weiss-xfk-addon-command ()
  (interactive)
  (setq xfk-command-flag "t")
  ;; f
  (define-key xah-fly-leader-key-map (kbd "f") 'ivy-switch-buffer)
  ;; l-keymap
  (define-key xah-fly-n-keymap (kbd "r") '(lambda()(interactive)(dired-toggle-read-only)(xah-fly-command-mode-activate)))    
  (define-key xah-fly-n-keymap (kbd "m") 'dired-collapse-mode)
  ;; i-keymap
  (define-key xah-fly-c-keymap (kbd "j") 'counsel-recentf)
  (define-key xah-fly-c-keymap (kbd "d") 'weiss-insert-date)  
  ;; ,-keymap
  (define-key xah-fly-w-keymap (kbd "m") 'weiss-eval-last-sexp)
  ;; l-keymap
  (define-key xah-fly-n-keymap (kbd "t") 'weiss-org-latex-preview-all)  
  ;; e-keymap
  (define-prefix-command 'weiss-xfk-leader-e-keymap)
  (define-key xah-fly-leader-key-map (kbd "e") weiss-xfk-leader-e-keymap)
  (weiss--define-keys
   weiss-xfk-leader-e-keymap
   '(
     ("a" . weiss-org-screenshot)
     ("c" . org-capture)
     ("o" . org-noter)
     ("s" . org-noter-sync-current-note)
     )
   )
  ;; d-keymap
  (define-prefix-command 'weiss-xfk-leader-d-keymap)
  (define-key xah-fly-leader-key-map (kbd "d") weiss-xfk-leader-d-keymap)
  (weiss--define-keys
   weiss-xfk-leader-d-keymap
   '(
     ("m" . magit-status)
     ("b" . org-babel-tangle)
     ("c" . open-calendar)
     ("d" . weiss-custom-daily-agenda)
     ("r" . weiss-switch-and-Bookmarks-search)
     ("v" . vterm-other-window)
     )
   )
  )

(add-hook 'xah-fly-command-mode-activate-hook 'weiss-xfk-addon-command)

(defun weiss--define-keys (@keymap-name @key-cmd-alist)
  "Map `define-key' over a alist @key-cmd-alist.
Example usage:
;; (xah-fly--define-keys
;;  (define-prefix-command 'xah-fly-dot-keymap)
;;  '(
;;    (\"h\" . highlight-symbol-at-point)
;;    (\".\" . isearch-forward-symbol-at-point)
;;    (\"1\" . hi-lock-find-patterns)
;;    (\"w\" . isearch-forward-word)))
Version 2019-02-12"
  (interactive)
  (mapc
   (lambda ($pair)
     (define-key @keymap-name (kbd (car $pair)) (cdr $pair))) @key-cmd-alist))

(defun weiss-prog-command-mode-define-keys ()
  (weiss--define-keys
   xah-fly-key-map
   '(
     ("~" . nil)
     (":" . nil)

     ("SPC" . xah-fly-leader-key-map)
     ("DEL" . xah-fly-leader-key-map)
     ;;   ("RET" . newline)

     ("'" . xah-cycle-hyphen-underscore-space)
     ("," . xah-next-window-or-frame)
     ("-" . xah-backward-punct)
     ("." . xah-forward-right-bracket)
     (";" . xah-end-of-line-or-block)
     ("/" . xah-goto-matching-bracket)
     ("\\" . nil)
     ;; ("=" . xah-forward-equal-sign)
     ("[" . hippie-expand )
     ("]" . nil)
     ("`" . other-frame)

     ("<backtab>" . weiss-indent)
     ("V" . weiss-paste-with-linebreak)
     ("!" . rotate-text)
     ;; ("#" . xah-backward-quote)
     ;; ("$" . xah-forward-punct)

     ("1" . scroll-down)
     ("2" . scroll-up)
     ("3" . delete-other-windows)
     ("4" . split-window-below)
     ("5" . delete-char)
     ("6" . xah-select-block)
     ("7" . xah-select-line)
     ("8" . xah-extend-selection)
     ("9" . xah-select-text-in-quote)
     ("0" . xah-pop-local-mark-ring)

     ("a" . execute-extended-command)
     ("b" . xah-toggle-letter-case)
     ("c" . xah-copy-line-or-region)
     ("d" . xah-delete-backward-char-or-bracket-text)
     ("e" . xah-backward-kill-word)
     ("f" . xah-fly-insert-mode-activate)
     ("g" . xah-delete-current-text-block)
     ("h" . backward-char)
     ("i" . xah-beginning-of-line-or-block)
     ("j" . next-line)
     ("k" . previous-line)
     ;; ("l" . xah-fly-insert-mode-activate-space-before)
     ("l" . forward-char)
     ("m" . xah-backward-left-bracket)
     ("n" . swiper-isearch)
     ("o" . forward-word)
     ("p" . weiss-insert-line)
     ("q" . xah-reformat-lines)
     ("r" . xah-kill-word)
     ("s" . open-line)
     ("t" . set-mark-command)
     ("u" . backward-word)
     ("v" . xah-paste-or-paste-previous)
     ("w" . xah-shrink-whitespaces)
     ("x" . xah-cut-line-or-region)
     ("y" . undo)
     ("z" . xah-comment-dwim)
     )))



(defun weiss-xfk-command-mode-init ()
  "Set command mode keys.
Version 2017-01-21"
  (interactive)
  (weiss-prog-command-mode-define-keys)
  (cond
   ((eq major-mode 'magit-status-mode) (weiss-magit-command-mode-define-keys))
   ((eq major-mode 'pdf-view-mode) (weiss-pdf-command-mode-define-keys))
   ((eq major-mode 'org-mode) (weiss-org-command-mode-define-keys))
   ((eq major-mode 'org-agenda-mode) (weiss-org-agenda-command-mode-define-keys))
   ((eq major-mode 'dired-mode) (weiss-dired-command-mode-define-keys))
   ((eq major-mode 'wdired-mode) nil)
   ((eq major-mode 'cfw:calendar-mode) (weiss-calendar-command-mode-define-keys))
   ((eq major-mode 'cfw:details-mode) (weiss-calendar-command-mode-define-keys))
   (t nil)
   )
  (define-key xah-fly-key-map (kbd (xah-fly--key-char "a"))
    (cond ((fboundp 'smex) 'smex)
          ((fboundp 'helm-M-x) 'helm-M-x)
          ((fboundp 'counsel-M-x) 'counsel-M-x)
          (t 'execute-extended-command)))

  ;; (when xah-fly-swapped-1-8-and-2-7-p
  ;;     (xah-fly--define-keys
  ;;      xah-fly-key-map
  ;;      '(
  ;;        ("8" . pop-global-mark)
  ;;        ("7" . xah-pop-local-mark-ring)
  ;;        ("2" . xah-select-line)
  ;;        ("1" . xah-extend-selection))))

  (progn
    (setq xah-fly-insert-state-q nil )
    (modify-all-frames-parameters (list (cons 'cursor-type 'box))))

  (setq mode-line-front-space "C")
  (force-mode-line-update)

  ;;
  )


;; (add-hook 'switch-buffer-functions
;; (lambda (prev cur) (message "%S -> %S" prev cur)))

(defun xah-fly-command-mode-activate ()
  "change keybinding according to different modes"
  (interactive)
  (weiss-xfk-command-mode-init)
  (run-hooks 'xah-fly-command-mode-activate-hook))

(defun xah-fly-command-mode-activate-no-hook ()
  "Activate command mode. Does not run `xah-fly-command-mode-activate-hook'
Version 2017-07-07"
  (interactive)
  (weiss-xfk-command-mode-init))

;; (add-hook 'find-file-hook 'xah-fly-command-mode-activate)
;; (add-hook 'kill-buffer-hook 'xah-fly-command-mode-activate) 
;; (add-hook 'kill-buffer-hook 'test)

(defun weiss-switch-buffer-and-refresh-xfk()
  (interactive)
  (ivy-switch-buffer)
  (xah-fly-command-mode-activate)
  )

(defun weiss-switch-frame-and-refresh-xfk()
  (interactive)
  (xah-next-window-or-frame)
  (xah-fly-command-mode-activate)
  )

(defun weiss-counsel-bookmark-and-refresh-xfk ()
  (interactive)
  (xah-open-file-fast)
  ;; (counsel-bookmark)                
  (xah-fly-command-mode-activate)
  )

(defun weiss-xfk-close-current-buffer-and-refresh-xfk ()
  (interactive)
  (xah-close-current-buffer)
  (xah-fly-command-mode-activate)
  )

(defun test-bind (prev cur)
  (define-key xah-fly-key-map (kbd "0") 'nil)  
  )

(defun change-keybinding (prev cur)
  (interactive)
  ;; (message "a")                         
  (if (minibuffer-window-active-p (selected-window))
      nil (xah-fly-command-mode-activate))
  )



(add-hook 'switch-buffer-functions 'change-keybinding) 



(defun weiss-xfk-addon-insert ()
  (interactive)
  (setq xfk-command-flag "nil")
  (define-key xah-fly-key-map (kbd "!") 'nil)
  ;;  (define-key xah-fly-key-map (kbd_"RET") 'newline)
  (define-key xah-fly-key-map (kbd "V") 'nil)
  (define-key xah-fly-key-map (kbd "J") 'nil)  
  (define-key xah-fly-key-map (kbd "K") 'nil)  
  (define-key xah-fly-key-map (kbd "S") 'nil)  
  (define-key xah-fly-key-map (kbd "C") 'nil)  
  (define-key xah-fly-key-map (kbd "U") 'nil)  
  (define-key xah-fly-key-map (kbd "(") 'nil)  
  (define-key xah-fly-key-map (kbd "<backtab>") 'nil)  
  )


(add-hook 'xah-fly-insert-mode-activate-hook 'weiss-xfk-addon-insert)

;; (defun test ()
;;   (sleep-for 5)
;;   (define-key xah-fly-key-map (kbd "J") 'counsel-rg)  
;;   )

;; (add-hook 'switch-buffer-functions 'test) 


;; (add-hook 'hook-test 'weiss-xfk-command-mode-init) 
;; (add-hook 'hook-test 'test)
;; (defun weiss-change-keybindings()
;; (run-hooks 'hook-test)
;; )

(provide 'weiss_keybinding)

;;; weiss_keybinding.el ends here

