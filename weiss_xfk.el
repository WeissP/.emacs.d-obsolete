;;; xah-fly-keys.el --- ergonomic modal keybinding minor mode. -*- coding: utf-8; lexical-binding: t; -*-

;; forked from weiss

;; Copyright © 2013-2019, by Xah Lee

;; Author: Xah Lee ( http://xahlee.info/ )
;; Version: 10.11.20191226154754
;; Created: 10 Sep 2013
;; Package-Requires: ((emacs "24.1"))
;; Keywords: convenience, emulations, vim, ergoemacs
;; License: GPL v3
;; Homepage: http://ergoemacs.org/misc/ergoemacs_vi_mode.html

;; This file is not part of GNU Emacs.

;;; Commentary:

;; xah-fly-keys is a efficient keybinding for emacs. (more efficient than vim)

;; It is a modal mode like vi, but key choices are based on statistics of command call frequency.


;;; Code:
(load (xah-get-fullpath "xfk-functions"))


;; weiss functions
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

(defun weiss-eval-last-sexp()
  (interactive)
  (end-of-line)
  (eval-last-sexp()))


(defun weiss-replace-in-command-mode()
  "Weiss-replace-in-command-mode."
  (interactive)
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-char 1)
    )
  ;; (hydra-insert-in-command-mode/body)
  (insert (read-string "replace with: "))
  )

;; keymaps

;; (defvar xah-fly-swapped-1-8-and-2-7-p nil "If non-nil, it means keys 1 and 8 are swapped, and 2 and 7 are swapped. See: http://xahlee.info/kbd/best_number_key_layout.html")

(defvar xah-fly-key-map (make-sparse-keymap) "Keybinding for `xah-fly-keys' minor mode.")

;; commands related to highlight
(xah-fly--define-keys
 (define-prefix-command 'xah-fly-dot-keymap)
 ;; 2019-02-22 experiment. this is now empty. so you can use this key space for all major mode custom keys or personal keys. These highlight command isn't used much in my experience
 '()
 ;; '(
 ;;   ("." . highlight-symbol-at-point)
 ;;   ("g" . unhighlight-regexp)
 ;;   ("c" . highlight-lines-matching-regexp)
 ;;   ("h" . highlight-regexp)
 ;;   ("t" . highlight-phrase)
 ;;   ("p" . isearch-forward-symbol-at-point)
 ;;   ;; ("c" . isearch-forward-symbol)
 ;;   ;; ("h" . isearch-forward-word)

 ;;   ;;
 ;;   )
 )

(xah-fly--define-keys
 (define-prefix-command 'xah-fly--tab-key-map)
 ;; This keymap I've not used. things are here experimentally.
 ;; The TAB key is not in a very good ergonomic position on average keyboards, so 【leader tab ‹somekey›】 probably should not be used much.
 ;; Currently (2018-03-13), these are commands related to completion or indent, and I basically never use any of these (except sometimes complete-symbol).
 ;; For average user, the way it is now is probably justified, because most emacs users don't use these commands.
 ;; To customize this keymap see http://ergoemacs.org/misc/xah-fly-keys_customization.html.
 '(
   ("TAB" . indent-for-tab-command)

   ("i" . complete-symbol)
   ("g" . indent-rigidly)
   ("r" . indent-region)
   ("s" . indent-sexp)

   ;; temp
   ("1" . abbrev-prefix-mark)
   ("2" . edit-abbrevs)
   ("3" . expand-abbrev)
   ("4" . expand-region-abbrevs)
   ("5" . unexpand-abbrev)
   ("6" . add-global-abbrev)
   ("7" . add-mode-abbrev)
   ("8" . inverse-add-global-abbrev)
   ("9" . inverse-add-mode-abbrev)
   ("0" . expand-jump-to-next-slot)
   ("=" . expand-jump-to-previous-slot)))



(weiss--define-keys
 (define-prefix-command 'xah-fly-i-keymap)
 '(
   ("e" . find-file)
   ("e" . weiss-insert-date)
   ("f" . xah-open-file-at-cursor)
   ("g" . xah-copy-file-path)
   ("j" . recentf-open-files)
   ("n" . new-frame)
   ("o" . bookmark-bmenu-list)
   ("p" . bookmark-set)
   ("w" . xah-open-in-external-app)
   ;; ("l" . xah-new-empty-buffer)
   ;; ("s" . xah-show-in-desktop)
   ;; ("p" . xah-open-last-closed)
   ;; ("r" . xah-open-recently-closed)
   ;; ("t" . xah-list-recently-closed)
   ("o" . xah-open-file-fast)
   ;; (";" . write-file)
   ))

