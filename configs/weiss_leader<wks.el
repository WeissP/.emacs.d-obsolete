(define-prefix-command 'wks-leader-keymap)

(wks-define-key
 wks-leader-keymap  ""
 '(
   (", e" .  weiss-execute-buffer)
   (", c" .  quickrun-compile-only)
   (", s" .  weiss-run-java-spring)
   (", d" .  eval-defun)
   (", m" .  weiss-eval-last-sexp-this-line)
   (", r" .  eval-expression)
   (", f" .  eval-region)
   (", x" .  save-buffers-kill-terminal)
   (", 5" .  revert-buffer)

   (". p" .  narrow-to-page)
   (". x" .  widen)
   (". r" .  narrow-to-region)
   (". d" .  narrow-to-defun)                 

   ("-" . xah-cycle-hyphen-underscore-space)
   (";" . save-buffer)
   ("`" . delete-window)
   ("S-<dead-grave>" . delete-window)
   ("=" . split-window-right)
   ("5" . weiss-refresh)
   ;; ("9" . (weiss-copy-whole-buffer (kill-new (buffer-substring))))

   ("a" . mark-whole-buffer)
   ("b" . xah-toggle-previous-letter-case)

   ("c a" . weiss-kill-append)
   ("c b" . (weiss-copy-whole-buffer (kill-new (buffer-substring (point-min) (point-max)))))
   ("c e" . weiss-exchange-region-kill-ring-car)
   ("c f" . (weiss-copy-file-name (kill-new (buffer-file-name))))
   ("c k" . save-buffers-kill-terminal)
   ("c p" . xah-copy-file-path)
   ("c SPC" . weiss-kill-append-with-space)
   ("c RET" . weiss-kill-append-with-newline)
   ("c ," . weiss-kill-append-with-comma)
   ("c l" . weiss-kill-append-with-pipe)

   ("d a" .  weiss-custom-daily-agenda)
   ("d b" .  weiss-save-current-content)
   ("d c" .  org-roam-capture)
   ("d d" .  weiss-switch-and-bookmarks-search)
   ("d f" .  org-roam-find-file)
   ("d j" . yasdcv-translate-input)
   ("d l" .  list-buffers)
   ("d m" .  magit-status)
   ("d t" .  org-todo-list)
   ("d n" .  xah-new-empty-buffer)
   ("d o" .  xah-open-file-at-cursor)
   ("d s" . yasdcv-translate-at-point)
   ("d =" .  org-roam-dailies-capture-tomorrow)
   ("d !" .  org-roam-dailies-capture-today)
   ("d /" .  org-roam-dailies-capture-date)
   ("d DEL" .  org-roam-dailies-find-tomorrow)
   ("d &" .  org-roam-dailies-find-today)
   ("d -" .  org-roam-dailies-find-yesterday)
   ("d ?" .  org-roam-dailies-find-date)
   ("d w" .  xah-open-in-external-app)

   ("e b" .  org-babel-tangle)
   ("e c" .  org-capture)

   ("f" . execute-extended-command)
   ("g" . kill-line)
   ("h" . beginning-of-buffer)

   ("i d" .  weiss-insert-date)
   ("i e" .  find-file)
   ("i f" .  counsel-fzf)
   ("i j" .  yasdcv-translate-input)
   ("i m" .  all-the-icons-insert)
   ("i p" .  bookmark-set)
   ("i s" .  yasdcv-translate-at-point)
   ("i v" .  counsel-yank-pop)

   ("j K" .  Info-goto-emacs-key-command-node)
   ("j a" .  apropos-command)
   ("j b" .  describe-bindings)
   ("j c" .  describe-char)
   ("j d" .  apropos-documentation)
   ("j e" .  view-echo-area-messages)
   ("j f" .  describe-function)
   ("j g" .  info-lookup-symbol)
   ("j h" .  describe-face)
   ("j i" .  info)
   ("j j" .  man)
   ("j k" .  describe-key)
   ("j l" .  view-lossage)
   ("j m" .  describe-mode)
   ("j n" .  apropos-value)
   ("j o" .  describe-language-environment)
   ("j p" .  finder-by-keyword)
   ("j r" .  apropos-variable)
   ("j s" .  describe-syntax)
   ("j u" .  elisp-index-search)
   ("j v" .  describe-variable)
   ("j x" .  describe-coding-system)
   ("j z" .  Info-goto-emacs-command-node)

   ("k SPC" .  xah-clean-whitespace)
   ("k TAB" . move-to-column)
   ("k -" .  xah-cycle-hyphen-underscore-space)
   ("k 1" .  xah-append-to-register-1)
   ("k 2" .  xah-clear-register-1)
   ("k 3" .  xah-copy-to-register-1)
   ("k $" .  xah-copy-to-register-1)
   ("k 4" .  xah-paste-from-register-1)
   ("k DEL" .  xah-paste-from-register-1)
   ("k 8" .  xah-clear-register-1)
   ("k 7" .  xah-append-to-register-1)
   ("k 0" .  sort-numeric-fields)
   ("k S" .  reverse-region)
   ("k c" .  weiss-convert-sql-output-to-table)
   ("k d" .  delete-non-matching-lines)
   ("k e" .  list-matching-lines)
   ("k f" .  goto-line)
   ("k i" .  weiss-indent)
   ("k j" .  kill-current-buffer)
   ("k l" .  xah-escape-quotes)
   ("k m" .  xah-make-backup-and-save)
   ("k n" .  repeat-complex-command)
   ("k N" .  sort-numeric-fields)
   ("k q" .  xah-reformat-lines)
   ("k r" .  anzu-query-replace-regexp)
   ("k s" .  sort-lines)
   ("k S" .  sort-fields)
   ("k t" .  repeat)
   ("k u" .  delete-matching-lines)
   ("k y" .  delete-duplicate-lines)

   ("l SPC" .  whitespace-mode)
   ("l ." . toggle-frame-fullscreen)
   ("l 0" . shell-command-on-region)
   ("l C" .  toggle-case-fold-search)
   ("l b" .  toggle-debug-on-error)
   ("l c" .  dired-collapse-mode)
   ("l e" .  eshell)
   ("l h" .  weiss-toggle-hl-line)
   ("l l" .  highlight-symbol)             ;wrap-line
   ("l m" .  shell-command)
   ("l n" .  display-line-numbers-mode)
   ("l p" .  sql-postgres)
   ("l r" .  dired-toggle-read-only)
   ("l s" .  sudo-edit)
   ("l w" .  toggle-word-wrap)

   ("m" . dired-jump)
   ("n" . end-of-buffer)

   ("o t" .  telega)
   ("o v" . yank-rectangle)
   ("o s" . weiss-start-kmacro)
   ("o l" . weiss-kmacro-insert-letter)
   ("o k" . weiss-deactivate-mark)
   ("o e" . weiss-end-kmacro)
   ("o c" . kmacro-call-macro)

   ("p" . (weiss-insert-line-and-goto-insert-mode (weiss-insert-line) (wks-vanilla-mode-enable)))
   ("q" . xah-fill-or-unfill)
   ("r" . anzu-query-replace)
   ("s" . exchange-point-and-mark)
   ("t" . xah-show-kill-ring)
   ("u" . isearch-forward)

   ("w f" .  xref-find-definitions)
   ("w m" .  list-bookmarks)
   ("w n" .  weiss-new-frame)
   ("w t" .  weiss-test)
   ("w l" .  xref-pop-marker-stack)
   ("w y" .  winner-undo)                  ;windows setting
   ("w r" .  winner-redo)
   ("w k" .  delete-frame)
   ("w o" .  org-babel-tangle-jump-to-org)
   )
 )

(provide 'weiss_leader<wks)
