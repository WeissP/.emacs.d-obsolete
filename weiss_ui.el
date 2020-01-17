(use-package doom-themes)
(load-theme 'doom-one-light t)

(use-package doom-modeline
  ;; :disabled                            
  ;; :diminish doom-modeline-mode
  :hook (after-init . doom-modeline-mode)
  )

(font-lock-add-keywords 'org-mode
                        '(("^.*:Frage:.*$" . font-lock-keyword-face)))

(line-number-mode -1)
(setq line-number-display-limit-width 200)

;; (+global-word-wrap-mode t) ;truncate  lines

(use-package emojify
  ;; :hook (after-init . global-emojify-mode)
  )

;; ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓highlight-indent-guides

(defun my-highlighter (level responsive display)
  ;; (if (or (< level 2)(= 0 (mod level 2)))
  ;; (if (= 0 (mod level 2))
  (if (or (< level 1))
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))

(use-package highlight-indent-guides
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
  ;; :disabled
  :straight (elispfl :type git
                     :host github
                     :repo "cireu/elispfl")
  :hook (elisp-mode . elispfl-mode))

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
  :if (display-graphic-p)
  :config
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