(weiss--define-keys
 (define-prefix-command 'xah-fly-d-keymap)
 '(
   ("4" . weiss-insert-dollar)
   ("m" . magit-status)
   ("t" . youdao-dictionary-search-at-point-posframe)
   ("b" . org-babel-tangle)
   ("c" . open-calendar)
   ("f" . counsel-fzf)
   ("d" . weiss-custom-daily-agenda)
   ("r" . weiss-switch-and-Bookmarks-search)
   ("v" . vterm-other-window)
   )
 )

(weiss--define-keys
 (define-prefix-command 'xah-fly-j-keymap)
 '(
   ("z" . Info-goto-emacs-command-node)
   ("a" . apropos-command)
   ("b" . describe-bindings)
   ("c" . describe-char)
   ("d" . apropos-documentation)
   ("e" . view-echo-area-messages)
   ("f" . describe-face)
   ("g" . info-lookup-symbol)
   ("h" . describe-function)
   ("i" . info)
   ("j" . man)
   ("k" . describe-key)
   ("K" . Info-goto-emacs-key-command-node)
   ("l" . view-lossage)
   ("m" . xah-describe-major-mode)
   ("n" . describe-variable)
   ("o" . describe-language-environment)
   ("p" . finder-by-keyword)
   ("r" . apropos-variable)
   ("s" . describe-syntax)
   ("u" . elisp-index-search)
   ("v" . apropos-value)
   ("z" . describe-coding-system)))

