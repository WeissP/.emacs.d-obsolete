(use-package shiftless 
  :diminish
  :load-path "/home/weiss/.emacs.d/local-package/shiftless.el"
  :straight nil
  :config
  (shiftless-programming)
  (setq shiftless-delay 0.6)
  (setq shiftless-interval 0.08)
  ;; (advice-add 'sp--post-self-insert-hook-handler :around #'shiftless--prevent-advice)
  (shiftless-mode 1)
  )

(use-package pcre2el
  :disabled
  :config
  )

(defun weiss-convert-to-emacs-regex ()
  "convert normal regex to emacs regex"
  (interactive)
  (when (use-region-p)
    (let ((nreg (buffer-substring-no-properties (region-beginning) (region-end)))
          (pos1 (region-beginning))
          (pos2 (region-end)))
      (kill-new nreg)
      (setq nreg (replace-regexp-in-string "\\." "\\." nreg nil t))
      (setq nreg (replace-regexp-in-string "\\^" "\\^" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\$" "\\$" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\*" "\\*" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\+" "\\+" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\?" "\\?" nreg nil t))
      (setq nreg (replace-regexp-in-string "\|" "\\\\|" nreg nil t))
      
      (setq nreg (replace-regexp-in-string "(" "\\\\(" nreg nil t))
      (setq nreg (replace-regexp-in-string ")" "\\\\)" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\[" "\\\\[" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\]" "\\\\]" nreg nil t))
      (setq nreg (replace-regexp-in-string "{" "\\\\{" nreg nil t))
      (setq nreg (replace-regexp-in-string "}" "\\\\}" nreg nil t))

      (setq nreg (replace-regexp-in-string "\\\\w" "[[:word:]]" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\\\s" "[[:space:]]" nreg nil t))
      (setq nreg (replace-regexp-in-string "\\\\d" "[[:digit:]]" nreg nil t))
      (delete-region (region-beginning) (region-end))
      (insert nreg)
      ))
  )


(use-package rotate-text 
  :diminish
  :config
  (setq rotate-text-words '(("true" "false")
                            ("nil" "t")
                            ("width" "height")
                            ("left" "right" "top" "bottom")
                            ("Background" "Foreground")
                            ("background" "foreground")
                            ("next" "previous")
                            ("beginning" "end")
                            ("up" "down")
                            ("Up" "Down")
                            ("forward" "backward")
                            ("expand" "contract")
                            ("enable" "disable")
                            ("increase" "decrease")
                            ("shrink" "enlarge")
                            ("copy" "yank")
                            ("show" "hide")
                            ("even" "odd"))))

(use-package hydra 
  :diminish
  :config
  (defhydra resize-window (global-map "M-w")
    "resize window"
    ("k" shrink-window "height+")
    ("j" enlarge-window "height-")
    ("h" shrink-window-horizontally "width-")
    ("l" enlarge-window-horizontally "width+")
    ("q" nil "quit")
    )

  (defhydra hydra-error (global-map "M-g")
    "goto-error"
    ("h" first-error "first")
    ("j" next-error "next")
    ("k" previous-error "prev")
    ("v" recenter-top-bottom "recenter")
    ("q" nil "quit"))
  )


(defun weiss-indent()
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (point-min) (point-max))))

(defun weiss-insert-line()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command)
  ;; (open-line 1)
  (xah-fly-insert-mode-activate)
  )

(defun weiss-paste-with-linebreak()
  (interactive)
  (beginning-of-line)
  (progn
    (when (and delete-selection-mode (region-active-p))
      (delete-region (region-beginning) (region-end)))
    (if current-prefix-arg
        (progn
          ;; (open-line 1)
          (dotimes (_ (prefix-numeric-value current-prefix-arg))
            (progn (yank) (newline)) )
          ;; (yank)
          )
      (if (eq real-last-command this-command)
          (progn (yank-pop 1)) 
        (progn (open-line 1)  (yank)))))
  (if (eq major-mode 'org-mode) nil (weiss-indent))
  )



;; (weiss-convert-to-emacs-regex )
;; (weiss-convert-to-emacs-regex "(")

(defun weiss-insert-date()
  (interactive)
  (insert (format-time-string "%d.%m.%Y")))

(defun weiss-insert-dollar()
  (interactive)
  (turn-on-org-cdlatex)
  (insert "$$")
  (xah-fly-insert-mode-activate)
  (backward-char)
  )

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)







      
