(use-package rime
  :load-path "/home/weiss/.emacs.d/emacs-rime/"
  :straight nil
  :custom
  (default-input-method "rime")
  :config
  (define-key global-map (kbd "C-f") 'toggle-input-method)

  (setq
   rime-show-candidate 'minibuffer
   rime-translate-keybindings  '("C-f" "C-b" "C-n" "C-p" "C-g"))

  (setq rime-disable-predicates
        '(
          rime--after-alphabet-char-p
          xah-command-mode-p
          weiss-after-ZH-and-SPC-p
          ;; weiss-rime-mode-check-p
          ))

  (defun weiss-after-ZH-and-SPC-p ()
    "If the cursor is after ZH + SPC."
    (looking-back "[\u4e00-\u9fa5][[:space:]]" 1))

  (defun weiss-rime-mode-check-p ()
    "Check if current mode doesn't need zh"
    (interactive)
    (cond
     ((derived-mode-p 'prog-mode) t)
     ((eq major-mode 'eaf-mode) t)
     ((eq major-mode 'dired-mode) t)
     ((eq major-mode 'magit-mode) t)
     ((eq major-mode 'wdired-mode) t)
     ((eq major-mode 'snails-mode) t)
     ((eq major-mode 'eshell-mode) t)
     ((minibuffer-window-active-p (selected-window)) t)
     (t nil)
     )
    )
  (defun weiss-activate-rime ()
    "DOCSTRING"
    (interactive)
    (if weiss-rime-mode-check-p
        nil
      (set-input-method "rime")
      )
    )

  (add-hook 'telega-chat-mode-hook '(lambda () (set-input-method "rime")))
  ;; (add-hook 'eaf-edit-mode-hook '(lambda () (set-input-method "rime")))
  ;; (add-hook 'org-mode-hook '(lambda () (set-input-method "rime")))
  ;; (add-hook 'switch-buffer-functions 'weiss-activate-rime)
  )

;; (weiss-activate-rime)



;; (define-key global-map (kbd "<f4>") 'rime-send-keybinding)