(weiss--define-keys
 (define-prefix-command 'xah-fly-l-keymap)
 '(
   ("SPC" . whitespace-mode)
   ;; RET
   ;; TAB
   ;; DEL
   ("," . abbrev-mode)
   ("." . toggle-frame-fullscreen)
   ("'" . frame-configuration-to-register)
   (";" . window-configuration-to-register)
   ("1" . set-input-method)
   ("2" . global-hl-line-mode)
   ("4" . global-display-line-numbers-mode)
   ("5" . visual-line-mode)
   ("6" . calendar)
   ("7" . calc)
   ;; 8
   ("9" . shell-command)
   ("0" . shell-command-on-region)
   ("a" . text-scale-adjust)
   ("b" . toggle-debug-on-error)
   ("c" . toggle-case-fold-search)
   ("d" . narrow-to-page)
   ("e" . eshell)
   ;; f
   ("g" . xah-toggle-read-novel-mode)
   ("h" . widen)
   ("i" . make-frame-command)
   ("j" . flyspell-buffer)
   ("k" . menu-bar-open)
   ("l" . toggle-word-wrap)
   ("m" . dired-collapse-mode)
   ("n" . narrow-to-region)
   ("o" . variable-pitch-mode)
   ;; ("p" . weiss-org-latex-preview-all)
   ;; p
   ;; q
   ("r" . '(lambda()(interactive)(dired-toggle-read-only)(xah-fly-command-mode-activate)))
   ;; s
   ("t" . narrow-to-defun)
   ("u" . shell)
   ;; v
   ("w" . eww)
   ("x" . save-some-buffers)
   ;; y
   ("z" . abort-recursive-edit)))

(weiss--define-keys
 ;; kinda replacement related
 (define-prefix-command 'xah-fly-o-keymap)
 '(
   ("SPC" . rectangle-mark-mode)
   ("," . apply-macro-to-region-lines)
   ("." . kmacro-start-macro)
   ("3" . number-to-register)
   ("4" . increment-register)
   ("c" . yank-rectangle)
   ("d" . delete-rectangle)
   ("e" . call-last-kbd-macro)
   ("g" . kill-rectangle)
   ("l" . clear-rectangle)
   ("i" . xah-space-to-newline)
   ("n" . rectangle-number-lines)
   ("o" . open-rectangle)
   ("p" . kmacro-end-macro)
   ("r" . replace-rectangle)
   ("u" . xah-quote-lines)
   ("y" . delete-whitespace-rectangle)))

(weiss--define-keys
 (define-prefix-command 'xah-fly-k-keymap)
 '(
   ("SPC" . xah-clean-whitespace)
   ("TAB" . move-to-column)

   ("1" . xah-append-to-register-1)
   ("2" . xah-clear-register-1)

   ("3" . xah-copy-to-register-1)
   ("4" . xah-paste-from-register-1)

   ("8" . xah-clear-register-1)
   ("7" . xah-append-to-register-1)

   ("." . sort-lines)
   ("," . sort-numeric-fields)
   ("'" . reverse-region)
   ;; a
   ;; b
   ("c" . goto-char)
   ("d" . mark-defun)
   ("e" . list-matching-lines)
   ("f" . goto-line )
   ;; g
   ("h" . xah-close-current-buffer )
   ("i" . delete-non-matching-lines)
   ("j" . copy-to-register)
   ("k" . insert-register)
   ("l" . xah-escape-quotes)
   ("m" . xah-make-backup-and-save)
   ("n" . repeat-complex-command)
   ;; o
   ("p" . query-replace-regexp)
   ;; q
   ("r" . copy-rectangle-to-register)
   ;; s
   ("t" . repeat)
   ("u" . delete-matching-lines)
   ;; v
   ("w" . xah-next-window-or-frame)
   ;; x
   ("y" . delete-duplicate-lines)
   ;; z
   ))

(weiss--define-keys
 (define-prefix-command 'xah-fly-e-keymap)
 '(
   ("a" . weiss-org-screenshot)
   ("c" . org-capture)
   ("o" . org-noter)
   ("s" . org-noter-sync-current-note)
   )
 )

(weiss--define-keys
 (define-prefix-command 'xah-fly-comma-keymap)
 '(
   ("DEL" . xah-delete-current-file)
   ("e" . eval-buffer)
   ("d" . eval-defun)
   ("m" . weiss-eval-last-sexp)
   ("r" . eval-expression)
   ("f" . eval-region)
   ("x" . save-buffers-kill-terminal)
   ("w" . delete-frame)
   ("j" . xah-run-current-file)))

;; (weiss--define-keys
;;  (define-prefix-command 'xah-coding-system-keymap)
;;  '(
;;    ("n" . set-file-name-coding-system)
;;    ("s" . set-next-selection-coding-system)
;;    ("c" . universal-coding-system-argument)
;;    ("f" . set-buffer-file-coding-system)
;;    ("k" . set-keyboard-coding-system)
;;    ("l" . set-language-environment)
;;    ("p" . set-buffer-process-coding-system)
;;    ("r" . revert-buffer-with-coding-system)
;;    ("t" . set-terminal-coding-system)
;;    ("x" . set-selection-coding-system)))

(weiss--define-keys
 ;; kinda replacement related
 (define-prefix-command 'xah-fly-w-keymap)
 '(
   ("k" . xref-find-definitions)
   ("l" . xref-pop-marker-stack)))

(weiss--define-keys
 (define-prefix-command 'xah-fly-leader-key-map)
 '(
   ("," . xah-fly-comma-keymap)
   ("-" . xah-show-formfeed-as-line)
   (";" . save-buffer)

   ("3" . delete-window)
   ("4" . split-window-right)
   ("5" . balance-windows)
   ("6" . xah-upcase-sentence)
   ("9" . ispell-word)

   ("DEL" . xah-fly-insert-mode-activate)
   ("RET" . execute-extended-command)
   ("SPC" . xah-fly-insert-mode-activate)
   ("TAB" . xah-fly--tab-key-map)

   ("a" . mark-whole-buffer)
   ("b" . xah-toggle-previous-letter-case)
   ("d" . xah-fly-d-keymap)
   ("c" . xah-copy-all-or-region)
   ("e" . xah-fly-e-keymap)
   ("f" . switch-to-buffer)
   ("g" . kill-line)
   ("h" . beginning-of-buffer)
   ("i" . xah-fly-i-keymap)
   ("j" . xah-fly-j-keymap)
   ("k" . xah-fly-k-keymap)
   ("l" . xah-fly-l-keymap)
   ("m" . dired-jump)
   ("n" . end-of-buffer)
   ("o" . xah-fly-o-keymap)
   ("p" . recenter-top-bottom)
   ("q" . xah-fill-or-unfill)
   ("r" . query-replace)
   ("s" . exchange-point-and-mark)
   ("t" . xah-show-kill-ring)
   ("u" . isearch-forward)
   ("v" . xah-paste-or-paste-previous)
   ("w" . xah-fly-w-keymap)
   ("x" . xah-cut-all-or-region)
   ("y" . xah-search-current-word)
   ;; z                                    
   ))


;;;; misc

;; the following have keys in emacs, but right now i decided not to give them a key, because either they are rarely used (say, less than once a month by 90% of emacs users), or there is a more efficient command/workflow with key in xah-fly-keys

;; C-x C-p	mark-page
;; C-x C-l	downcase-region
;; C-x C-u	upcase-region

;; C-x C-t	transpose-lines
;; C-x C-o	delete-blank-lines

;; C-x C-r	find-file-read-only
;; C-x C-v	find-alternate-file

;; C-x =	what-cursor-position, use describe-char instead
;; C-x <	scroll-left
;; C-x >	scroll-right
;; C-x [	backward-page
;; C-x ]	forward-page
;; C-x ^	enlarge-window

;; C-x {	shrink-window-horizontally
;; C-x }	enlarge-window-horizontally
;; C-x DEL	backward-kill-sentence

;; C-x C-z	suspend-frame

;; C-x k	kill-buffer , use xah-close-current-buffer
;; C-x l	count-lines-page
;; C-x m	compose-mail


;; undecided yet

;; C-x e	kmacro-end-and-call-macro
;; C-x q	kbd-macro-query
;; C-x C-k	kmacro-keymap

;; C-x C-d	list-directory
;; C-x C-n	set-goal-column
;; C-x ESC	Prefix Command
;; C-x $	set-selective-display
;; C-x *	calc-dispatch
;; C-x -	shrink-window-if-larger-than-buffer
;; C-x .	set-fill-prefix

;; C-x 4	ctl-x-4-prefix
;; C-x 5	ctl-x-5-prefix
;; C-x 6	2C-command
;; C-x ;	comment-set-column

;; C-x `	next-error
;; C-x f	set-fill-column
;; C-x i	insert-file
;; C-x n	Prefix Command
;; C-x r	Prefix Command

;; C-x C-k C-a	kmacro-add-counter
;; C-x C-k C-c	kmacro-set-counter
;; C-x C-k C-d	kmacro-delete-ring-head
;; C-x C-k C-e	kmacro-edit-macro-repeat
;; C-x C-k C-f	kmacro-set-format
;; C-x C-k TAB	kmacro-insert-counter
;; C-x C-k C-k	kmacro-end-or-call-macro-repeat
;; C-x C-k C-l	kmacro-call-ring-2nd-repeat
;; C-x C-k RET	kmacro-edit-macro
;; C-x C-k C-n	kmacro-cycle-ring-next
;; C-x C-k C-p	kmacro-cycle-ring-previous
;; C-x C-k C-s	kmacro-start-macro
;; C-x C-k C-t	kmacro-swap-ring
;; C-x C-k C-v	kmacro-view-macro-repeat
;; C-x C-k SPC	kmacro-step-edit-macro
;; C-x C-k b	kmacro-bind-to-key
;; C-x C-k e	edit-kbd-macro
;; C-x C-k l	kmacro-edit-lossage
;; C-x C-k n	kmacro-name-last-macro
;; C-x C-k q	kbd-macro-query
;; C-x C-k r	apply-macro-to-region-lines
;; C-x C-k s	kmacro-start-macro



;; C-x 4 C-f	find-file-other-window
;; C-x 4 C-o	display-buffer
;; C-x 4 .	find-tag-other-window
;; C-x 4 0	kill-buffer-and-window
;; C-x 4 a	add-change-log-entry-other-window
;; C-x 4 b	switch-to-buffer-other-window
;; C-x 4 c	clone-indirect-buffer-other-window
;; C-x 4 d	dired-other-window
;; C-x 4 f	find-file-other-window
;; C-x 4 m	compose-mail-other-window
;; C-x 4 r	find-file-read-only-other-window

;; C-x 6 2	2C-two-columns
;; C-x 6 b	2C-associate-buffer
;; C-x 6 s	2C-split
;; C-x 6 <f2>	2C-two-columns

;; ctl-x-5-map

;; r C-f     find-file-other-frame
;; r C-o     display-buffer-other-frame
;; r .       find-tag-other-frame
;; r 0       delete-frame
;; r 1       delete-other-frames
;; r 2       make-frame-command
;; r b       switch-to-buffer-other-frame
;; r d       dired-other-frame
;; r f       find-file-other-frame
;; r m       compose-mail-other-frame
;; r o       other-frame
;; r r       find-file-read-only-other-frame

;; (weiss--define-keys
;;  (define-prefix-command 'xah-leader-vc-keymap)
;;  '(
;;    ("+" . vc-update)
;;    ("=" . vc-diff)
;;    ("D" . vc-root-diff)
;;    ("L" . vc-print-root-log)
;;    ("a" . vc-update-change-log)
;;    ("b" . vc-switch-backend)
;;    ("c" . vc-rollback)
;;    ("d" . vc-dir)
;;    ("g" . vc-annotate)
;;    ("h" . vc-insert-headers)
;;    ("l" . vc-print-log)
;;    ("m" . vc-merge)
;;    ("r" . vc-retrieve-tag)
;;    ("s" . vc-create-tag)
;;    ("u" . vc-revert)
;;    ("v" . vc-next-action)
;;    ("~" . vc-revision-other-window)))


;; setting keys

(progn
  ;; set control meta, etc keys

  (progn
    (define-key xah-fly-key-map (kbd "<home>") 'xah-fly-command-mode-activate)
    (define-key xah-fly-key-map (kbd "<menu>") 'xah-fly-command-mode-activate)
    (define-key xah-fly-key-map (kbd "<f8>") 'xah-fly-command-mode-activate-no-hook)

    (define-key xah-fly-key-map (kbd "<f9>") xah-fly-leader-key-map)

    (define-key xah-fly-key-map (kbd "<f11>") 'xah-previous-user-buffer)
    (define-key xah-fly-key-map (kbd "<f12>") 'xah-next-user-buffer)
    (define-key xah-fly-key-map (kbd "<C-f11>") 'xah-previous-emacs-buffer)
    (define-key xah-fly-key-map (kbd "<C-f12>") 'xah-next-emacs-buffer))

  (progn
    ;; set arrow keys in isearch. left/right is backward/forward, up/down is history. press Return to exit
    (define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat )
    (define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance )

    (define-key isearch-mode-map (kbd "<left>") 'isearch-repeat-backward)
    (define-key isearch-mode-map (kbd "<right>") 'isearch-repeat-forward)

    (define-key minibuffer-local-isearch-map (kbd "<left>") 'isearch-reverse-exit-minibuffer)
    (define-key minibuffer-local-isearch-map (kbd "<right>") 'isearch-forward-exit-minibuffer)
    ;;
    )
  ;;
  (when xah-fly-use-control-key
    (progn

      (define-key xah-fly-key-map (kbd "<C-S-prior>") 'xah-previous-emacs-buffer)
      (define-key xah-fly-key-map (kbd "<C-S-next>") 'xah-next-emacs-buffer)

      (define-key xah-fly-key-map (kbd "<C-tab>") 'xah-next-user-buffer)
      (define-key xah-fly-key-map (kbd "<C-S-tab>") 'xah-previous-user-buffer)
      (define-key xah-fly-key-map (kbd "<C-S-iso-lefttab>") 'xah-previous-user-buffer)

      (define-key xah-fly-key-map (kbd "C-SPC") 'xah-fly-leader-key-map)

      (define-key xah-fly-key-map (kbd "<C-prior>") 'xah-previous-user-buffer)
      (define-key xah-fly-key-map (kbd "<C-next>") 'xah-next-user-buffer)

      ;; (if xah-fly-swapped-1-8-and-2-7-p
      ;;     (progn
      ;;       (define-key xah-fly-key-map (kbd "C-2") 'xah-previous-user-buffer)
      ;;       (define-key xah-fly-key-map (kbd "C-1") 'xah-next-user-buffer))
      ;;   (progn
      ;;     (define-key xah-fly-key-map (kbd "C-7") 'xah-previous-user-buffer)
      ;;     (define-key xah-fly-key-map (kbd "C-8") 'xah-next-user-buffer)))

      (define-key xah-fly-key-map (kbd "C-9") 'scroll-down-command)
      (define-key xah-fly-key-map (kbd "C-0") 'scroll-up-command)

      (define-key xah-fly-key-map (kbd "C-1") 'xah-next-user-buffer)
      (define-key xah-fly-key-map (kbd "C-2") 'xah-previous-user-buffer)
      (define-key xah-fly-key-map (kbd "C-7") 'xah-previous-user-buffer)
      (define-key xah-fly-key-map (kbd "C-8") 'xah-next-user-buffer)

      (define-key xah-fly-key-map (kbd "C-5") 'xah-previous-emacs-buffer)
      (define-key xah-fly-key-map (kbd "C-6") 'xah-next-emacs-buffer)

      (define-key xah-fly-key-map (kbd "C-3") 'previous-error)
      (define-key xah-fly-key-map (kbd "C-4") 'next-error)

      (define-key xah-fly-key-map (kbd "C-a") 'mark-whole-buffer)
      (define-key xah-fly-key-map (kbd "C-n") 'xah-new-empty-buffer)
      (define-key xah-fly-key-map (kbd "C-S-n") 'make-frame-command)
      (define-key xah-fly-key-map (kbd "C-o") 'find-file)
      (define-key xah-fly-key-map (kbd "C-s") 'save-buffer)
      (define-key xah-fly-key-map (kbd "C-S-s") 'write-file)
      (define-key xah-fly-key-map (kbd "C-S-t") 'xah-open-last-closed)
      (define-key xah-fly-key-map (kbd "C-v") 'yank)
      (define-key xah-fly-key-map (kbd "C-w") 'xah-close-current-buffer)
      (define-key xah-fly-key-map (kbd "C-z") 'undo)

      (define-key xah-fly-key-map (kbd "C-+") 'text-scale-increase)
      (define-key xah-fly-key-map (kbd "C--") 'text-scale-decrease)

      (define-key xah-fly-key-map (kbd "C-d") 'pop-global-mark)
      (define-key xah-fly-key-map (kbd "C-t") 'xah-pop-local-mark-ring)

      ;;
      ))

  (progn
    (when xah-fly-use-meta-key
      (define-key xah-fly-key-map (kbd "M-SPC") 'xah-fly-command-mode-activate-no-hook))))



(defvar xah-fly-insert-state-q t "Boolean value. true means insertion mode is on.")
(setq xah-fly-insert-state-q t)

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
     ("," . xah-pop-local-mark-ring)
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
     ("0" . xah-next-window-or-frame)

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

(defun xah-fly-space-key ()
  "switch to command mode if the char before cursor is a space.
experimental
Version 2018-05-07"
  (interactive)
  (if (eq (char-before ) 32)
      (xah-fly-command-mode-activate)
    (insert " ")))

(defun xah-fly-insert-mode-init ()
  "Set insertion mode keys"
  (interactive)
  ;; (setq xah-fly-key-map (make-sparse-keymap))
  ;; (setq xah-fly-key-map (make-keymap))

  (weiss--define-keys
   xah-fly-key-map
   '(
     ("SPC" . nil)
     ;; ("SPC" . xah-fly-space-key)
     ("DEL" . nil)
     
     ("<backtab>" . nil)

     ("'" . nil)
     ("," . nil)
     ("-" . nil)
     ("." . nil)
     ("/" . nil)
     (";" . nil)
     ("=" . nil)
     ("(" . nil)
     ("[" . nil)
     ("\\" . nil)
     ("]" . nil)
     ("`" . nil)
     ("~" . nil)

     ("!" . nil)
     ;; ("$" . nil)

     ("1" . nil)
     ("2" . nil)
     ("3" . nil)
     ("4" . nil)
     ("5" . nil)
     ("6" . nil)
     ("7" . nil)
     ("8" . nil)
     ("9" . nil)
     ("0" . nil)

     ("a" . nil)
     ("b" . nil)
     ("c" . nil)
     ("d" . nil)
     ("e" . nil)
     ("f" . nil)
     ("g" . nil)
     ("h" . nil)
     ("i" . nil)
     ("j" . nil)
     ("k" . nil)
     ("l" . nil)
     ("m" . nil)
     ("n" . nil)
     ("o" . nil)
     ("p" . nil)
     ("q" . nil)
     ("r" . nil)
     ("s" . nil)
     ("t" . nil)
     ("u" . nil)
     ("v" . nil)
     ("w" . nil)
     ("x" . nil)
     ("y" . nil)
     ("z" . nil)

     ("A" . nil)
     ("B" . nil)
     ("C" . nil)
     ("D" . nil)
     ("E" . nil)
     ("F" . nil)
     ("G" . nil)
     ("H" . nil)
     ("I" . nil)
     ("J" . nil)
     ("K" . nil)
     ("L" . nil)
     ("M" . nil)
     ("N" . nil)
     ("O" . nil)
     ("P" . nil)
     ("Q" . nil)
     ("R" . nil)
     ("S" . nil)
     ("T" . nil)
     ("U" . nil)
     ("V" . nil)
     ("W" . nil)
     ("X" . nil)
     ("Y" . nil)
     ("Z" . nil)

     ;;
     ))

  (progn
    (setq xah-fly-insert-state-q t )
    (modify-all-frames-parameters (list (cons 'cursor-type 'bar))))

  (setq mode-line-front-space "I")
  (force-mode-line-update)

  ;;
  )

