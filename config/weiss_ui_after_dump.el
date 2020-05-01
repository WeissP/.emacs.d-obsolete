(winner-mode)
(rainbow-mode)

(if weiss-dumped-load-path 
    (enable-theme 'doom-one-light)
  (load-theme 'doom-one-light t)
  )
;; (load-theme 'doom-one t)
(set-face-attribute 'region nil :background "#cfe4ff")
;; (set-face-attribute 'region nil :background "#eae8ff")
;; (global-hl-line-mode 1)
;; (set-face-attribute 'hl-line nil :background "#eae8ff")
;; (set-face-attribute 'hl-line nil :background "#e3e5d0")
;; ;; (set-face-attribute 'highlight nil)

;; (setq doom-modeline-major-mode-icon t)
;; (doom-modeline-mode)

(use-package doom-modeline 
  :diminish
  ;; :diminish doom-modeline-mode
  :init
  ;; (setq doom-modeline-modal-icon nil)
  (setq doom-modeline-window-width-limit fill-column)
  ;; (setq doom-modeline-minor-modes t)
  (diminish 'abbrev-mode)
  :hook (after-init . doom-modeline-mode)
  )

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

;;;; org
(when (featurep 'org)
  (set-face-attribute 'bold  nil
                      :weight 'bold
                      :underline 'nil
                      :foreground "#f5355e"
                      :background nil)
  (set-face-attribute 'italic nil
                      :weight 'normal
                      :underline 'nil
                      :slant 'italic
                      :height 0.9
                      :foreground "#606060"
                      :background nil)
  (set-face-attribute 'underline nil
                      :weight 'bold
                      :underline 'nil
                      :foreground "medium sea green"
                      :background nil)
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :underline 'nil
                      :foreground "#20B2AA"
                      :background nil)
  (set-face-attribute 'org-block-begin-line nil
                      :weight 'normal
                      :slant 'italic
                      :extend t
                      :underline 'nil
                      :foreground "#999999"
                      :background "#FAFAFA")
  (set-face-attribute 'org-block nil
                      :extend nil
                      :background "#FAFAFA")
  (set-face-attribute 'org-drawer nil
                      :foreground "#999999"
                      ;; :slant 'italic
                      :background nil)
  (set-face-attribute 'org-headline-done nil
                      :strike-through t
                      :weight 'normal)
  (set-face-attribute 'org-level-1 nil
                      :height 1.2
                      :foreground "#ff5a19"
                      :weight 'bold)
  (set-face-attribute 'org-level-2 nil
                      :height 1.1
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-7 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)
  (set-face-attribute 'org-level-8 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal)

  (font-lock-add-keywords 'org-mode
                          '(("^.*:Frage:.*$" 0 'font-lock-keyword-face)))

  (add-to-list 'org-tag-faces '("Frage" . (:foreground "red"  :weight 'bold)))
    
  )
(provide 'weiss_ui_after_dump)
