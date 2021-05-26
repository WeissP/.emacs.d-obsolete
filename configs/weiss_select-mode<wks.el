(defvar weiss-select-mode-p nil "nil")

(setq mark-select-mode-color "#ffcfe4")
(setq mark-non-select-mode-color "#cfe4ff")

(defun weiss-select-mode-check-region-color ()
  "if preview mode is on, change the cursor color"
  (if weiss-select-mode
      (face-remap-add-relative 'region `(:background ,mark-select-mode-color))
    (face-remap-add-relative 'region `(:background ,mark-non-select-mode-color))
    )
  )

(defun weiss-select-mode-turn-off (&rest args)
  "turn off weiss select mode"
  (interactive)
  (when weiss-select-mode (weiss-select-mode -1))  
  )

(defun weiss-select-mode-turn-on (&rest args)
  "turn on weiss select mode"
  (interactive)
  (unless weiss-select-mode (weiss-select-mode 1))  
  )

(defun weiss-select-mode-turn-on-interactive (&rest args)
  "turn on weiss select mode"
  (interactive "p")
  (unless weiss-select-mode (weiss-select-mode 1))  
  )

(add-hook 'deactivate-mark-hook 'weiss-select-mode-turn-off)

(advice-add 'keyboard-quit :before #'weiss-select-mode-turn-off)
;; (advice-add 'deactivate-mark :before #'weiss-select-mode-turn-off)

(advice-add 'xah-forward-right-bracket :after #'weiss-select-mode-turn-on)
(advice-add 'xah-backward-left-bracket :after #'weiss-select-mode-turn-on)
(advice-add 'xah-select-block :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-select-sexp :after #'weiss-select-mode-turn-on)
(advice-add 'exchange-point-and-mark :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-mark-brackets :after #'weiss-select-mode-turn-on)
(advice-add 'mark-defun :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-select-sexp :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-expand-region-by-word :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-contract-region-by-word :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-expand-region-by-sexp :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-contract-region-by-sexp :after #'weiss-select-mode-turn-on)
(advice-add 'mark-whole-buffer :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-move-to-next-punctuation :after #'weiss-select-mode-turn-on)
(advice-add 'weiss-move-to-previous-punctuation :after #'weiss-select-mode-turn-on)

(with-eval-after-load 'expand-region
  (advice-add 'er/expand-region :after #'weiss-select-mode-turn-on-interactive)
  )

(defun weiss-deactivate-mark-unless-in-select-mode (&optional a b c)
  "deactivate mark unless in select mode"
  (interactive)
  (unless weiss-select-mode (deactivate-mark)))

(advice-add 'swiper-isearch :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'counsel-describe-function :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'counsel-describe-variable :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'weiss-add-parent-sexp :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'undo :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'weiss-indent :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'weiss-indent-paragraph :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'xah-select-block :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'weiss-comment-dwim :before #'weiss-deactivate-mark-unless-in-select-mode)
;; (advice-add 'xah-paste-or-paste-previous :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'xah-open-file-at-cursor :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'weiss-delete-or-add-parent-sexp :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'org-roam-dailies--capture :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'weiss-move-to-next-block :before #'weiss-deactivate-mark-unless-in-select-mode)
(advice-add 'weiss-move-to-previous-block :before #'weiss-deactivate-mark-unless-in-select-mode)
;; (advice-add 'newline :before #'weiss-deactivate-mark-unless-in-select-mode)

(defun anzu-query-replace (arg)
  "anzu version of `query-replace'."
  (interactive "p")
  (weiss-deactivate-mark-unless-in-select-mode)
  (anzu--query-replace-common nil :prefix-arg arg))

(defun anzu-query-replace-regexp (arg)
  "anzu version of `query-replace-regexp'."
  (interactive "p")
  (weiss-deactivate-mark-unless-in-select-mode)
  (anzu--query-replace-common t :prefix-arg arg))

(defun weiss-select-mode-enable ()
  "DOCSTRING"
  (interactive)
  (setq weiss-select-mode-p t)
  (weiss-select-mode-check-region-color)
  ;; (add-hook 'switch-buffer-functions 'weiss-select-mode-check-region-color)
  (push `(weiss-select-mode . ,weiss-select-mode-map) minor-mode-overriding-map-alist) 
  )

(defun weiss-select-mode-disable ()
  "DOCSTRING"
  (interactive)
  (setq weiss-select-mode-p nil)
  (weiss-select-mode-check-region-color)
  ;; (remove-hook 'switch-buffer-functions 'weiss-select-mode-check-region-color)
  (setq minor-mode-overriding-map-alist (assq-delete-all 'weiss-select-mode minor-mode-overriding-map-alist))
  )

    ;;;###autoload
(define-minor-mode weiss-select-mode
  "weiss select mode"
  :init-value nil
  :lighter " select"
  :keymap
  (let ((keymap (make-sparse-keymap)))
    ;; (define-key keymap (kbd ";") 'xah-beginning-of-line-or-block)
    (define-key keymap (kbd "h") 'xah-end-of-line-or-block)
    (define-key keymap (kbd "i") 'backward-char)
    (define-key keymap (kbd "j") 'next-line)
    (define-key keymap (kbd "k") 'previous-line)
    (define-key keymap (kbd "l") 'forward-char)
    (define-key keymap (kbd "!") 'exchange-point-and-mark)
    keymap
    )
  :group 'weiss-select-mode
  (if weiss-select-mode
      (weiss-select-mode-enable)
    (weiss-select-mode-disable)
    ))

(provide 'weiss_select-mode<wks)