(defun xah-fly-mode-toggle ()
  "Switch between {insertion, command} modes."
  (interactive)
  (if xah-fly-insert-state-q
      (xah-fly-command-mode-activate)
    (xah-fly-insert-mode-activate)))

(defun xah-fly-save-buffer-if-file ()
  "Save current buffer if it is a file."
  (interactive)
  (when (buffer-file-name)
    (save-buffer)))

(defun xah-fly-command-mode-activate ()
  "Activate command mode and run `xah-fly-command-mode-activate-hook'
Version 2017-07-07"
  (interactive)
  (weiss-xfk-command-mode-init)
  (run-hooks 'xah-fly-command-mode-activate-hook))

(defun xah-fly-command-mode-activate-no-hook ()
  "Activate command mode. Does not run `xah-fly-command-mode-activate-hook'
Version 2017-07-07"
  (interactive)
  (weiss-xfk-command-mode-init))

(defun change-keybinding (prev cur)
  (interactive)
  ;; (message "a")                         
  (if (minibuffer-window-active-p (selected-window))
      nil (xah-fly-command-mode-activate))
  )

(add-hook 'switch-buffer-functions 'change-keybinding) 

(defun xah-fly-insert-mode-activate ()
  "Activate insertion mode.
Version 2017-07-07"
  (interactive)
  (xah-fly-insert-mode-init)
  (run-hooks 'xah-fly-insert-mode-activate-hook))

(defun xah-fly-insert-mode-activate-newline ()
  "Activate insertion mode, insert newline below."
  (interactive)
  (xah-fly-insert-mode-activate)
  (open-line 1))

(defun xah-fly-insert-mode-activate-space-before ()
  "Insert a space, then activate insertion mode."
  (interactive)
  (insert " ")
  (xah-fly-insert-mode-activate))

(defun xah-fly-insert-mode-activate-space-after ()
  "Insert a space, then activate insertion mode."
  (interactive)
  (insert " ")
  (xah-fly-insert-mode-activate)
  (left-char))



;; ;; when in shell mode, switch to insertion mode.
;; (add-hook 'dired-mode-hook 'xah-fly-keys-off)



;; experimental. auto switch back to command mode after some sec of idle time
;; (setq xah-fly-timer-id (run-with-idle-timer 20 t 'xah-fly-command-mode-activate))
;; (cancel-timer xah-fly-timer-id)

(define-minor-mode xah-fly-keys
  "A modal keybinding set, like vim, but based on ergonomic principles, like Dvorak layout.
URL `http://ergoemacs.org/misc/ergoemacs_vi_mode.html'"
  t "∑flykeys" xah-fly-key-map
  (progn
    ;; when going into minibuffer, switch to insertion mode.
    (add-hook 'minibuffer-setup-hook 'xah-fly-insert-mode-activate)
    (add-hook 'minibuffer-exit-hook 'xah-fly-command-mode-activate)
    ;; (add-hook 'xah-fly-command-mode-activate-hook 'xah-fly-save-buffer-if-file)
    ;; when in shell mode, switch to insertion mode.
    ;; (add-hook 'shell-mode-hook 'xah-fly-insert-mode-activate)
    )
  (xah-fly-command-mode-activate)
  ;; (add-to-list 'emulation-mode-map-alists (list (cons 'xah-fly-keys xah-fly-key-map )))
  ;; (add-to-list 'emulation-mode-map-alists '((cons xah-fly-keys xah-fly-key-map )))
  )

(defun xah-fly-keys-off ()
  "Turn off xah-fly-keys minor mode."
  (interactive)
  (progn
    (remove-hook 'minibuffer-setup-hook 'xah-fly-insert-mode-activate)
    (remove-hook 'minibuffer-exit-hook 'xah-fly-command-mode-activate)
    (remove-hook 'shell-mode-hook 'xah-fly-insert-mode-activate))
  (xah-fly-insert-mode-activate)
  (xah-fly-keys 0))

(provide 'xah-fly-keys)

;;; xah-fly-keys.el ends here
