(use-package doom-themes) 
:diminish
(load-theme 'doom-one-light t)
;; (load-theme 'doom-tomorrow-day t)

(use-package doom-modeline 
  :diminish
  ;; :diminish doom-modeline-mode
  :init
  ;; (setq doom-modeline-modal-icon nil)
  (setq doom-modeline-window-width-limit fill-column)
  (setq doom-modeline-minor-modes t)
  (diminish 'abbrev-mode)
  :hook (after-init . doom-modeline-mode)
  )
;; (doom-modeline-mode)

(use-package winner-mode ; save window layouts 
  :diminish
  :straight nil
  :hook (after-init . winner-mode)
  ;; (C-c <Left>) winner-undo                
  ;; (C-c <Right>) winner-redo
  )

(use-package popwin 
  :diminish
  :config
  (popwin-mode 1)
  (push '(debugger-mode :height 30) popwin:special-display-config)
  (push '(" *Stardict Output" :height 50) popwin:special-display-config)
  )

(use-package hideshow 
  :diminish
  :straight nil
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

(use-package dashboard 
  :diminish
  :config
  (dashboard-setup-startup-hook)
  (set-face-attribute 'dashboard-footer nil :weight 'semi-light :slant 'italic)
  (setq dashboard-items '(
                          (agenda . 25)
                          )
        dashboard-init-info
        (format "[Init: %.2fs] [GC: %dx]"
                (float-time (time-subtract after-init-time before-init-time))
                gcs-done)
        ;; show-week-agenda-p t
        dashboard-banner-logo-title ""
        dashboard-startup-banner "/home/weiss/Documents/Org/Bilder/ue-light.png"
        dashboard-show-shortcuts nil
        dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                     :height 1.1
                                                     :v-adjust -0.05
                                                     :face 'font-lock-keyword-face)
        dashboard-footer (emacs-version)
        )
  )


;; (font-lock-add-keywords nil
;;                         '(("^.*:Frage:.*$" . 'font-lock-keyword-face )))


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

(defun my-highlighter (level responsive display)
  ;; (if (or (< level 2)(= 0 (mod level 2)))
  ;; (if (= 0 (mod level 2))
  (if (or (< level 1))
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))

(use-package highlight-indent-guides 
  :disabled
  :diminish
  :config
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
  :straight (elispfl :type git
                     :host github
                     :repo "cireu/elispfl")
  :hook (elisp-mode . elispfl-mode))

(use-package color-outline
  :disabled
  :diminish
  :hook (prog-mode . color-outline-mode)
  :load-path "/home/weiss/.emacs.d/local-package/"
  :straight nil)

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
    ;; FIXME: Align the directory icons
    ;; @see https://github.com/domtronn/all-the-icons.el/pull/173
    (defun all-the-icons-icon-for-dir (dir &optional chevron padding)
      "Format an icon for DIR with CHEVRON similar to tree based directories."
      (let* ((matcher (all-the-icons-match-to-alist (file-name-base (directory-file-name dir)) all-the-icons-dir-icon-alist))
             (path (expand-file-name dir))
             (chevron (if chevron (all-the-icons-octicon (format "chevron-%s" chevron) :height 0.8 :v-adjust -0.1) ""))
             (padding (or padding "\t"))
             (icon (cond
                    ((file-symlink-p path)
                     (all-the-icons-octicon "file-symlink-directory" :height 1.0 :v-adjust 0.0))
                    ((all-the-icons-dir-is-submodule path)
                     (all-the-icons-octicon "file-submodule" :height 1.0 :v-adjust 0.0))
                    ((file-exists-p (format "%s/.git" path))
                     (format "%s" (all-the-icons-octicon "repo" :height 1.1 :v-adjust 0.0)))
                    (t (apply (car matcher) (list (cadr matcher) :v-adjust 0.0))))))
        (format "%s%s%s%s%s" padding chevron padding icon padding)))

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





