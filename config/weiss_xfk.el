;;; xah-fly-keys.el --- ergonomic modal keybinding minor mode. -*- coding: utf-8; lexical-binding: t; -*-

;; forked from xah-fly-keys

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

(defun open-line-and-indent ()
  "open line and indent"
  (interactive)
  (open-line 1)
  (weiss-indent)
  )

(defun weiss-xah-comment-dwim ()
  "Weiss: if cursor is at end of line, auto activate insert mode
 Like `comment-dwim', but toggle comment if cursor is not at end of line.

URL `http://ergoemacs.org/emacs/emacs_toggle_comment_by_line.html'
Version 2016-10-25"
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let (($lbp (line-beginning-position))
          ($lep (line-end-position)))
      (if (eq $lbp $lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) $lep)
            (progn
              (comment-dwim nil)
              (xah-fly-insert-mode-activate)
              )
          (progn
            (comment-or-uncomment-region $lbp $lep)
            (forward-line )))))))

(defun weiss-save-current-content ()
  "save current content in temp buffer"
  (interactive)
  (let ((current-buffer-content (buffer-string))
        (current-buffer-name (buffer-name))
        )
    (setq newBuf (generate-new-buffer (format "backup_%s" current-buffer-name)))
    (set-buffer newBuf)
    (insert current-buffer-content)
    (when (eq 'major-mode 'help-mode) (quit-window))
    ))

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
  (backward-char)
  )

(defun weiss-dired-toggle-read-only ()
  "DOCSTRING"
  (interactive)
  (remove-hook 'dired-after-readin-hook 'all-the-icons-dired--display t)
  (revert-buffer)
  (dired-toggle-read-only)
  (xah-fly-command-mode-activate)
  )
;; keymaps

;; (defvar xah-fly-swapped-1-8-and-2-7-p nil "If non-nil, it means keys 1 and 8 are swapped, and 2 and 7 are swapped. See: http://xahlee.info/kbd/best_number_key_layout.html")

(defvar xah-fly-key-map (make-sparse-keymap) "Keybinding for `xah-fly-keys' minor mode.")

;; commands related to highlight
(xah-fly--define-keys
 (define-prefix-command 'xah-fly-dot-keymap)
 ;; 2019-02-22 experiment. this is now empty. so you can use this key space for all major mode custom keys or personal keys. These highlight command isn't used much in my experience
 '(
   ("p" . narrow-to-page)
   ("x" . widen)
   ("r" . narrow-to-region)
   ("d" . narrow-to-defun)
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
   )
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
   ("m" . all-the-icons-insert)
   ("d" . weiss-insert-date)
   ("f" . xah-open-file-at-cursor)
   ("g" . xah-copy-file-path)
   ("j" . counsel-recentf)
   ("n" . make-frame-command)
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
   ("a" . weiss-custom-daily-agenda)
   ("b" . weiss-save-current-content)
   ("c" . calendar)
   ("d" . weiss-switch-and-Bookmarks-search)
   ("f" . counsel-fzf)
   ("t" . telega)
   ("l" . list-buffers)
   ;; ("s" . youdao-dictionary-search-at-point-posframe)
   ;; ("j" . youdao-dictionary-search-from-input)
   ;; ("v" . youdao-dictionary-play-voice-at-point)
   ("s" . yasdcv-translate-at-point)
   ("j" . yasdcv-translate-input)
   ("v" . youdao-dictionary-play-voice-at-point)
   ("m" . magit-status)
   )
 )

(weiss--define-keys
 (define-prefix-command 'xah-fly-j-keymap)
 '(
   ("K" . Info-goto-emacs-key-command-node)
   ("a" . apropos-command)
   ("b" . describe-bindings)
   ("c" . describe-char)
   ("d" . apropos-documentation)
   ("e" . view-echo-area-messages)
   ("f" . describe-function)
   ("g" . info-lookup-symbol)
   ("h" . describe-face)
   ("i" . info)
   ("j" . man)
   ("k" . describe-key)
   ("l" . view-lossage)
   ("m" . xah-describe-major-mode)
   ("n" . apropos-value)
   ("o" . describe-language-environment)
   ("p" . finder-by-keyword)
   ("r" . apropos-variable)
   ("s" . describe-syntax)
   ("u" . elisp-index-search)
   ("v" . describe-variable)
   ("x" . describe-coding-system)
   ("z" . Info-goto-emacs-command-node)
   ))

