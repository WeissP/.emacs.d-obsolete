(defhydra hydra-resize-window (global-map "M-w")
  "resize window"
  ("k" shrink-window "height+")
  ("j" enlarge-window "height-")
  ("h" shrink-window-horizontally "width-")
  ("l" enlarge-window-horizontally "width+")
  ("q" nil "quit")
  )

(use-package highlight-symbol)

(use-package popwin 
  ;; :disabled
  :diminish
  :config
  (popwin-mode 1)
  (push '(debugger-mode :height 30) popwin:special-display-config)
  (push '("*Stardict Output*" :height 30) popwin:special-display-config)
  (push '("weiss_abbrevs.el" :height 30) popwin:special-display-config)
  ;; *Org Src abgabe-blatt01-AlgoDat.org[ LaTeX environment ]*
  )

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package hideshow 
  :diminish
  :ensure nil
  :diminish hs-minor-mode
  :bind (:map prog-mode-map
              ("C-c TAB" . hs-toggle-hiding)
              ("M-+" . hs-show-all))
  :hook (prog-mode . hs-minor-mode)
  :custom
  (hs-special-modes-alist
   (mapcar 'purecopy
           '((c-mode "{" "}" "/[*/]" nil nil)
             (c++-mode "{" "}" "/[*/]" nil nil)
             (rust-mode "{" "}" "/[*/]" nil nil)))))

(line-number-mode -1)
(setq line-number-display-limit-width 200)
;; (+global-word-wrap-mode t) ;truncate  lines

(use-package emojify 
  :diminish
  ;; :hook (after-init . global-emojify-mode)
  )

(use-package anzu 
  :diminish 
  ;; :hook (after-init . )
  :config
  (global-anzu-mode +1)
  )

;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓highlight-indent-guides
(use-package highlight-indent-guides 
  :disabled
  :diminish
  :config
  (defun my-highlighter (level responsive display)
    ;; (if (or (< level 2)(= 0 (mod level 2)))
    ;; (if (= 0 (mod level 2))
    (if (or (< level 1))
        nil
      (highlight-indent-guides--highlighter-default level responsive display)))
  ;; character style
  ;; (setq highlight-indent-guides-method 'character)
  ;; (setq highlight-indent-guides-character ?\>)
  ;; (setq highlight-indent-guides-highlighter-function 'my-highlighter)

  ;; column style
  (setq highlight-indent-guides-auto-enabled nil)
  (setq highlight-indent-guides-method 'column)
  ;; (setq highlight-indent-guides-auto-odd-face-perc #a9a9a9)
  (set-face-background 'highlight-indent-guides-odd-face "#f5f5f5")
  (set-face-background 'highlight-indent-guides-even-face "#FAFAFA")
  ;; (setq highlight-indent-guides-auto-even-face-perc 15)
  )

;; ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
;; --------------------------------------------------


(use-package elispfl 
  :diminish
  :disabled
  :quelpa (elispfl :type git
                   :host github
                   :repo "cireu/elispfl")
  :hook (elisp-mode . elispfl-mode))

(use-package color-outline
  ;; :disabled 
  :diminish
  :hook (prog-mode . color-outline-mode)
  :load-path "/home/weiss/.emacs.d/local-package/"
  :ensure nil
  :config
  (add-to-list 'color-outline-comment-char-alist '(xah-elisp-mode . ";")))

;; Fonts
(defun font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))

(when (display-graphic-p)
  ;; Set default font
  (cl-loop for font in '("SF Mono" "Hack" "Source Code Pro" "Fira Code"
                         "Menlo" "Monaco" "DejaVu Sans Mono" "Consolas")
           when (font-installed-p font)
           return (set-face-attribute 'default nil
                                      :font font
                                      :height 110))

  ;; Specify font for all unicode characters
  (cl-loop for font in '("Symbola" "Apple Symbols" "Symbol" "icons-in-terminal")
           when (font-installed-p font)
           return (set-fontset-font t 'unicode font nil 'prepend))

  ;; Specify font for Chinese characters
  (cl-loop for font in '("WenQuanYi Micro Hei" "Microsoft Yahei")
           when (font-installed-p font)
           return (set-fontset-font t '(#x4e00 . #x9fff) font)))


;; Icons
;; NOTE: Must run `M-x all-the-icons-install-fonts', and install fonts manually 
(use-package all-the-icons 
  :diminish
  :if (display-graphic-p)
  :config
  (add-to-list 'all-the-icons-mode-icon-alist '(xah-elisp-mode all-the-icons-fileicon "elisp" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(eaf-mode all-the-icons-alltheicon "atom" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(debugger-mode all-the-icons-faicon "bug" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(telega-root-mode all-the-icons-fileicon "telegram" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(telega-chat-mode all-the-icons-material "chat" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (with-no-warnings
    (defun all-the-icons-reset ()
      "Reset (unmemoize/memoize) the icons."
      (interactive)
      (dolist (f '(all-the-icons-icon-for-file
                   all-the-icons-icon-for-mode
                   all-the-icons-icon-for-url
                   all-the-icons-icon-family-for-file
                   all-the-icons-icon-family-for-mode
                   all-the-icons-icon-family))
        (ignore-errors
          (memoize-restore f)
          (memoize f)))
      (message "Reset all-the-icons"))))

;; (set-face-attribute 'region nil :background "#e8f2ff")
;; ;; (set-face-attribute 'region nil :background "#ffd1ce")
;; (global-hl-line-mode 1)
;; (set-face-attribute 'hl-line "#ffd1ce")
;; (set-face-attribute 'highlight nil)

(provide 'weiss_ui_before_dump)


