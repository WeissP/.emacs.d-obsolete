;; -*- lexical-binding: t -*-
;; window/frame

;; [[file:../emacs-config.org::*window/frame][window/frame:1]]
;; (add-to-list 'display-buffer-alist
  ;; (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))
(winner-mode)
(if (display-graphic-p)
    (progn
      (setq default-frame-alist weiss-desktop-left-frame-alist)
      (setq initial-frame-alist weiss-desktop-right-frame-alist)
      )
  (progn
    (setq initial-frame-alist '( (tool-bar-lines . 0)))
    (setq default-frame-alist '( (tool-bar-lines . 0)))))

(use-package popwin 
  ;; :disabled
  :diminish
  :config
  (popwin-mode 1)
  (push '(debugger-mode :height 30) popwin:special-display-config)
  (push '("*Stardict Output*" :height 30) popwin:special-display-config)
  ;; (push '("weiss_abbrevs.el" :height 30) popwin:special-display-config)
  (push '("*quickrun*" :height 10) popwin:special-display-config)
  (push '("*meghanada-typeinfo*" :height 30) popwin:special-display-config)
  ;; *Org Src abgabe-blatt01-AlgoDat.org[ LaTeX environment ]*
  (setq popwin:special-display-config (delete '(occur-mode :noselect t) popwin:special-display-config))
  )
;; window/frame:1 ends here

;; theme/modeline

;; [[file:../emacs-config.org::*theme/modeline][theme/modeline:1]]
(use-package nyan-mode
  :config
  (nyan-mode))

(use-package doom-modeline 
  :diminish
  ;; :diminish doom-modeline-mode
  :init
  ;; (setq doom-modeline-modal-icon nil)
  (setq doom-modeline-window-width-limit fill-column
        ;; doom-modeline-project-detection
        ;; doom-modeline-buffer-file-name-style 'relative-to-project
        ;; doom-modeline-bar-width 6
        doom-modeline-window-width-limit 110
        )
  ;; (setq doom-modeline-minor-modes t)
    :hook (after-init . doom-modeline-mode)
  )

(if weiss-dumped-p 
    (enable-theme 'doom-one-light)
  (load-theme 'doom-one-light t)
  )
;; theme/modeline:1 ends here

;; line number

;; [[file:../emacs-config.org::*line number][line number:1]]
(line-number-mode -1)
(use-package display-line-numbers
  :custom
  (display-line-numbers-grow-only t)
  (line-number-display-limit-width 200)
  (display-line-numbers-width 3 "minimum 3 cols used for line num")
  :hook
  (prog-mode . (lambda () (interactive)(display-line-numbers-mode)(setq display-line-numbers 'relative)
                 ) )
  (dired-mode . display-line-numbers-mode)
  ;; (conf-mode . display-line-numbers-mode)
  ;; (text-mode . display-line-numbers-mode)
  )
;; line number:1 ends here

;; highlight

;; [[file:../emacs-config.org::*highlight][highlight:1]]
(use-package highlight-indent-guides 
  ;; :disabled
  :diminish
  :hook
  (python-mode . highlight-indent-guides-mode)
  :config
  ;; (defun my-highlighter (level responsive display)
  ;;   ;; (if (or (< level 2)(= 0 (mod level 2)))
  ;;   ;; (if (= 0 (mod level 2))
  ;;   (if (or (< level 1))
  ;;       nil
  ;;     (highlight-indent-guides--highlighter-default level responsive display)))
  ;; character style
  ;; (setq highlight-indent-guides-method 'character)
  ;; (setq highlight-indent-guides-character ?\>)
  ;; (setq highlight-indent-guides-highlighter-function 'my-highlighter)

  ;; column style
  (setq highlight-indent-guides-auto-enabled nil)
  (setq highlight-indent-guides-method 'character)
  (set-face-attribute 'highlight-indent-guides-character-face nil :foreground "gray")
  ;; (setq highlight-indent-guides-auto-odd-face-perc #a9a9a9)
  ;; (set-face-background 'highlight-indent-guides-odd-face "#a9a9a9")
  ;; (set-face-background 'highlight-indent-guides-even-face "#FAFAFA")
  ;; (setq highlight-indent-guides-auto-even-face-perc 15)
  )

(use-package rainbow-mode
  :hook
  (prog-mode . rainbow-mode)
  :init
  (setq rainbow-html-colors nil)
  (setq rainbow-html-colors nil)
  (setq rainbow-r-colors nil)
  (setq rainbow-x-colors nil)
  (setq rainbow-ansi-colors nil)
  (setq rainbow-latex-colors nil)
  (setq rainbow-r-colors-alist nil)
  )

(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode)
  :config
  (setq
   hl-paren-highlight-adjacent t
   hl-paren-colors '("#E53E3E" "#383a42" "#383a42" "#383a42")
   )
  (set-face-attribute 'hl-paren-face nil :weight 'bold)
  ;; (setq hl-paren-background-colors '("#E53E3E" "#c9bce9" "#FAFAFA""#FAFAFA"))
  )

(use-package hl-todo
  :init
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#FF0000")
          ("FIXME"  . "#FF0000")
          ("DEBUG"  . "#A020F0")
          ("GOTCHA" . "#FF4500")
          ("STUB"   . "#1E90FF")))
  :config
  (defhydra hydra-todo (global-map "M-t")
    "goto-todo"
    ("o" hl-todo-occur "occur")
    ("j" hl-todo-next "next")
    ("k" hl-todo-previous "prev")
    ("i" hl-todo-insert "insert")
    ("q" nil "quit"))
  (global-hl-todo-mode))

(use-package color-outline
  ;; :disabled 
  :diminish
  :hook (prog-mode . color-outline-mode)
  :load-path "/home/weiss/.emacs.d/local-package/"
  :ensure nil
  )

(use-package highlight-symbol)

(use-package anzu 
  :diminish 
  ;; :hook (after-init . )
  :config
  (global-anzu-mode +1)
  )

(use-package hl-line)
;; highlight:1 ends here

;; font

;; [[file:../emacs-config.org::*font][font:1]]
(use-package ligature
  ;; :disabled
  :quelpa (ligature 
           :fetcher github 
           :repo mickeynp/ligature.el)
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (let ((ligatures '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                     ":::" "::=" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                     "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "-<<"
                     "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                     "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                     "..." "+++" "/==" "_|_" "www" "&&" "^=" "~~" "~="
                     "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                     "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                     ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                     "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                     "##" "#?" "#_" "%%" ".-" ".." ".?" "+>" "++" "?:"
                     "?=" "?." "??" ";;" "/*" "/>" "__" "~~" "(*" "*)"
                     "://"))
        )
    (ligature-set-ligatures 'prog-mode ligatures)    
    (ligature-set-ligatures 'sgml-mode ligatures)    
    )

  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(defun font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (find-font (font-spec :name font-name)))

(when (display-graphic-p)
  ;; Set default font
  (cl-loop for font in '("JetBrainsMono" "Fira Code" "DejaVu Sans Mono" "M+1m" "SF Mono" "iosevka" "Hack" "Source Code Pro" 
                         "Menlo" "Monaco" "Consolas")
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
;; font:1 ends here

;; font lock face
;; :PROPERTIES:
;; :header-args: :tangle after-dump/weiss-after-dump.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*font lock face][font lock face:1]]
(set-face-attribute 'default nil :font "JetBrainsMono")
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono")
;; (set-face-attribute 'variable-pitch nil :font "Route159" :height 1.05)
(set-face-attribute 'variable-pitch nil :font "lato" :height 1.05)

(set-face-attribute 'font-lock-keyword-face nil :foreground "#5b5e6b" :weight 'extrabold :slant 'italic)
(set-face-attribute 'font-lock-comment-face nil :foreground "#9ca0a4" :weight 'light :slant 'normal)

(set-face-attribute 'font-lock-doc-face nil :font (font-spec :name "Route159") :weight 'normal :slant 'normal)
(set-face-attribute 'region nil :background "#cfe4ff")
(set-face-attribute 'font-lock-builtin-face nil :foreground "#a0522d" :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#383a42" :underline t)
;; font lock face:1 ends here

;; elisp 

;; [[file:../emacs-config.org::*elisp][elisp:1]]
(defface elisp-attribute-face
  '((nil :background "#F0DFF9"))
  "Face for :xxx."
  :group 'emacs-lisp-mode )

(font-lock-add-keywords
 'emacs-lisp-mode
 `(
   (,(regexp-opt xah-elisp-ampersand-words 'symbols) . font-lock-builtin-face)
   (,(regexp-opt xah-elisp-functions 'symbols) . font-lock-function-name-face)
   (,(regexp-opt xah-elisp-special-forms 'symbols) . font-lock-keyword-face)
   (,(regexp-opt xah-elisp-macros 'symbols) . font-lock-keyword-face)
   (,(regexp-opt xah-elisp-commands 'symbols) . 'font-lock-function-name-face)
   (,(regexp-opt xah-elisp-user-options 'symbols) . font-lock-variable-name-face)
   (,(regexp-opt xah-elisp-variables 'symbols) . font-lock-variable-name-face)
   (":[a-z\\-]+\\b" . 'elisp-attribute-face)
   ))
;; elisp:1 ends here

;; snails

;; [[file:../emacs-config.org::*snails][snails:1]]
(when (featurep 'snails)
  (set-face-attribute 'snails-header-line-face nil :inherit 'variable-pitch :foreground "#a626a4" :underline t :weight 'normal :slant 'italic :height 1.2)
  (set-face-attribute 'snails-header-index-face nil :inherit 'snails-header-line-face :height 0.7 :slant 'italic)
  (set-face-attribute 'snails-candiate-content-face nil :inherit 'variable-pitch :weight 'light :slant 'normal)
  (set-face-attribute 'snails-input-buffer-face nil :inherit 'variable-pitch :font (font-spec :name "lato") :height 200)
  (set-face-attribute 'snails-content-buffer-face nil :inherit 'variable-pitch :font (font-spec :name "lato") :height 150)
  )
;; snails:1 ends here

;; java

;; [[file:../emacs-config.org::*java][java:1]]
(font-lock-add-keywords
 'java-mode
 '(
   ("[a-z]<[a-zA-Z]+>"  . 'font-lock-type-face)
   ))
(add-hook 'java-mode-hook 'weiss-java-face)

(defun weiss-java-face ()
  (interactive)
  (face-remap-add-relative
   ;; 'font-lock-function-name-face '((:foreground "#383a42" :box '(:line-width 1))) font-lock-function-name-face)
   'font-lock-function-name-face '((:foreground "#383a42" :background "#f8eed4")) font-lock-function-name-face)
  (face-remap-add-relative
   'font-lock-variable-name-face '((:foreground "#383a42" :underline t)) font-lock-variable-name-face)
  (face-remap-add-relative
   'c-annotation-face '((:foreground "#A9AAAE")))
  (face-remap-add-relative
   'font-lock-type-face '((:foreground "#737C79" :background "#F7EBFC")))
  )
;; java:1 ends here

;; org

;; [[file:../emacs-config.org::*org][org:1]]
(when (featurep 'org)
  (add-hook 'org-mode-hook (lambda ()
                             (variable-pitch-mode)
                             ))
  ;; fix indentation when variable-pitch-mode is called
  (require 'org-indent)
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))  

  (set-face-attribute 'bold  nil
                      :weight 'demibold
                      :slant 'normal
                      :underline 'nil
                      :foreground "#f5355e"
                      :background nil)
  (set-face-attribute 'italic nil
                      :weight 'normal
                      :underline 'nil
                      :slant 'italic
                      :height 0.95
                      :foreground "#606060"
                      :background nil)
  (set-face-attribute 'underline nil
                      :weight 'normal
                      :underline 'nil
                      :foreground "medium sea green"
                      :background nil)
  (set-face-attribute 'org-link nil
                      :height 1.1
                      :inherit nil
                      :underline t
                      )
  (set-face-attribute 'org-block-begin-line nil
                      :weight 'normal
                      :slant 'normal
                      :extend t
                      :underline 'nil
                      :foreground "#999999"
                      :background "#FAFAFA")
  (set-face-attribute 'org-checkbox nil
                      :font "JetBrainsMono"
                      :extend nil
                      )
  (set-face-attribute 'org-table nil
                      :font "JetBrainsMono"
                      :extend nil
                      )

  (set-face-attribute 'org-block nil
                      :font "JetBrainsMono"
                      :extend nil
                      :background "#FAFAFA")

  (set-face-attribute 'org-drawer nil
                      :foreground "#999999"
                      :slant 'normal
                      :weight 'light
                      :background nil)
  (set-face-attribute 'org-special-keyword nil
                      :height 'unspecified
                      :foreground 'unspecified
                      :weight 'bold
                      :slant 'normal
                      :inherit 'org-drawer)
  (set-face-attribute 'org-property-value nil
                      :weight 'normal
                      :slant 'normal
                      :height 1.0
                      :inherit 'org-special-keyword)
  (set-face-attribute 'org-headline-done nil
                      :strike-through t
                      :weight 'normal)

  (set-face-attribute 'org-level-1 nil
                      :height 1.35
                      :foreground "#ff5a19"
                      :weight 'bold)
  (set-face-attribute 'org-level-2 nil
                      :height 0.95
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-1)
  (set-face-attribute 'org-level-3 nil
                      :height 0.95
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-2)
  (set-face-attribute 'org-level-4 nil
                      :height 0.95
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-3)
  (set-face-attribute 'org-level-5 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-4)
  (set-face-attribute 'org-level-6 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-5)
  (set-face-attribute 'org-level-7 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-6)
  (set-face-attribute 'org-level-8 nil
                      :height 1.0
                      :foreground "#040404"
                      :weight 'normal
                      :inherit 'org-level-7)

  (font-lock-add-keywords 'org-mode
                          '(("^.*:Frage:.*$" 0 'font-lock-keyword-face)))

  (add-to-list 'org-tag-faces '("Frage" . (:foreground "red"  :weight 'bold)))
  )
;; org:1 ends here

;; org-roam

;; [[file:../emacs-config.org::*org-roam][org-roam:1]]
(set-face-attribute 'org-roam-tag nil :italic t :foreground "#808080" :weight 'light)
;; org-roam:1 ends here

;; python

;; [[file:../emacs-config.org::*python][python:1]]
(add-hook 'python-mode-hook '(lambda ()
                               (face-remap-add-relative
                                'font-lock-variable-name-face
                                '((:foreground "#383a42" :underline t))
                                font-lock-variable-name-face)
                               (face-remap-add-relative
                                'default
                                '((:weight normal))
                                )))
;; python:1 ends here

;; face
;; :PROPERTIES:
;; :header-args: :tangle after-dump/weiss-after-dump.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:


;; [[file:../emacs-config.org::*face][face:1]]
(set-face-attribute 'hl-line nil :inherit nil :box nil :background "#ffe8e8" :extend nil)
(defface box-hl-line
  '((t (:inherit nil :extend nil :box (:line-width (-1 . -2) :color "#ededed" :style nil))))
  "highlight the current line with box"
  )
;; (set (make-local-variable 'hl-line-face) 'box-hl-line)

(defface normal-hl-line
  '((t :box nil :extend nil :background "#ffe8e8"))
  "highlight the current line with background"
  )

(defface emphasis-hl-line
  '((t :box nil :extend nil :background "#ffb5ff"))
  "highlight the current line with background"
  )
;; face:1 ends here

;; misc

;; [[file:../emacs-config.org::*misc][misc:1]]
(setq inhibit-startup-screen t)

(use-package command-log-mode)

;; there are some problems to set face attribute before dump
(set-face-attribute 'cursor '((nil (:background weiss/cursor-color))))
(set-face-attribute 'mc/cursor-bar-face nil :background weiss/cursor-color)
(set-cursor-color weiss/cursor-color)
(use-package emojify 
  :config
  (setq emojify-emoji-styles '(unicode github))
  ;; :hook (after-init . global-emojify-mode)
  )
;; misc:1 ends here

;; telega
;; :PROPERTIES:
;; :header-args: :tangle after-dump/weiss-after-dump.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*telega][telega:1]]
(use-package telega
  :hook
  ('telega-chat-mode . (lambda ()
                         (set (make-local-variable 'company-backends)
                              (append '(telega-company-emoji
                                        telega-company-username
                                        telega-company-hashtag)
                                      (when (telega-chat-bot-p telega-chatbuf--chat)
                                        '(telega-company-botcmd))))
                         (company-mode 1)
                         (linum-mode -1)
                         (emojify-mode)
                         )
                     )
  ('telega-root-mode . (lambda () 
                         (emojify-mode)
                         (linum-mode -1)
                         ))

  :config
  (defun weiss-get-telega-marked-text ()
    "Delete marked messages in chatbuf.
If `\\[universal-argument]' is specified, then kill
messages (delete for me only), otherwise revoke message (delete
for everyone).
If chatbuf is supergroups, channels or secret chat, then always revoke."
    (interactive)
    (when-let ((marked-messages (or (reverse telega-chatbuf--marked-messages)
                                    (when-let ((msg-at-point (telega-msg-at (point))))
                                      (list msg-at-point)))))
      ;; (message ": %s" (length marked-messages))
      (mapconcat (lambda (msg) (telega-tl-str (plist-get msg :content) :text)) marked-messages "\n\n")    
      ))

  (defun weiss-roam-telega-capture ()
    "DOCSTRING"
    (interactive)
    (let* ((content (format "* TODO %%?\n%s :fleeting:" (weiss-get-telega-marked-text)))
           (org-roam-dailies-capture-templates
            `(
              ("f" "Fleeting notes" entry #'org-roam-capture--get-point
               ,content
               :file-name "daily/Ʀd-%<%Y-%m-%d>"
               :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
               :olp ("Fleeting notes")
               )             
              )
            ))
      (org-roam-dailies-capture-today)
      ))
  (define-key telega-chat-mode-map [remap org-roam-dailies-capture-today] #'weiss-roam-telega-capture)
  (setq telega-open-file-function 'org-open-file)
  ;; (setq telega-server-libs-prefix "/usr/lib")
  (telega-notifications-mode 1)
  ;; :ryo
  ;; (:mode 'telega)
  ;; ("g" telega-chat-with)
  ;; ("n" next-line)
  ;; ("p" previous-line)
  )

;; (require 'telega)

(provide 'weiss-telega)
;; telega:1 ends here

;; ryo-bind-keys
;; Ryo-modal-mode can not bind void functions, so we bind keys at last.

;; [[file:../emacs-config.org::*ryo-bind-keys][ryo-bind-keys:1]]
(ryo-modal-keys
 (:mc-all t)
 ("RET" newline :first '(deactivate-mark) :mode 'prog-mode)
 ("RET" newline :first '(deactivate-mark) :mode 'html-mode)
 ("'"  ryo-modal-repeat)
 (","  xah-backward-left-bracket)
 ("-"  weiss-switch-to-same-side-frame)
 ("="  xah-cycle-hyphen-underscore-space)
 ("."  xah-forward-right-bracket)
 (";"  rotate-text)
 ("/"  weiss-mark-brackets)
 ("\\"  nil)
 ;; ("["  origami-recursively-toggle-node)
 ;; ("]"  weiss-other-frame)
 ;; ("}"  hs-show-all)
 ;; ("`"  other-frame)

 ;; ("<backtab>"  weiss-indent)
 ("V"  weiss-paste-with-linebreak)
 ;;  ("!"  rotate-text)
 ;; ("#"  xah-backward-quote)
 ;; ("$"  xah-forward-punct)

 ("1"  scroll-down)
 ("2"  scroll-up)
 ("3"  weiss-delete-other-window)
 ("4"  split-window-below)
 ("5"  weiss-test)
 ("6"  mark-defun :then '(weiss-select-mode-turn-on))
 ("7"  xah-select-text-in-quote)
 ("8"  weiss-select-sexp :then '(weiss-select-mode-turn-on))
 ("9"  weiss-switch-to-otherside-top-frame)
 ("0"  weiss-switch-buffer-or-otherside-frame-without-top)

 ;; ("a"  weiss-open-line-and-indent :then '(weiss-indent-nearby-lines))
 ("a"  weiss-open-line-and-indent)
 ("b"  xah-toggle-letter-case)
 ("c"  xah-copy-line-or-region)
 ("d"  weiss-cut-line-or-delete-region)
 ("e"  weiss-delete-backward-with-region)
 ("f"  weiss-before-insert-mode :exit t)
 ("g"  weiss-universal-argument)
 ("h"  weiss-select-line-downward )
 ("i"  weiss-left-key)
 ("j"  weiss-down-key)
 ("k"  weiss-up-key)
 ("l"  weiss-right-key)
 ("m"  er/expand-region :then '(weiss-select-mode-turn-on))
 ("n"  swiper-isearch)
 ("o"  weiss-expand-region-by-word :first '(weiss-select-mode-turn-on))
 ("p"  weiss-insert-line :exit t)
 ("q"  weiss-temp-insert-mode :exit t)
 ("r"  weiss-delete-forward-with-region)
 ("s"  snails)
 ("t" (
       ("e" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-c")))
        :name "C-c C-c"
        )
       ("k" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-k")))
        :name "C-c C-k"
        )
       ("u" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c '")))
        :name "C-c '"
        )         
       ("o" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-o")))
        :name "C-c C-o"
        )
       ("l" ignore
        :then ((lambda () (interactive) (weiss--execute-kbd-macro "C-c C-l")))
        :name "C-c C-l"
        )
       ))
 ("u"  weiss-delete-or-add-parent-sexp)
 ("v"  xah-paste-or-paste-previous)
 ("w"  xah-shrink-whitespaces)
 ("x"  weiss-exange-point-or-beginning-of-line)
 ("y"  undo)
 ("z"  weiss-comment-dwim)
 ("<escape> ," previous-buffer)
 ("<escape> ." next-buffer)
 )

(ryo-modal-major-mode-keys
 'emacs-lisp-mode
 ("t t"  weiss-move-next-bracket-contents)
 )

(ryo-modal-major-mode-keys
 'lisp-interaction-mode
 ("t t"  weiss-move-next-bracket-contents)
 )

(ryo-modal-command-then-ryo "M-m" 'weiss-select-mode-disable weiss-select-mode-map)

(let ((leader-keymap
       '(
         (","  (
                ("e"  weiss-execute-buffer)
                ("c"  quickrun-compile-only)
                ("d"  eval-defun)
                ("m"  weiss-eval-last-sexp-this-line)
                ("r"  eval-expression)
                ("f"  eval-region)
                ("x"  save-buffers-kill-terminal)
                ("5"  revert-buffer)
                ))
         ("." (
               ("p"  narrow-to-page)
               ("x"  widen)
               ("r"  narrow-to-region)
               ("d"  narrow-to-defun)                 
               ))
         ("-"  xah-cycle-hyphen-underscore-space)
         (";"  save-buffer)
         ("3"  delete-window)
         ("4"  split-window-right)
         ("5"  weiss-refresh)
         ;; ("6"  xah-upcase-sentence)
         ("9"  ignore
          :name "copy whole buffer"
          :then ((lambda () (interactive) (kill-new (buffer-substring)))))
         ("a"  mark-whole-buffer :then (weiss-select-mode-turn-on))
         ("b"  xah-toggle-previous-letter-case)
         ("c"  (
                ("a" weiss-kill-append)
                ("b" ignore
                 :name "copy whole buffer"
                 :then ((lambda () (interactive) (kill-new (buffer-string)))))
                ("e" weiss-exchange-region-kill-ring-car)
                ("f" ignore
                 :name "copy file name"
                 :then ((lambda () (interactive) (kill-new (buffer-file-name)))))
                ("k" save-buffers-kill-terminal)
                ("p" xah-copy-file-path)
                )
          )
         ("d" (
               ("a"  weiss-custom-daily-agenda)
               ("b"  weiss-save-current-content)
               ("c"  org-roam-capture)
               ("d"  weiss-switch-and-bookmarks-search)
               ("f"  org-roam-find-file)
               ("j" yasdcv-translate-input)
               ("l"  list-buffers)
               ("m"  magit-status)
               ("t"  org-todo-list)
               ("n"  xah-new-empty-buffer)
               ("o"  xah-open-file-at-cursor)
               ("s" yasdcv-translate-at-point)
               ("1"  org-roam-dailies-capture-today)
               ("2"  org-roam-dailies-capture-tomorrow)
               ("3"  org-roam-dailies-capture-date)
               ("8"  org-roam-dailies-find-date)
               ("9"  org-roam-dailies-find-yesterday)
               ("0"  org-roam-dailies-find-today)
               ("-"  org-roam-dailies-find-tomorrow)
               ("w"  xah-open-in-external-app)
               ))
         ("e" (
               ("b"  org-babel-tangle)
               ("c"  org-capture)
               ("v"  ignore
                :then ((lambda () (interactive) (require 'dired-video-preview-mode)(dired-video-preview-mode)))
                :name "dired-video-preview-mode")
               ))
         ("f"  execute-extended-command)
         ("g"  kill-line)
         ("h"  beginning-of-buffer)
         ("i" (
               ("d"  weiss-insert-date)
               ("e"  find-file)
               ("f"  counsel-fzf)
               ("j"  yasdcv-translate-input)
               ("m"  all-the-icons-insert)
               ("p"  bookmark-set)
               ("s"  yasdcv-translate-at-point)
               ("v"  counsel-yank-pop)
               ))
         ("j" (
               ("K"  Info-goto-emacs-key-command-node)
               ("a"  apropos-command)
               ("b"  describe-bindings)
               ("c"  describe-char)
               ("d"  apropos-documentation)
               ("e"  view-echo-area-messages)
               ("f"  describe-function)
               ("g"  info-lookup-symbol)
               ("h"  describe-face)
               ("i"  info)
               ("j"  man)
               ("k"  describe-key)
               ("l"  view-lossage)
               ("m"  describe-mode)
               ("n"  apropos-value)
               ("o"  describe-language-environment)
               ("p"  finder-by-keyword)
               ("r"  apropos-variable)
               ("s"  describe-syntax)
               ("u"  elisp-index-search)
               ("v"  describe-variable)
               ("x"  describe-coding-system)
               ("z"  Info-goto-emacs-command-node)
               )
          )
         ("k" (
               ("SPC"  xah-clean-whitespace)
               ("TAB" move-to-column)
               ("-"  xah-cycle-hyphen-underscore-space)
               ("1"  xah-append-to-register-1)
               ("2"  xah-clear-register-1)
               ("3"  xah-copy-to-register-1)
               ("4"  xah-paste-from-register-1)
               ("8"  xah-clear-register-1)
               ("7"  xah-append-to-register-1)
               ("0"  sort-numeric-fields)
               ("S"  reverse-region)
               ("c"  weiss-convert-sql-output-to-table)
               ("d"  delete-non-matching-lines)
               ("e"  list-matching-lines)
               ("f"  goto-line)
               ("i"  weiss-indent)
               ("j"  kill-current-buffer)
               ("l"  xah-escape-quotes)
               ("m"  xah-make-backup-and-save)
               ("n"  repeat-complex-command)
               ("q"  xah-reformat-lines)
               ("r"  anzu-query-replace-regexp)
               ("s"  sort-lines)
               ("t"  repeat)
               ("u"  delete-matching-lines)
               ("y"  delete-duplicate-lines)
               ))
         ("l" (
               ("SPC"  whitespace-mode)
               ("." toggle-frame-fullscreen)
               ("0" shell-command-on-region)
               ("8" ignore :then ((lambda ()(interactive) (if org-hide-emphasis-markers
                                                              (setq org-hide-emphasis-markers nil)
                                                            (setq org-hide-emphasis-markers t)
                                                            ))) :name "org-toggle-emphasis-markers")
               ("C"  toggle-case-fold-search)
               ("b"  toggle-debug-on-error)
               ("c"  dired-collapse-mode)
               ;; ("e"  ignore :then ((lambda () (interactive) (unless (featurep 'aweshell) (require 'aweshell))(eshell))) :name "eshell")
               ("e"  eshell)
               ("h"  weiss-toggle-hl-line)
               ;; ("l"  visual-line-mode)             ;wrap-line
               ("l"  highlight-symbol)             ;wrap-line
               ("m"  shell-command)
               ("n"  display-line-numbers-mode)
               ("p"  sql-postgres)
               ("r"  dired-toggle-read-only :exit t)
               ("s"  sudo-edit)
               ("w"  toggle-word-wrap)
               ))
         ("m"  dired-jump)
         ("n"  end-of-buffer)
         ("o" (
               ("t"  telega)
               ("v" yank-rectangle)
               ("n" mc/mark-next-like-this)
               ("a" mc/mark-all-like-this)
               ("s" weiss-start-kmacro)
               ;; ("l" weiss-kmacro-insert-letters)
               ("k" weiss-deactivate-mark)
               ("e" weiss-end-kmacro)
               ("c" kmacro-call-macro)
               ("SPC" hydra-multiple-cursors-weiss/body)
               ))
         ("p"  recenter-top-bottom)
         ("q"  xah-fill-or-unfill)
         ("r"  anzu-query-replace)
         ("s"  exchange-point-and-mark)
         ("t"  xah-show-kill-ring)
         ("u"  isearch-forward)
         ("v" (
               ("s"  start-kbd-macro)
               ("e"  end-kbd-macro)
               ("m"  kmacro-end-and-call-macro)
               ("c"  call-last-kbd-macro)
               ("n"  weiss-call-kmacro-multi-times)
               ))
         ("w" (
               ("f"  xref-find-definitions)
               ("m"  list-bookmarks)
               ("n"  weiss-new-frame)
               ("t"  weiss-test)
               ("l"  xref-pop-marker-stack)
               ("y"  winner-undo)                  ;windows setting
               ("r"  winner-redo)
               ("k"  delete-frame :then ((lambda () (interactive) (weiss-update-top-windows t))))
               ("o"  org-babel-tangle-jump-to-org)
               ))
         ;; ("x"  xah-cut-all-or-region)
         ;; ("y"  xah-search-current-word)
         )
       ))
  (eval `(ryo-modal-keys
          ("SPC" ,leader-keymap)
          ("<deletechar>" ,leader-keymap)
          ))
  )
;; ryo-bind-keys:1 ends here

;; tramp

;; [[file:../emacs-config.org::*tramp][tramp:1]]
;; Tramp ivy interface
(setq remote-file-name-inhibit-cache nil)

(use-package sudo-edit)

(use-package counsel-tramp
  :bind (:map counsel-mode-map
              ("C-c c T" . counsel-tramp)))

(use-package docker-tramp)
;; tramp:1 ends here

;; recentf

;; [[file:../emacs-config.org::*recentf][recentf:1]]
;; Recent files
;; recentf-cleanup will update recentf-list
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :preface
  (defun snug/recentf-save-list-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-save-list))
        (recentf-save-list)))
    (message ""))
  (defun snug/recentf-cleanup-silence ()
    (interactive)
    (let ((message-log-max nil))
      (if (fboundp 'shut-up)
          (shut-up (recentf-cleanup))
        (recentf-cleanup)))
    (message ""))
  :init
  (load (weiss--get-config-file-path "recentf"))
  (setq recentf-save-file (weiss--get-config-file-path "recentf"))
  :config
  (run-at-time nil (* 5 60) 'snug/recentf-save-list-silence)
  (run-at-time nil (* 5 60) 'snug/recentf-cleanup-silence)
  (setq
   recentf-max-menu-items 150
   recentf-max-saved-items 300
   ;; recentf-auto-cleanup '60
   ;; Recentf blacklist
   recentf-exclude '(
                     ".*autosave$"
                     "/ssh:"
                     ;; "/sudo:"
                     "recentf$"
                     ".*archive$"
                     ".*.jpg$"
                     ".*.png$"
                     ".*.gif$"
                     ".*.mp4$"
                     ".cache"
                     "cache"
                     "<none>.tex"
                     "frag-master.tex"
                     "_region_.tex"
                     "COMMIT_EDITMSG\\'"
                     ))
  )

(load (weiss--get-config-file-path "recentf"))
;; recentf:1 ends here

;; misc

;; [[file:../emacs-config.org::*misc][misc:1]]
(bookmark-load "/home/weiss/.emacs.d/bookmarks" t t t)
(setq bookmark-save-flag 1)

(ignore-errors (savehist-mode 1))
(save-place-mode 1)

(dbus-init-bus :session)   ; for EAF DUMP

(setq weiss-right-top-window (selected-frame))
(setq weiss-left-top-window (make-frame-command))
(select-frame-set-input-focus weiss-right-top-window)

(setq gc-cons-threshold (* (expt 1024 2) 32)
      gc-cons-percentage 0.5)
;; misc:1 ends here
