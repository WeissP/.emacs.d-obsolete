(wks-define-key
 prog-mode-map ""
 '(
   ("<tab>" . weiss-indent)
   ("<RET>" . weiss-deactivate-mark-and-new-line)
   ;; ("<right>" . right-char)
   ;; ("<left>" . left-char)
   )
 )

(wks-define-key
 (current-global-map) ""
 '(
   ("M-i" . wks-vanilla-mode-disable)
   ("<backtab>" . weiss-indent)
   ("<S-delete>" . (weiss-insert-single-slash (insert "\\")))
   ("M-DEL" . (weiss-insert-single-vertical-bar (insert "|")))
   ("<f5>" . revert-buffer)
   ("M-e" . eldoc)
   ("<escape>" . wks-global-quick-insert-keymap)
   ("<dead-circumflex>" . (weiss-insert-grave (insert "^")))
   ("C-<tab>" .  text-scale-increase)
   ("C-S-<iso-lefttab>" .  text-scale-decrease)
   ("<right>" . scroll-up)
   ;; ("<down>" . scroll-up)
   ("<left>" . scroll-down)
   ;; ("<up>" . scroll-down)
   )
 )

(wks-define-key
 (current-global-map) "<escape>"
 '(
   ("," . previous-buffer)
   ("." . next-buffer)
   )
 )

(wks-unset-key help-mode-map '("h"))
(wks-unset-key messages-buffer-mode-map '("h"))

(wks-unset-key image-mode-map '("SPC"))
(wks-define-key
 image-mode-map ""
 '(
   ("j" . next-line)
   ("k" . previous-line)
   ("i" . left-char)
   ("l" . right-char)
   ("C-<tab>" .  image-increase-size)
   ("C-S-<iso-lefttab>" .  image-decrease-size)
   )
 )

(with-eval-after-load 'man-mode
  (wks-unset-key Man-mode-map '("k"))
  )

(global-unset-key (kbd "t"))
(wks-define-key
 (current-global-map) ""
 `(
   ("S-<dead-grave>" . weiss-delete-other-window)
   ("`" . weiss-delete-other-window)
   ("&" . weiss-test)
   ("ß" . save-buffer)
   ("$" . (wks-C-c-C-e (execute-kbd-macro ,(kbd "C-c C-e"))))

   ("," . xah-backward-left-bracket)
   ("-" . mark-defun)
   ("=" . split-window-below)
   ("." . xah-forward-right-bracket)
   (";" . rotate-text)
   ("/" . weiss-mark-brackets)

   ;; ("1" .  scroll-down)
   ;; ("2" .  scroll-up)
   ;; ("3" .  weiss-delete-other-window)
   ;; ("4" .  split-window-below)
   ;; ("5" .  weiss-test)
   ;; ("6" .  mark-defun)
   ;; ("7" .  xah-select-text-in-quote)
   ;; ("8" .  (wks-C-c-C-e (execute-kbd-macro ,(kbd "C-c C-e"))))
   ;; ("9" .  weiss-switch-to-otherside-top-frame)
   ;; ("0" .  weiss-switch-buffer-or-otherside-frame-without-top)

   ("a" . weiss-open-line-and-indent)
   ("b" . xah-toggle-letter-case)
   ("c" . xah-copy-line-or-region)
   ("C" . weiss-kill-append-with-comma)
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
   ("q" . weiss-temp-insert-mode)
   ("r" . weiss-delete-forward-with-region)
   ("s" . snails)

   ("t e" . (wks-C-c-C-c (execute-kbd-macro ,(kbd "C-c C-c"))))
   ("t u" . (wks-C-c-quote (execute-kbd-macro ,(kbd "C-c '"))))
   ("t k" . (wks-C-c-C-k (execute-kbd-macro ,(kbd "C-c C-k"))))
   ("t o" . (wks-C-c-C-o (execute-kbd-macro ,(kbd "C-c C-o"))))
   ("t l" . (wks-C-c-C-l (execute-kbd-macro ,(kbd "C-c C-l"))))
   ("t t" . weiss-move-next-bracket-contents)

   ("u" . weiss-delete-or-add-parent-sexp)
   ("v" . xah-paste-or-paste-previous)
   ("V" .  weiss-paste-with-linebreak)
   ("w" . xah-shrink-whitespaces)
   ("x" . weiss-exange-point-or-beginning-of-line)
   ("y" . undo)
   ("z" . weiss-comment-dwim)
   ("<end>" . weiss-simulate-c-g)
   ("SPC" . wks-leader-keymap)
   ("<deletechar>" . wks-leader-keymap)

   ("C-M-S-s-j" . weiss-switch-buffer-or-otherside-frame-without-top)
   ("C-M-S-s-k" . weiss-switch-to-same-side-frame)
   ("C-M-S-s-l" . weiss-switch-to-otherside-top-frame)
   )
 )

;; (define-key key-translation-map (kbd "<f12>") (kbd "C-g"))



(provide 'weiss_keybindings<wks)