(weiss--define-keys
 ;; toggle & shell
 (define-prefix-command 'xah-fly-l-keymap)
 '(
   ("SPC" . whitespace-mode)
   ;; RET
   ;; TAB
   ;; DEL
   ("," . abbrev-mode)
   ("." . toggle-frame-fullscreen)
   ("0" . shell-command-on-region)
   ("7" . calc)
   ("C" . toggle-case-fold-search)
   ("b" . toggle-debug-on-error)
   ("c" . dired-collapse-mode)
   ("e" . eshell)
   ("h" . global-hl-line-mode)
   ("l" . visual-line-mode)             ;wrap-line
   ("m" . shell-command)
   ("n" . global-display-line-numbers-mode)
   ("p" . weiss-org-latex-preview-all)
   ("r" . weiss-dired-toggle-read-only)
   ("s" . sudo-edit)
   ("v" . vterm-other-window)
   ("w" . toggle-word-wrap)
   ))



(weiss--define-keys
 ;; kinda replacement related
 (define-prefix-command 'xah-fly-o-keymap)
 '(
   ("SPC" . rectangle-mark-mode)
   ("," . apply-macro-to-region-lines)
   ("m" . kmacro-start-macro)
   ("3" . number-to-register)
   ("4" . increment-register)
   ("c" . copy-rectangle-as-kill)
   ("v" . yank-rectangle)
   ("d" . delete-rectangle)
   ("/" . call-last-kbd-macro)
   ("k" . kill-rectangle)
   ;; ("s" . clear-rectangle)              ;clear with space
   ("f" . xah-space-to-newline)
   ("n" . rectangle-number-lines)
   ("o" . open-rectangle)               ;add space
   ("." . kmacro-end-macro)
   ("r" . replace-rectangle)
   ("q" . xah-quote-lines)
   ;; ("y" . delete-whitespace-rectangle)
   ))

(weiss--define-keys
 (define-prefix-command 'xah-fly-k-keymap)
 '(
   ("SPC" . xah-clean-whitespace)
   ("TAB" . move-to-column)

   ("-" . xah-cycle-hyphen-underscore-space)

   ("1" . xah-append-to-register-1)
   ("2" . xah-clear-register-1)

   ("3" . xah-copy-to-register-1)
   ("4" . xah-paste-from-register-1)

   ("8" . xah-clear-register-1)
   ("7" . xah-append-to-register-1)

   ("s" . sort-lines)
   ("0" . sort-numeric-fields)
   ("S" . reverse-region)
   ;; a
   ;; b
   ("c" . weiss-convert-to-emacs-regex)
   ("d" . mark-defun)
   ("e" . list-matching-lines)
   ("f" . goto-line )
   ;; g
   ;; ("h" . xah-close-current-buffer)
   ("i" . delete-non-matching-lines)
   ("j" . kill-current-buffer)
   ;; ("k" . insert-register)
   ("l" . xah-escape-quotes)
   ("m" . xah-make-backup-and-save)
   ("n" . repeat-complex-command)
   ;; o
   ("r" . anzu-query-replace-regexp)
   ("q" . xah-reformat-lines)
   ;; ("r" . copy-rectangle-to-register)
   ;; s
   ("t" . repeat)
   ("u" . delete-matching-lines)
   ;; v
   ;; ("w" . xah-next-window-or-frame)
   ;; x
   ("y" . delete-duplicate-lines)
   ;; z
   ))

(weiss--define-keys
 (define-prefix-command 'xah-fly-e-keymap)
 '(
   ("a" . weiss-org-screenshot)
   ("b" . org-babel-tangle)
   ("e" . snails-eaf-backends)
   ("c" . org-capture)
   ("f" . eaf-open-browser)
   ("o" . org-noter)
   ("s" . org-noter-sync-current-note)
   ("l" . org-insert-link)
   ("v" . dired-video-preview-mode)
   )
 )

(weiss--define-keys
 (define-prefix-command 'xah-fly-comma-keymap)
 '(
   ("DEL" . xah-delete-current-file)
   ("e" . (lambda () (interactive)(save-buffer)(eval-buffer) ))
   ("d" . eval-defun)
   ("m" . weiss-eval-last-sexp)
   ("r" . eval-expression)
   ("f" . eval-region)
   ("x" . save-buffers-kill-terminal)
   ("w" . delete-frame)
   ("j" . xah-run-current-file)))

(weiss--define-keys
 (define-prefix-command 'xah-coding-system-keymap)
 '(
   ("n" . set-file-name-coding-system)
   ("s" . set-next-selection-coding-system)
   ("c" . universal-coding-system-argument)
   ("f" . set-buffer-file-coding-system)
   ("k" . set-keyboard-coding-system)
   ("l" . set-language-environment)
   ("p" . set-buffer-process-coding-system)
   ("r" . revert-buffer-with-coding-system)
   ("t" . set-terminal-coding-system)
   ("x" . set-selection-coding-system)))

