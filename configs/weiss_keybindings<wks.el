(wks-define-key
 prog-mode-map ""
 '(
   ("<tab>" . weiss-indent)
   ("<RET>" . weiss-deactivate-mark-and-new-line)
   )
 )

(wks-define-key
 (current-global-map) ""
 '(
   ("M-i" . wks-vanilla-mode-disable)
   ("<backtab>" . indent-for-tab-command)
   ("<S-delete>" . (weiss-insert-slash (insert "\\")))
   ("M-DEL" . (weiss-insert-slash (insert "|")))
   ("<f5>" . revert-buffer)
   ("M-e" . eldoc)
   ("<escape>" . wks-global-quick-insert-keymap)
   )
 )

(wks-define-key
 (current-global-map) "<escape>"
 '(
   ("," . previous-buffer)
   ("." . previous-buffer)
   )
 )

(global-unset-key (kbd "t"))
(wks-define-key
 (current-global-map) ""
 `(
   ("," . xah-backward-left-bracket)
   ("-" . weiss-switch-to-same-side-frame)
   ("=" . xah-cycle-hyphen-underscore-space)
   ("." . xah-forward-right-bracket)
   (";"  rotate-text)
   (";" . (weiss-copy-whole-buffer
           (kill-new (buffer-substring-no-properties (point-min) (point-max)))))
   ("/" . weiss-mark-brackets)

   ("1" .  scroll-down)
   ("2" .  scroll-up)
   ("3" .  weiss-delete-other-window)
   ("4" .  split-window-below)
   ("5" .  weiss-test)
   ("6" .  mark-defun)
   ("7" .  xah-select-text-in-quote)
   ("8" .  (wks-C-c-C-e (execute-kbd-macro ,(kbd "C-c C-e"))))
   ("9" .  weiss-switch-to-otherside-top-frame)
   ("0" .  weiss-switch-buffer-or-otherside-frame-without-top)

   ("a" . weiss-open-line-and-indent)
   ("b" . xah-toggle-letter-case)
   ("c" . xah-copy-line-or-region)
   ("d" . weiss-cut-line-or-delete-region)
   ("e" . weiss-delete-backward-with-region)
   ("f" . wks-vanilla-mode-enable)
   ("g" . weiss-universal-argument)
   ("h" . weiss-select-line-downward)
   ("i" . weiss-left-key)
   ("j" . weiss-down-key)
   ("k" . weiss-up-key)
   ("l" . weiss-right-key)
   ("m" . er/expand-region)
   ("n" . swiper-isearch)
   ("o" . weiss-expand-region-by-word)
   ("p" . (weiss-insert-line-and-goto-insert-mode (weiss-insert-line) (wks-vanilla-mode-enable)))
   ;; ("q" . )
   ("r" . weiss-delete-forward-with-region)
   ("s" . snails)

   ("t e" . (wks-C-c-C-c (execute-kbd-macro ,(kbd "C-c C-c"))))
   ("t u" . (wks-C-c-quote (execute-kbd-macro ,(kbd "C-c '"))))
   ("t k" . (wks-C-c-C-k (execute-kbd-macro ,(kbd "C-c C-k"))))
   ("t o" . (wks-C-c-C-o (execute-kbd-macro ,(kbd "C-c C-o"))))
   ("t l" . (wks-C-c-C-l (execute-kbd-macro ,(kbd "C-c C-l"))))

   ("u" . weiss-delete-or-add-parent-sexp)
   ("v" . xah-paste-or-paste-previous)
   ("V" .  weiss-paste-with-linebreak)
   ("w" . xah-shrink-whitespaces)
   ("x" . weiss-exange-point-or-beginning-of-line)
   ("y" . undo)
   ("z" . weiss-comment-dwim)
   ("<end>" . wks-vanilla-mode-disable)
   ("SPC" . wks-leader-keymap)
   )
 )


(define-key key-translation-map (kbd "<f12>") (kbd "C-g"))

(provide 'weiss_keybindings<wks)
