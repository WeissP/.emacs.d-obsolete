
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

(defun weiss-xfk-j-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-scroll-up-or-next-page))
   (t (call-interactively 'next-line))))

(defun weiss-xfk-k-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-scroll-down-or-previous-page))
   (t (call-interactively 'previous-line))))


(defun weiss-xfk-=-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-enlarge))
   (t (call-interactively 'xah-backward-punct))))


(defun weiss-xfk---key ()
  " '-' key"
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-shrink))
   (t (call-interactively 'xah-backward-punct))))


(defun weiss-xfk-0-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-scale-reset))
   (t (call-interactively 'universal-argument))))


(defun weiss-xfk-1-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'weiss-pdf-view-previous-page-quickly))
   (t (call-interactively 'scroll-down))))


(defun weiss-xfk-2-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'weiss-pdf-view-next-page-quickly))
   (t (call-interactively 'scroll-up))))


(defun weiss-xfk-h-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-fit-height-to-window))
   (t (call-interactively 'backward-char))))


(defun weiss-xfk-p-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-fit-page-to-window))
   (t (call-interactively 'weiss-insert-line))))

(defun weiss-xfk-w-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'pdf-view-fit-width-to-window))
   (t (call-interactively 'xah-shrink-whitespaces))))

(defun weiss-xfk-d-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'weiss-direct-insert-note))
   (t (call-interactively 'xah-delete-backward-char-or-bracket-text))))

(defun weiss-xfk-s-key ()
  (interactive)
  (cond
   ((eq major-mode 'pdf-view-mode) (call-interactively 'weiss-direct-annot-and-insert-note))
   (t (call-interactively 'open-line))))



(defun weiss-xfk-addon-command ()
  (interactive)
  ;; f
  (define-key xah-fly-leader-key-map (kbd "f") 'weiss-switch-buffer-and-refresh-xfk)
  ;; i-keymap
  (define-key xah-fly-c-keymap (kbd "o") 'weiss-counsel-bookmark-and-refresh-xfk)
  (define-key xah-fly-c-keymap (kbd "j") 'counsel-recentf)
  ;; ,-keymap
  (define-key xah-fly-w-keymap (kbd "m") 'weiss-eval-last-sexp)
  ;; e-key map
  (define-prefix-command 'weiss-xfk-leader-e-keymap)
  (define-key xah-fly-leader-key-map (kbd "e") weiss-xfk-leader-e-keymap)
  (define-key weiss-xfk-leader-e-keymap (kbd "c") 'org-capture)
  (define-key weiss-xfk-leader-e-keymap (kbd "o") 'org-noter)
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

     ("'" . xah-cycle-hyphen-underscore-space)
     ("," . weiss-switch-frame-and-refresh-xfk)
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
     ("z" . xah-comment-dwim))))

(defun weiss-pdf-command-mode-define-keys ()
  (weiss--define-keys
   xah-fly-key-map
   '(

     ("~" . nil)
     (":" . nil)

     ("SPC" . xah-fly-leader-key-map)
     ("DEL" . xah-fly-leader-key-map)

     ("'" . xah-cycle-hyphen-underscore-space)
     ("," . weiss-switch-frame-and-refresh-xfk)
     ("-" . pdf-view-shrink)
     ("." . xah-forward-right-bracket)
     (";" . xah-end-of-line-or-block)
     ("/" . xah-goto-matching-bracket)
     ("\\" . nil)
     ("=" . pdf-view-enlarge)
     ("[" . hippie-expand )
     ("]" . nil)
     ("`" . other-frame)

     ("<backtab>" . weiss-indent)
     ("V" . weiss-paste-with-linebreak)

     ;; ("#" . xah-backward-quote)
     ;; ("$" . xah-forward-punct)

     ("1" . weiss-pdf-view-previous-page-quickly)
     ("2" . weiss-pdf-view-next-page-quickly)
     ("3" . delete-other-windows)
     ("4" . split-window-below)
     ("5" . delete-char)
     ("6" . xah-select-block)
     ("7" . xah-select-line)
     ("8" . xah-extend-selection)
     ("9" . xah-select-text-in-quote)
     ("0" . pdf-view-scale-reset)

     ("a" . execute-extended-command)
     ("b" . xah-toggle-letter-case)
     ("c" . xah-copy-line-or-region)
     ("d" . weiss-direct-insert-note)
     ("e" . xah-backward-kill-word)
     ("f" . xah-fly-insert-mode-activate)
     ("g" . xah-delete-current-text-block)
     ("h" . pdf-view-fit-height-to-window)
     ("i" . xah-beginning-of-line-or-block)
     ("j" . pdf-view-scroll-up-or-next-page)
     ("k" . pdf-view-scroll-down-or-previous-page)
     ;; ("l" . xah-fly-insert-mode-activate-space-before)
     ("l" . forward-char)
     ("m" . xah-backward-left-bracket)
     ("n" . isearch-forward)
     ("o" . forward-word)
     ("p" . pdf-view-fit-page-to-window)
     ("q" . xah-reformat-lines)
     ("r" . xah-kill-word)
     ("s" . weiss-direct-annot-and-insert-note)
     ("t" . set-mark-command)
     ("u" . backward-word)
     ("v" . xah-paste-or-paste-previous)
     ("w" . pdf-view-fit-width-to-window)
     ("x" . xah-cut-line-or-region)
     ("y" . undo)
     ("z" . xah-comment-dwim))))

(defun weiss-xfk-command-mode-init ()
  "Set command mode keys.
Version 2017-01-21"
  (interactive)
  ;; (weiss-prog-command-mode-define-keys)
  (cond
   ((eq major-mode 'pdf-view-mode) (weiss-pdf-command-mode-define-keys))
   (t (weiss-prog-command-mode-define-keys))
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

(add-hook 'find-file-hook 'xah-fly-command-mode-activate)
;; (add-hook 'kill-buffer-hook 'xah-fly-command-mode-activate) 
;; (add-hook 'kill-buffer-hook 'test)

(defun test()
  (message "1"))

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

(defun xah-close-current-buffer-and-refresh-xfk ()
  (interactive)
  (xah-close-current-buffer)
  (xah-fly-command-mode-activate)
  )


(defun weiss-xfk-addon-insert ()
  (interactive)
  (define-key xah-fly-key-map (kbd "!") 'nil)
  (define-key xah-fly-key-map (kbd "V") 'nil)
  (define-key xah-fly-key-map (kbd "J") 'nil)  
  (define-key xah-fly-key-map (kbd "K") 'nil)  
  (define-key xah-fly-key-map (kbd "(") 'nil)  
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

