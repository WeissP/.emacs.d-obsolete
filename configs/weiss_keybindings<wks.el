(wks-define-key
 prog-mode-map ""
 '(
   ("<tab>" . weiss-indent-paragraph)
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
   ("C-n" . recenter-top-bottom)
   ("<escape>" . wks-global-quick-insert-keymap)
   ("<dead-circumflex>" . (weiss-insert-grave (insert "^")))
   ("C-<tab>" .  text-scale-increase)
   ("C-S-<iso-lefttab>" .  text-scale-decrease)
   ("<left>" . scroll-up)
   ;; ("<down>" . scroll-up)
   ("<right>" . scroll-down)
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

(with-eval-after-load 'image-mode
  (wks-unset-key image-mode-map '("SPC" "a"))
  )

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
   ("S-<dead-grave>" . weiss-open-line-and-indent)
   ("`" . weiss-open-line-and-indent)
   ("&" . weiss-expand-region-by-sexp)
   ("ß" . save-buffer)
   ("$" . (wks-C-c-C-e (execute-kbd-macro ,(kbd "C-c C-e"))))

   ("," . xah-backward-left-bracket)
   (";" . weiss-insert-semicolon)
   ("-" . mark-defun)
   ("=" . xah-shrink-whitespaces)
   ("." . xah-forward-right-bracket)
   ("!" . weiss-exchange-point-or-beginning-of-line)
   ("@" . rotate-text)
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

   ("a" . weiss-split-or-delete-window)
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
   ("O" . weiss-contract-region-by-word)
   ("p" . weiss-indent)
   ("P" . weiss-contract-region-by-sexp)
   ("q" . weiss-temp-insert-mode)
   ("r" . weiss-delete-forward-with-region)
   ("s" . snails)

   ("t e" . (wks-C-c-C-c (execute-kbd-macro ,(kbd "C-c C-c"))))
   ("t u" . (wks-C-c-quote (execute-kbd-macro ,(kbd "C-c '"))))
   ("t k" . (wks-C-c-C-k (execute-kbd-macro ,(kbd "C-c C-k"))))
   ("t o" . (wks-C-c-C-o (execute-kbd-macro ,(kbd "C-c C-o"))))
   ("t l" . (wks-C-c-C-l (execute-kbd-macro ,(kbd "C-c C-l"))))
   ("t t" . weiss-move-next-bracket-contents)
   ("t f" . weiss-flycheck-diwm)

   ("u" . undo)
   ("v" . xah-paste-or-paste-previous)
   ("V" .  weiss-paste-with-linebreak)
   ("w" . wks-repeat-command)
   ("x" . weiss-comment-dwim)
   ("y" . weiss-delete-or-add-parent-sexp)
   ("z" . split-window-below)
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