(weiss--define-keys
 ;; kinda replacement related
 (define-prefix-command 'xah-fly-w-keymap)
 '(
   ("k" . xref-find-definitions)
   ("b" . list-buffers)
   ("m" . list-bookmarks)
   ("t" . weiss-test)
   ("l" . xref-pop-marker-stack)
   ("y" . winner-undo)                  ;windows setting
   ("r" . winner-redo)
   ))

(weiss--define-keys
 ;; abbrev
 (define-prefix-command 'xah-fly-v-keymap)
 '(
   ("s" . start-kbd-macro)   
   ("e" . end-kbd-macro)   
   ("m" . kmacro-end-and-call-macro)   
   ("c" . call-last-kbd-macro)   
   ))

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
   ("f" . execute-extended-command)
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
   ("r" . anzu-query-replace)
   ("s" . exchange-point-and-mark)
   ("t" . xah-show-kill-ring)
   ("u" . isearch-forward)
   ("v" . xah-fly-v-keymap)
   ("w" . xah-fly-w-keymap)
   ("x" . xah-cut-all-or-region)
   ("y" . xah-search-current-word)
   ("z" . xah-coding-system-keymap)
   ))


;; setting keys

(progn
  ;; set control meta, etc keys

  (progn
    (define-key xah-fly-key-map (kbd "<home>") 'xah-fly-command-mode-activate)
    (define-key xah-fly-key-map (kbd "<menu>") 'xah-fly-command-mode-activate)
    (define-key xah-fly-key-map (kbd "<f12>") 'xah-fly-command-mode-activate)
    (define-key xah-fly-key-map (kbd "<f8>") 'xah-fly-command-mode-activate-no-hook)

    (define-key xah-fly-key-map (kbd "<f9>") xah-fly-leader-key-map)

    (define-key xah-fly-key-map (kbd "<f11>") 'xah-previous-user-buffer)
    ;; (define-key xah-fly-key-map (kbd "<f12>") 'xah-next-user-buffer)
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
     ("-" . outline-show-entry)
     ("=" . color-outline-toggle-all)
     ("." . xah-forward-right-bracket)
     (";" . xah-end-of-line-or-block)
     ("/" . xah-goto-matching-bracket)
     ("\\" . nil)
     ("[" . hs-toggle-hiding)
     ("]" . hs-hide-all)
     ("}" . hs-show-all)
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
     ("8" . er/expand-region)
     ("9" . er/contract-region)
     ("0" . xah-next-window-or-frame)

     ("a" . open-line-and-indent)
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
     ("q" . weiss-replace-in-command-mode)
     ("r" . xah-kill-word)
     ("s" . snails-normal-backends)
     ("t" . set-mark-command)
     ("u" . backward-word)
     ("v" . xah-paste-or-paste-previous)
     ("w" . xah-shrink-whitespaces)
     ("x" . xah-cut-line-or-region)
     ("y" . undo)
     ("z" . weiss-xah-comment-dwim)
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
   ((eq major-mode 'telega-chat-mode) (weiss-telega-command-mode-define-keys))
   ((eq major-mode 'dired-mode) 
    (progn
      (weiss-dired-command-mode-define-keys)
      (when dired-video-preview-mode
        (weiss-dired-video-preview-command-mode-define-keys)
        )  
      )
    )
   ((eq major-mode 'wdired-mode) nil)
   ;; ((eq major-mode 'cfw:calendar-mode) (weiss-calendar-command-mode-define-keys))
   ;; ((eq major-mode 'cfw:details-mode) (weiss-calendar-command-mode-define-keys))
   (t nil)
   )
  

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
     ("}" . nil)
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

(defun xah-command-mode-p ()
  "DOCSTRING"
  (interactive)
  (if xah-fly-insert-state-q
      nil
    t
    )
  )




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


(defun change-keybinding ()
  (interactive)
  ;; (message "a")
  (if (or (eq major-mode 'eaf-edit-mode)
          (eq major-mode 'snails-mode) 
          (eq major-mode 'eaf-mode)
          (eq major-mode 'calc-mode)
          (minibuffer-window-active-p (selected-window)))
      (xah-fly-insert-mode-activate)
    (xah-fly-command-mode-activate)))

;; (add-hook 'switch-buffer-functions 'change-keybinding)

(provide 'weiss_xfk)

;;; weiss_xfk.el ends here
