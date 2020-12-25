;; -*- lexical-binding: t -*-
;; window/frame

;; [[file:~/.emacs.d/config/emacs-config.org::*window/frame][window/frame:1]]
(winner-mode)
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 105) ; chars
              (height . 53) ; lines
              (left . 1680)
              (top . 0)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 104) ; chars
              (height . 53) ; lines
              (left . 2639)
              (top . 0))))
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

;; [[file:~/.emacs.d/config/emacs-config.org::*theme/modeline][theme/modeline:1]]
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
  (diminish 'abbrev-mode)
  :hook (after-init . doom-modeline-mode)
  )

(if weiss-dumped-p 
    (enable-theme 'doom-one-light)
  (load-theme 'doom-one-light t)
  )
;; theme/modeline:1 ends here

;; line number

;; [[file:~/.emacs.d/config/emacs-config.org::*line number][line number:1]]
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

;; [[file:~/.emacs.d/config/emacs-config.org::*highlight][highlight:1]]
(use-package rainbow-mode
  :hook
  (prog-mode . rainbow-mode))

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
;; highlight:1 ends here

;; font

;; [[file:~/.emacs.d/config/emacs-config.org::*font][font:1]]
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
;; font:1 ends here

;; font lock face
;; :PROPERTIES:
;; :header-args: :tangle after-dump/weiss-after-dump.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*font lock face][font lock face:1]]
(set-face-attribute 'font-lock-keyword-face nil :font "SF mono" :foreground "#5b5e6b" :weight 'bold :slant 'italic)
(set-face-attribute 'font-lock-doc-face nil :font (font-spec :name "Lato" :size 15 :width 'narrow) :weight 'normal :slant 'italic)
(set-face-attribute 'region nil :background "#cfe4ff")
(set-face-attribute 'font-lock-builtin-face nil :foreground "#a0522d" :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#383a42" :underline t)
;; font lock face:1 ends here

;; elisp 

;; [[file:~/.emacs.d/config/emacs-config.org::*elisp][elisp:1]]
(defvar xah-elisp-ampersand-words nil "List of elisp special syntax, just &optional and &rest,")
(setq xah-elisp-ampersand-words '( "&optional" "&rest" "t" "nil"))

(defvar xah-elisp-functions nil "List of elisp functions, those in elisp doc marked as function. (basically, all functions that's not command, macro, special forms.)")
(setq xah-elisp-functions '(
                            "mouse-on-link-p"
                            "macrop"
                            "run-hooks"
                            "run-hook-with-args"
                            "run-hook-with-args-until-failure"
                            "run-hook-with-args-until-success"
                            "define-fringe-bitmap"
                            "destroy-fringe-bitmap"
                            "set-fringe-bitmap-face"
                            "file-name-directory"
                            "file-name-nondirectory"
                            "file-name-sans-versions"
                            "file-name-extension"
                            "file-name-sans-extension"
                            "file-name-base"
                            "buffer-file-name"
                            "get-file-buffer"
                            "find-buffer-visiting"
                            "make-xwidget"
                            "xwidgetp"
                            "xwidget-plist"
                            "set-xwidget-plist"
                            "xwidget-buffer"
                            "get-buffer-xwidgets"
                            "xwidget-webkit-goto-uri"
                            "xwidget-webkit-execute-script"
                            "xwidget-webkit-execute-script-rv"
                            "xwidget-webkit-get-title"
                            "xwidget-resize"
                            "xwidget-size-request"
                            "xwidget-info"
                            "set-xwidget-query-on-exit-flag"
                            "xwidget-query-on-exit-flag"
                            "split-window"
                            "window-total-height"
                            "window-total-width"
                            "window-total-size"
                            "window-pixel-height"
                            "window-pixel-width"
                            "window-full-height-p"
                            "window-full-width-p"
                            "window-body-height"
                            "window-body-width"
                            "window-body-size"
                            "window-mode-line-height"
                            "window-header-line-height"
                            "window-max-chars-per-line"
                            "window-min-size"
                            "window-edges"
                            "window-body-edges"
                            "window-at"
                            "coordinates-in-window-p"
                            "window-pixel-edges"
                            "window-body-pixel-edges"
                            "window-absolute-pixel-edges"
                            "window-absolute-body-pixel-edges"
                            "window-absolute-pixel-position"
                            "buffer-modified-p"
                            "set-buffer-modified-p"
                            "restore-buffer-modified-p"
                            "buffer-modified-tick"
                            "buffer-chars-modified-tick"
                            "decode-time"
                            "encode-time"
                            "marker-position"
                            "marker-buffer"
                            "create-fontset-from-fontset-spec"
                            "set-fontset-font"
                            "char-displayable-p"
                            "custom-add-frequent-value"
                            "custom-reevaluate-setting"
                            "custom-variable-p"
                            "custom-theme-set-variables"
                            "custom-theme-set-faces"
                            "custom-theme-p"
                            "add-to-list"
                            "add-to-ordered-list"
                            "sin"
                            "cos"
                            "tan"
                            "asin"
                            "acos"
                            "atan"
                            "exp"
                            "log"
                            "expt"
                            "sqrt"
                            "get-char-code-property"
                            "char-code-property-description"
                            "put-char-code-property"
                            "prepare-change-group"
                            "activate-change-group"
                            "accept-change-group"
                            "cancel-change-group"
                            "active-minibuffer-window"
                            "minibuffer-window"
                            "set-minibuffer-window"
                            "window-minibuffer-p"
                            "minibuffer-window-active-p"
                            "define-category"
                            "category-docstring"
                            "get-unused-category"
                            "category-table"
                            "category-table-p"
                            "standard-category-table"
                            "copy-category-table"
                            "set-category-table"
                            "make-category-table"
                            "make-category-set"
                            "char-category-set"
                            "category-set-mnemonics"
                            "modify-category-entry"
                            "memory-limit"
                            "memory-use-counts"
                            "memory-info"
                            "smie-rule-bolp"
                            "smie-rule-hanging-p"
                            "smie-rule-next-p"
                            "smie-rule-prev-p"
                            "smie-rule-parent-p"
                            "smie-rule-sibling-p"
                            "smie-rule-parent"
                            "smie-rule-separator"
                            "lookup-key"
                            "local-key-binding"
                            "global-key-binding"
                            "minor-mode-key-binding"
                            "user-ptrp"
                            "gui-get-selection"
                            "point"
                            "point-min"
                            "point-max"
                            "buffer-end"
                            "buffer-size"
                            "foo"
                            "add-to-history"
                            "car"
                            "cdr"
                            "car-safe"
                            "cdr-safe"
                            "nth"
                            "nthcdr"
                            "last"
                            "safe-length"
                            "caar"
                            "cadr"
                            "cdar"
                            "cddr"
                            "butlast"
                            "nbutlast"
                            "macroexpand"
                            "macroexpand-all"
                            "string-to-syntax"
                            "syntax-after"
                            "syntax-class"
                            "make-finalizer"
                            "unsafep"
                            "set-buffer-multibyte"
                            "string-as-unibyte"
                            "string-as-multibyte"
                            "tabulated-list-init-header"
                            "tabulated-list-print"
                            "ffloor"
                            "fceiling"
                            "ftruncate"
                            "fround"
                            "assoc"
                            "rassoc"
                            "assq"
                            "alist-get"
                            "rassq"
                            "assoc-default"
                            "copy-alist"
                            "assq-delete-all"
                            "rassq-delete-all"
                            "make-serial-process"
                            "serial-process-configure"
                            "make-temp-file"
                            "make-temp-name"
                            "current-time-zone"
                            "key-description"
                            "single-key-description"
                            "text-char-description"
                            "vectorp"
                            "vector"
                            "make-vector"
                            "vconcat"
                            "create-file-buffer"
                            "after-find-file"
                            "buffer-live-p"
                            "transpose-regions"
                            "number-to-string"
                            "string-to-number"
                            "char-to-string"
                            "string-to-char"
                            "makunbound"
                            "boundp"
                            "consp"
                            "atom"
                            "listp"
                            "nlistp"
                            "null"
                            "buffer-base-buffer"
                            "charsetp"
                            "charset-priority-list"
                            "set-charset-priority"
                            "char-charset"
                            "charset-plist"
                            "put-charset-property"
                            "get-charset-property"
                            "decode-char"
                            "encode-char"
                            "map-charset-chars"
                            "x-list-fonts"
                            "x-family-fonts"
                            "momentary-string-display"
                            "frame-char-height"
                            "frame-char-width"
                            "abbrev-symbol"
                            "abbrev-expansion"
                            "abbrev-insert"
                            "setcdr"
                            "fill-context-prefix"
                            "position-bytes"
                            "byte-to-position"
                            "bufferpos-to-filepos"
                            "filepos-to-bufferpos"
                            "multibyte-string-p"
                            "string-bytes"
                            "unibyte-string"
                            "split-window-sensibly"
                            "same-window-p"
                            "get-text-property"
                            "get-char-property"
                            "get-pos-property"
                            "get-char-property-and-overlay"
                            "text-properties-at"
                            "color-defined-p"
                            "defined-colors"
                            "color-supported-p"
                            "color-gray-p"
                            "color-values"
                            "scroll-bar-event-ratio"
                            "scroll-bar-scale"
                            "get-register"
                            "set-register"
                            "register-read-with-preview"
                            "button-start"
                            "button-end"
                            "button-get"
                            "button-put"
                            "button-activate"
                            "button-label"
                            "button-type"
                            "button-has-type-p"
                            "button-at"
                            "button-type-put"
                            "button-type-get"
                            "button-type-subtype-p"
                            "buffer-list"
                            "other-buffer"
                            "last-buffer"
                            "current-frame-configuration"
                            "set-frame-configuration"
                            "funcall"
                            "apply"
                            "apply-partially"
                            "identity"
                            "ignore"
                            "file-name-as-directory"
                            "directory-name-p"
                            "directory-file-name"
                            "abbreviate-file-name"
                            "delete-and-extract-region"
                            "map-y-or-n-p"
                            "message"
                            "message-or-box"
                            "message-box"
                            "display-message-or-buffer"
                            "current-message"
                            "ding"
                            "beep"
                            "x-popup-dialog"
                            "network-interface-list"
                            "network-interface-info"
                            "format-network-address"
                            "floatp"
                            "integerp"
                            "numberp"
                            "natnump"
                            "zerop"
                            "imagemagick-types"
                            "completion-table-dynamic"
                            "completion-table-with-cache"
                            "mouse-position"
                            "set-mouse-position"
                            "mouse-pixel-position"
                            "set-mouse-pixel-position"
                            "mouse-absolute-pixel-position"
                            "set-mouse-absolute-pixel-position"
                            "frame-pointer-visible-p"
                            "tool-bar-add-item"
                            "tool-bar-add-item-from-menu"
                            "tool-bar-local-item-from-menu"
                            "send-string-to-terminal"
                            "insert-and-inherit"
                            "insert-before-markers-and-inherit"
                            "completing-read"
                            "minibuffer-prompt"
                            "minibuffer-prompt-end"
                            "minibuffer-prompt-width"
                            "minibuffer-contents"
                            "minibuffer-contents-no-properties"
                            "windowp"
                            "window-live-p"
                            "window-valid-p"
                            "selected-window"
                            "selected-window-group"
                            "window-resizable"
                            "window-resize"
                            "adjust-window-trailing-edge"
                            "edebug-trace"
                            "frame-live-p"
                            "window-frame"
                            "window-list"
                            "frame-root-window"
                            "window-parent"
                            "window-top-child"
                            "window-left-child"
                            "window-child"
                            "window-combined-p"
                            "window-next-sibling"
                            "window-prev-sibling"
                            "frame-first-window"
                            "window-in-direction"
                            "window-tree"
                            "tty-top-frame"
                            "font-family-list"
                            "bitmap-spec-p"
                            "region-beginning"
                            "region-end"
                            "use-region-p"
                            "default-value"
                            "default-boundp"
                            "set-default"
                            "put-text-property"
                            "add-text-properties"
                            "remove-text-properties"
                            "remove-list-of-text-properties"
                            "set-text-properties"
                            "add-face-text-property"
                            "propertize"
                            "not"
                            "error"
                            "signal"
                            "user-error"
                            "set-marker"
                            "move-marker"
                            "frame-current-scroll-bars"
                            "frame-scroll-bar-width"
                            "frame-scroll-bar-height"
                            "set-window-scroll-bars"
                            "window-scroll-bars"
                            "window-current-scroll-bars"
                            "window-scroll-bar-width"
                            "window-scroll-bar-height"
                            "window-hscroll"
                            "set-window-hscroll"
                            "create-image"
                            "find-image"
                            "image-load-path-for-library"
                            "make-byte-code"
                            "field-beginning"
                            "field-end"
                            "field-string"
                            "field-string-no-properties"
                            "delete-field"
                            "constrain-to-field"
                            "insert-for-yank"
                            "insert-buffer-substring-as-yank"
                            "get-internal-run-time"
                            "eq"
                            "equal"
                            "equal-including-properties"
                            "define-package"
                            "print"
                            "princ"
                            "prin1"
                            "terpri"
                            "write-char"
                            "pp"
                            "set-process-sentinel"
                            "process-sentinel"
                            "waiting-for-user-input-p"
                            "make-char-table"
                            "char-table-p"
                            "char-table-subtype"
                            "char-table-parent"
                            "set-char-table-parent"
                            "char-table-extra-slot"
                            "set-char-table-extra-slot"
                            "char-table-range"
                            "set-char-table-range"
                            "map-char-table"
                            "string-match"
                            "string-match-p"
                            "looking-at"
                            "looking-back"
                            "looking-at-p"
                            "make-syntax-table"
                            "copy-syntax-table"
                            "char-syntax"
                            "set-syntax-table"
                            "syntax-table"
                            "face-remap-add-relative"
                            "face-remap-remove-relative"
                            "face-remap-set-base"
                            "face-remap-reset-base"
                            "keymap-parent"
                            "set-keymap-parent"
                            "make-composed-keymap"
                            "define-key"
                            "substitute-key-definition"
                            "suppress-keymap"
                            "plist-get"
                            "plist-put"
                            "lax-plist-get"
                            "lax-plist-put"
                            "plist-member"
                            "libxml-parse-html-region"
                            "shr-insert-document"
                            "libxml-parse-xml-region"
                            "recenter-window-group"
                            "called-interactively-p"
                            "keywordp"
                            "compare-buffer-substrings"
                            "notifications-notify"
                            "notifications-close-notification"
                            "notifications-get-capabilities"
                            "notifications-get-server-information"
                            "sequencep"
                            "length"
                            "elt"
                            "copy-sequence"
                            "reverse"
                            "nreverse"
                            "sort"
                            "seq-elt"
                            "seq-length"
                            "seqp"
                            "seq-drop"
                            "seq-take"
                            "seq-take-while"
                            "seq-drop-while"
                            "seq-do"
                            "seq-map"
                            "seq-mapn"
                            "seq-filter"
                            "seq-remove"
                            "seq-reduce"
                            "seq-some"
                            "seq-find"
                            "seq-every-p"
                            "seq-empty-p"
                            "seq-count"
                            "seq-sort"
                            "seq-contains"
                            "seq-position"
                            "seq-uniq"
                            "seq-subseq"
                            "seq-concatenate"
                            "seq-mapcat"
                            "seq-partition"
                            "seq-intersection"
                            "seq-difference"
                            "seq-group-by"
                            "seq-into"
                            "seq-min"
                            "seq-max"
                            "stringp"
                            "string-or-null-p"
                            "char-or-string-p"
                            "ewoc-create"
                            "ewoc-buffer"
                            "ewoc-get-hf"
                            "ewoc-set-hf"
                            "ewoc-enter-first"
                            "ewoc-enter-last"
                            "ewoc-enter-before"
                            "ewoc-enter-after"
                            "ewoc-prev"
                            "ewoc-next"
                            "ewoc-nth"
                            "ewoc-data"
                            "ewoc-set-data"
                            "ewoc-locate"
                            "ewoc-location"
                            "ewoc-goto-prev"
                            "ewoc-goto-next"
                            "ewoc-goto-node"
                            "ewoc-refresh"
                            "ewoc-invalidate"
                            "ewoc-delete"
                            "ewoc-filter"
                            "ewoc-collect"
                            "ewoc-map"
                            "indirect-function"
                            "set-network-process-option"
                            "face-spec-set"
                            "substitute-command-keys"
                            "make-progress-reporter"
                            "progress-reporter-update"
                            "progress-reporter-force-update"
                            "progress-reporter-done"
                            "current-buffer"
                            "set-buffer"
                            "minibufferp"
                            "minibuffer-selected-window"
                            "minibuffer-message"
                            "this-command-keys"
                            "this-command-keys-vector"
                            "clear-this-command-keys"
                            "markerp"
                            "integer-or-marker-p"
                            "number-or-marker-p"
                            "make-translation-table"
                            "make-translation-table-from-vector"
                            "make-translation-table-from-alist"
                            "sit-for"
                            "sleep-for"
                            "read-from-minibuffer"
                            "read-string"
                            "read-regexp"
                            "read-no-blanks-input"
                            "frame-visible-p"
                            "make-process"
                            "make-pipe-process"
                            "start-process"
                            "start-file-process"
                            "start-process-shell-command"
                            "start-file-process-shell-command"
                            "find-file-name-handler"
                            "file-local-copy"
                            "file-remote-p"
                            "unhandled-file-name-directory"
                            "match-data"
                            "set-match-data"
                            "overlay-get"
                            "overlay-put"
                            "overlay-properties"
                            "file-name-absolute-p"
                            "file-relative-name"
                            "hack-dir-local-variables"
                            "hack-dir-local-variables-non-file-buffer"
                            "dir-locals-set-class-variables"
                            "dir-locals-set-directory-class"
                            "make-button"
                            "insert-button"
                            "make-text-button"
                            "insert-text-button"
                            "insert-image"
                            "insert-sliced-image"
                            "put-image"
                            "remove-images"
                            "image-size"
                            "insert-file-contents"
                            "insert-file-contents-literally"
                            "format"
                            "format-message"
                            "run-mode-hooks"
                            "cl-call-next-method"
                            "cl-next-method-p"
                            "char-equal"
                            "string-equal"
                            "string-collate-equalp"
                            "string-prefix-p"
                            "string-suffix-p"
                            "string-lessp"
                            "string-greaterp"
                            "string-collate-lessp"
                            "compare-strings"
                            "assoc-string"
                            "display-popup-menus-p"
                            "display-graphic-p"
                            "display-mouse-p"
                            "display-color-p"
                            "display-grayscale-p"
                            "display-supports-face-attributes-p"
                            "display-selections-p"
                            "display-images-p"
                            "display-screens"
                            "display-pixel-height"
                            "display-pixel-width"
                            "display-mm-height"
                            "display-mm-width"
                            "display-backing-store"
                            "display-save-under"
                            "display-planes"
                            "display-visual-class"
                            "display-color-cells"
                            "x-server-version"
                            "x-server-vendor"
                            "define-prefix-command"
                            "insert"
                            "insert-before-markers"
                            "insert-buffer-substring"
                            "insert-buffer-substring-no-properties"
                            "replace-match"
                            "match-substitute-replacement"
                            "set-input-mode"
                            "current-input-mode"
                            "tty-color-define"
                            "tty-color-clear"
                            "tty-color-alist"
                            "tty-color-approximate"
                            "tty-color-translate"
                            "call-process"
                            "process-file"
                            "call-process-region"
                            "call-process-shell-command"
                            "process-file-shell-command"
                            "shell-command-to-string"
                            "process-lines"
                            "current-kill"
                            "kill-new"
                            "kill-append"
                            "symbol-function"
                            "fboundp"
                            "fmakunbound"
                            "fset"
                            "hack-local-variables"
                            "safe-local-variable-p"
                            "risky-local-variable-p"
                            "keymapp"
                            "select-safe-coding-system"
                            "read-coding-system"
                            "read-non-nil-coding-system"
                            "current-time-string"
                            "current-time"
                            "float-time"
                            "seconds-to-time"
                            "set-default-file-modes"
                            "default-file-modes"
                            "read-file-modes"
                            "file-modes-symbolic-to-number"
                            "set-file-times"
                            "set-file-extended-attributes"
                            "set-file-selinux-context"
                            "set-file-acl"
                            "current-left-margin"
                            "current-fill-column"
                            "delete-to-left-margin"
                            "indent-to-left-margin"
                            "sort-subr"
                            "backup-file-name-p"
                            "make-backup-file-name"
                            "find-backup-file-name"
                            "file-newest-backup"
                            "locate-user-emacs-file"
                            "convert-standard-filename"
                            "add-hook"
                            "remove-hook"
                            "error-message-string"
                            "window-point"
                            "set-window-point"
                            "quit-restore-window"
                            "x-parse-geometry"
                            "process-list"
                            "get-process"
                            "process-command"
                            "process-contact"
                            "process-id"
                            "process-name"
                            "process-status"
                            "process-live-p"
                            "process-type"
                            "process-exit-status"
                            "process-tty-name"
                            "process-coding-system"
                            "set-process-coding-system"
                            "process-get"
                            "process-put"
                            "process-plist"
                            "set-process-plist"
                            "keyboard-translate"
                            "execute-kbd-macro"
                            "date-to-time"
                            "format-time-string"
                            "format-seconds"
                            "make-ring"
                            "ring-p"
                            "ring-size"
                            "ring-length"
                            "ring-elements"
                            "ring-copy"
                            "ring-empty-p"
                            "ring-ref"
                            "ring-insert"
                            "ring-remove"
                            "ring-insert-at-beginning"
                            "set-window-combination-limit"
                            "window-combination-limit"
                            "regexp-quote"
                            "regexp-opt"
                            "regexp-opt-depth"
                            "regexp-opt-charset"
                            "provide"
                            "require"
                            "featurep"
                            "backup-buffer"
                            "event-modifiers"
                            "event-basic-type"
                            "mouse-movement-p"
                            "event-convert-list"
                            "read-key-sequence"
                            "read-key-sequence-vector"
                            "file-truename"
                            "file-chase-links"
                            "file-equal-p"
                            "file-in-directory-p"
                            "eval"
                            "frame-parameter"
                            "frame-parameters"
                            "modify-frame-parameters"
                            "set-frame-parameter"
                            "modify-all-frames-parameters"
                            "process-datagram-address"
                            "set-process-datagram-address"
                            "current-window-configuration"
                            "set-window-configuration"
                            "window-configuration-p"
                            "compare-window-configurations"
                            "window-configuration-frame"
                            "window-state-get"
                            "window-state-put"
                            "charset-after"
                            "find-charset-region"
                            "find-charset-string"
                            "abbrev-table-put"
                            "abbrev-table-get"
                            "coding-system-list"
                            "coding-system-p"
                            "check-coding-system"
                            "coding-system-eol-type"
                            "coding-system-change-eol-conversion"
                            "coding-system-change-text-conversion"
                            "find-coding-systems-region"
                            "find-coding-systems-string"
                            "find-coding-systems-for-charsets"
                            "check-coding-systems-region"
                            "detect-coding-region"
                            "detect-coding-string"
                            "coding-system-charset-list"
                            "iter-next"
                            "iter-close"
                            "locate-file"
                            "executable-find"
                            "symbol-name"
                            "make-symbol"
                            "intern"
                            "intern-soft"
                            "mapatoms"
                            "unintern"
                            "current-column"
                            "special-variable-p"
                            "accessible-keymaps"
                            "map-keymap"
                            "where-is-internal"
                            "window-display-table"
                            "set-window-display-table"
                            "redisplay"
                            "force-window-update"
                            "window-start"
                            "window-group-start"
                            "window-end"
                            "window-group-end"
                            "set-window-start"
                            "set-window-group-start"
                            "pos-visible-in-window-p"
                            "pos-visible-in-window-group-p"
                            "window-line-height"
                            "fringe-bitmaps-at-pos"
                            "buffer-name"
                            "get-buffer"
                            "generate-new-buffer-name"
                            "jit-lock-register"
                            "jit-lock-unregister"
                            "file-notify-add-watch"
                            "file-notify-rm-watch"
                            "file-notify-valid-p"
                            "local-variable-p"
                            "local-variable-if-set-p"
                            "buffer-local-value"
                            "buffer-local-variables"
                            "kill-all-local-variables"
                            "eventp"
                            "skip-chars-forward"
                            "skip-chars-backward"
                            "window-parameter"
                            "window-parameters"
                            "set-window-parameter"
                            "recent-keys"
                            "terminal-parameters"
                            "terminal-parameter"
                            "set-terminal-parameter"
                            "memq"
                            "delq"
                            "remq"
                            "memql"
                            "member"
                            "delete"
                            "remove"
                            "member-ignore-case"
                            "delete-dups"
                            "parse-partial-sexp"
                            "get-buffer-create"
                            "generate-new-buffer"
                            "current-global-map"
                            "current-local-map"
                            "current-minor-mode-maps"
                            "use-global-map"
                            "use-local-map"
                            "set-transient-map"
                            "accept-process-output"
                            "skip-syntax-forward"
                            "skip-syntax-backward"
                            "backward-prefix-chars"
                            "vertical-motion"
                            "count-screen-lines"
                            "move-to-window-group-line"
                            "compute-motion"
                            "file-exists-p"
                            "file-readable-p"
                            "file-executable-p"
                            "file-writable-p"
                            "file-accessible-directory-p"
                            "access-file"
                            "file-ownership-preserved-p"
                            "file-modes"
                            "open-network-stream"
                            "undo-boundary"
                            "undo-auto-amalgamate"
                            "primitive-undo"
                            "keyboard-coding-system"
                            "terminal-coding-system"
                            "symbolp"
                            "booleanp"
                            "functionp"
                            "subrp"
                            "byte-code-function-p"
                            "subr-arity"
                            "char-width"
                            "string-width"
                            "truncate-string-to-width"
                            "window-text-pixel-size"
                            "documentation-property"
                            "documentation"
                            "face-documentation"
                            "Snarf-documentation"
                            "match-string"
                            "match-string-no-properties"
                            "match-beginning"
                            "match-end"
                            "coding-system-priority-list"
                            "set-coding-system-priority"
                            "x-popup-menu"
                            "-"
                            "mod"
                            "symbol-file"
                            "command-line"
                            "get-load-suffixes"
                            "defalias"
                            "define-button-type"
                            "custom-set-variables"
                            "custom-set-faces"
                            "interactive-form"
                            "encode-coding-string"
                            "decode-coding-string"
                            "decode-coding-inserted-region"
                            "make-hash-table"
                            "secure-hash"
                            "frame-geometry"
                            "frame-edges"
                            "buffer-narrowed-p"
                            "locale-info"
                            "keymap-prompt"
                            "set-window-margins"
                            "window-margins"
                            "try-completion"
                            "all-completions"
                            "test-completion"
                            "completion-boundaries"
                            "add-to-invisibility-spec"
                            "remove-from-invisibility-spec"
                            "invisible-p"
                            "char-after"
                            "char-before"
                            "following-char"
                            "preceding-char"
                            "bobp"
                            "eobp"
                            "bolp"
                            "eolp"
                            "coding-system-get"
                            "coding-system-aliases"
                            "defvaralias"
                            "make-obsolete-variable"
                            "indirect-variable"
                            "read-file-name"
                            "read-directory-name"
                            "read-shell-command"
                            "select-window"
                            "frame-selected-window"
                            "set-frame-selected-window"
                            "window-use-time"
                            "make-glyph-code"
                            "glyph-char"
                            "glyph-face"
                            "command-remapping"
                            "help-buffer"
                            "help-setup-xref"
                            "downcase"
                            "upcase"
                            "capitalize"
                            "upcase-initials"
                            "redraw-frame"
                            "characterp"
                            "max-char"
                            "get-byte"
                            "float"
                            "truncate"
                            "floor"
                            "ceiling"
                            "round"
                            "window-vscroll"
                            "set-window-vscroll"
                            "selected-frame"
                            "select-frame-set-input-focus"
                            "redirect-frame-focus"
                            "image-multi-frame-p"
                            "image-current-frame"
                            "image-show-frame"
                            "image-animate"
                            "image-animate-timer"
                            "replace-regexp-in-string"
                            "perform-replace"
                            "current-idle-time"
                            "subst-char-in-region"
                            "derived-mode-p"
                            "dom-node"
                            "face-attribute"
                            "face-attribute-relative-p"
                            "face-all-attributes"
                            "merge-face-attribute"
                            "set-face-attribute"
                            "set-face-bold"
                            "set-face-italic"
                            "set-face-underline"
                            "set-face-inverse-video"
                            "face-font"
                            "face-foreground"
                            "face-background"
                            "face-stipple"
                            "face-bold-p"
                            "face-italic-p"
                            "face-underline-p"
                            "face-inverse-video-p"
                            "file-name-all-completions"
                            "file-name-completion"
                            "make-string"
                            "string"
                            "substring"
                            "substring-no-properties"
                            "concat"
                            "split-string"
                            "window-buffer"
                            "set-window-buffer"
                            "get-buffer-window"
                            "get-buffer-window-list"
                            "process-query-on-exit-flag"
                            "set-process-query-on-exit-flag"
                            "process-send-string"
                            "process-send-region"
                            "process-send-eof"
                            "process-running-child-p"
                            "frame-position"
                            "set-frame-position"
                            "frame-pixel-height"
                            "frame-pixel-width"
                            "frame-text-height"
                            "frame-text-width"
                            "frame-height"
                            "frame-width"
                            "set-frame-size"
                            "set-frame-height"
                            "set-frame-width"
                            "recursion-depth"
                            "buffer-substring"
                            "buffer-substring-no-properties"
                            "buffer-string"
                            "filter-buffer-substring"
                            "current-word"
                            "thing-at-point"
                            "bufferp"
                            "random"
                            "processp"
                            "case-table-p"
                            "set-standard-case-table"
                            "standard-case-table"
                            "current-case-table"
                            "set-case-table"
                            "set-case-syntax-pair"
                            "set-case-syntax-delims"
                            "set-case-syntax"
                            "window-prev-buffers"
                            "set-window-prev-buffers"
                            "window-next-buffers"
                            "set-window-next-buffers"
                            "read-passwd"
                            "bindat-unpack"
                            "bindat-get-field"
                            "bindat-length"
                            "bindat-pack"
                            "bindat-ip-to-string"
                            "frame-list"
                            "visible-frame-list"
                            "next-frame"
                            "previous-frame"
                            "face-list"
                            "face-id"
                            "face-equal"
                            "face-differs-from-default-p"
                            "file-symlink-p"
                            "file-directory-p"
                            "file-regular-p"
                            "find-file-noselect"
                            "event-click-count"
                            "fontp"
                            "font-at"
                            "font-spec"
                            "font-put"
                            "find-font"
                            "list-fonts"
                            "font-get"
                            "font-face-attributes"
                            "font-xlfd-name"
                            "font-info"
                            "query-font"
                            "default-font-width"
                            "default-font-height"
                            "window-font-width"
                            "window-font-height"
                            "kbd"
                            "terminal-name"
                            "terminal-list"
                            "get-device-terminal"
                            "delete-terminal"
                            "x-display-list"
                            "x-open-connection"
                            "x-close-connection"
                            "display-monitor-attributes-list"
                            "frame-monitor-attributes"
                            "read-event"
                            "read-char"
                            "read-char-exclusive"
                            "read-key"
                            "read-char-choice"
                            "backtrace-debug"
                            "backtrace-frame"
                            "directory-files"
                            "directory-files-recursively"
                            "directory-files-and-attributes"
                            "file-expand-wildcards"
                            "insert-directory"
                            "scan-lists"
                            "scan-sexps"
                            "forward-comment"
                            "tq-create"
                            "tq-enqueue"
                            "tq-close"
                            "set-window-fringes"
                            "window-fringes"
                            "commandp"
                            "call-interactively"
                            "funcall-interactively"
                            "command-execute"
                            "make-bool-vector"
                            "bool-vector"
                            "bool-vector-p"
                            "bool-vector-exclusive-or"
                            "bool-vector-union"
                            "bool-vector-intersection"
                            "bool-vector-set-difference"
                            "bool-vector-not"
                            "bool-vector-subsetp"
                            "bool-vector-count-consecutive"
                            "bool-vector-count-population"
                            "current-active-maps"
                            "key-binding"
                            "byte-compile"
                            "batch-byte-compile"
                            "tooltip-mode"
                            "tooltip-event-buffer"
                            "gap-position"
                            "gap-size"
                            "fetch-bytecode"
                            "define-key-after"
                            "set-process-filter"
                            "process-filter"
                            "read-minibuffer"
                            "eval-minibuffer"
                            "edit-and-eval-command"
                            "verify-visited-file-modtime"
                            "clear-visited-file-modtime"
                            "visited-file-modtime"
                            "set-visited-file-modtime"
                            "ask-user-about-supersession-threat"
                            "string-to-multibyte"
                            "string-to-unibyte"
                            "byte-to-string"
                            "multibyte-char-to-unibyte"
                            "unibyte-char-to-multibyte"
                            "syntax-ppss"
                            "syntax-ppss-flush-cache"
                            "smie-config-local"
                            "read"
                            "read-from-string"
                            "set-binary-mode"
                            "event-start"
                            "event-end"
                            "posnp"
                            "posn-window"
                            "posn-area"
                            "posn-point"
                            "posn-x-y"
                            "posn-col-row"
                            "posn-actual-col-row"
                            "posn-string"
                            "posn-image"
                            "posn-object"
                            "posn-object-x-y"
                            "posn-object-width-height"
                            "posn-timestamp"
                            "posn-at-point"
                            "posn-at-x-y"
                            "image-flush"
                            "clear-image-cache"
                            "sentence-end"
                            "system-name"
                            "parse-colon-path"
                            "load-average"
                            "emacs-pid"
                            "y-or-n-p"
                            "y-or-n-p-with-timeout"
                            "yes-or-no-p"
                            "hash-table-p"
                            "copy-hash-table"
                            "hash-table-count"
                            "hash-table-test"
                            "hash-table-weakness"
                            "hash-table-rehash-size"
                            "hash-table-rehash-threshold"
                            "hash-table-size"
                            "custom-initialize-delay"
                            "dump-emacs"
                            "define-error"
                            "set-auto-mode"
                            "set-buffer-major-mode"
                            "next-window"
                            "previous-window"
                            "walk-windows"
                            "one-window-p"
                            "get-lru-window"
                            "get-mru-window"
                            "get-largest-window"
                            "get-window-with-predicate"
                            "list-system-processes"
                            "process-attributes"
                            "define-abbrev"
                            "find-auto-coding"
                            "set-auto-coding"
                            "find-operation-coding-system"
                            "listify-key-sequence"
                            "input-pending-p"
                            "discard-input"
                            "messages-buffer"
                            "set"
                            "auto-save-file-name-p"
                            "make-auto-save-file-name"
                            "recent-auto-save-p"
                            "set-buffer-auto-saved"
                            "delete-auto-save-file-if-necessary"
                            "rename-auto-save-file"
                            "abbrev-put"
                            "abbrev-get"
                            "forward-word-strictly"
                            "backward-word-strictly"
                            "advice-add"
                            "advice-remove"
                            "advice-member-p"
                            "advice-mapc"
                            "store-substring"
                            "clear-string"
                            "user-login-name"
                            "user-real-login-name"
                            "user-full-name"
                            "user-real-uid"
                            "user-uid"
                            "group-gid"
                            "group-real-gid"
                            "system-users"
                            "system-groups"
                            "play-sound"
                            "overlays-at"
                            "overlays-in"
                            "next-overlay-change"
                            "previous-overlay-change"
                            "next-property-change"
                            "previous-property-change"
                            "next-single-property-change"
                            "previous-single-property-change"
                            "next-char-property-change"
                            "previous-char-property-change"
                            "next-single-char-property-change"
                            "previous-single-char-property-change"
                            "text-property-any"
                            "text-property-not-all"
                            "symbol-value"
                            "make-abbrev-table"
                            "abbrev-table-p"
                            "clear-abbrev-table"
                            "copy-abbrev-table"
                            "define-abbrev-table"
                            "insert-abbrev-table-description"
                            "advice-function-member-p"
                            "advice-function-mapc"
                            "advice-eval-interactive-spec"
                            "display-buffer-same-window"
                            "display-buffer-reuse-window"
                            "display-buffer-pop-up-frame"
                            "display-buffer-use-some-frame"
                            "display-buffer-pop-up-window"
                            "display-buffer-below-selected"
                            "display-buffer-in-previous-window"
                            "display-buffer-at-bottom"
                            "display-buffer-use-some-window"
                            "display-buffer-no-window"
                            "isnan"
                            "frexp"
                            "ldexp"
                            "copysign"
                            "logb"
                            "file-newer-than-file-p"
                            "file-attributes"
                            "file-nlinks"
                            "barf-if-buffer-read-only"
                            "file-acl"
                            "file-selinux-context"
                            "file-extended-attributes"
                            "zlib-available-p"
                            "zlib-decompress-region"
                            "window-preserve-size"
                            "window-preserved-size"
                            "load"
                            "arrayp"
                            "aref"
                            "aset"
                            "fillarray"
                            "delete-process"
                            "image-mask-p"
                            "interrupt-process"
                            "kill-process"
                            "quit-process"
                            "stop-process"
                            "continue-process"
                            "minibuffer-depth"
                            "gethash"
                            "puthash"
                            "remhash"
                            "clrhash"
                            "maphash"
                            "read-quoted-char"
                            "eql"
                            "max"
                            "min"
                            "abs"
                            "framep"
                            "frame-terminal"
                            "terminal-live-p"
                            "image-type-available-p"
                            "mapcar"
                            "mapc"
                            "mapconcat"
                            "purecopy"
                            "current-bidi-paragraph-direction"
                            "move-point-visually"
                            "bidi-string-mark-left-to-right"
                            "bidi-find-overridden-directionality"
                            "buffer-substring-with-bidi-context"
                            "special-form-p"
                            "type-of"
                            "syntax-ppss-toplevel-pos"
                            "shell-quote-argument"
                            "split-string-and-unquote"
                            "combine-and-quote-strings"
                            "posix-looking-at"
                            "posix-string-match"
                            "smie-setup"
                            "define-hash-table-test"
                            "sxhash"
                            "window-system"
                            "setcar"
                            "read-buffer"
                            "read-command"
                            "read-variable"
                            "force-mode-line-update"
                            "file-locked-p"
                            "lock-buffer"
                            "unlock-buffer"
                            "ask-user-about-lock"
                            "make-display-table"
                            "display-table-slot"
                            "set-display-table-slot"
                            "describe-display-table"
                            "get"
                            "put"
                            "symbol-plist"
                            "setplist"
                            "function-get"
                            "function-put"
                            "process-buffer"
                            "process-mark"
                            "set-process-buffer"
                            "get-buffer-process"
                            "set-process-window-size"
                            "current-indentation"
                            "read-input-method-name"
                            "make-obsolete"
                            "set-advertised-calling-convention"
                            "suspend-tty"
                            "resume-tty"
                            "controlling-tty-p"
                            "overlayp"
                            "make-overlay"
                            "overlay-start"
                            "overlay-end"
                            "overlay-buffer"
                            "delete-overlay"
                            "move-overlay"
                            "remove-overlays"
                            "copy-overlay"
                            "overlay-recenter"
                            "nconc"
                            "expand-file-name"
                            "substitute-in-file-name"
                            "prefix-numeric-value"
                            "lsh"
                            "ash"
                            "logand"
                            "logior"
                            "logxor"
                            "lognot"
                            "display-warning"
                            "lwarn"
                            "warn"
                            "next-button"
                            "previous-button"
                            "font-lock-add-keywords"
                            "font-lock-remove-keywords"
                            "current-justification"
                            "display-completion-list"
                            "make-sparse-keymap"
                            "make-keymap"
                            "copy-keymap"
                            "window-right-divider-width"
                            "window-bottom-divider-width"
                            "autoload"
                            "autoloadp"
                            "autoload-do-load"
                            "syntax-table-p"
                            "standard-syntax-table"
                            "throw"
                            "facep"
                            "x-get-resource"
                            "set-marker-insertion-type"
                            "marker-insertion-type"
                            "format-mode-line"
                            "quietly-read-abbrev-file"
                            "window-dedicated-p"
                            "set-window-dedicated-p"
                            "cancel-timer"
                            "make-network-process"
                            "time-less-p"
                            "time-subtract"
                            "time-add"
                            "time-to-days"
                            "time-to-day-in-year"
                            "date-leap-year-p"
                            "buffer-swap-text"
                            "mark"
                            "mark-marker"
                            "set-mark"
                            "push-mark"
                            "pop-mark"
                            "deactivate-mark"
                            "handle-shift-selection"
                            "cons"
                            "list"
                            "make-list"
                            "append"
                            "copy-tree"
                            "number-sequence"
                            "line-beginning-position"
                            "line-end-position"
                            "count-lines"
                            "line-number-at-pos"
                            "completion-in-region"
                            "make-marker"
                            "point-marker"
                            "point-min-marker"
                            "point-max-marker"
                            "copy-marker"
                            ))

(defvar xah-elisp-special-forms nil "List of elisp special forms.")
(setq xah-elisp-special-forms '(
                                "catch"
                                "function"
                                "setq"
                                "eval-and-compile"
                                "eval-when-compile"
                                "defvar"
                                "defconst"
                                "if"
                                "cond"
                                "track-mouse"
                                "save-restriction"
                                "with-no-warnings"
                                "interactive"
                                "save-excursion"
                                "while"
                                "condition-case"
                                "quote"
                                "save-current-buffer"
                                "let"
                                "let*"
                                "and"
                                "or"
                                "setq-default"
                                "unwind-protect"
                                "count-loop"
                                "progn"
                                "prog1"
                                "prog2"
                                ))

(defvar xah-elisp-macros nil "List of elisp macros.")
(setq xah-elisp-macros '(
                         "defcustom"
                         "deftheme"
                         "provide-theme"
                         "push"
                         "save-match-data"
                         "pop"
                         "defsubst"
                         "define-alternatives"
                         "with-output-to-temp-buffer"
                         "with-temp-buffer-window"
                         "with-current-buffer-window"
                         "with-displayed-buffer-window"
                         "pcase"
                         "pcase-defmacro"
                         "with-temp-message"
                         "declare-function"
                         "edebug-tracing"
                         "defimage"
                         "setf"
                         "with-output-to-string"
                         "with-syntax-table"
                         "seq-doseq"
                         "seq-let"
                         "with-eval-after-load"
                         "defface"
                         "dotimes-with-progress-reporter"
                         "with-current-buffer"
                         "with-temp-buffer"
                         "delay-mode-hooks"
                         "cl-defgeneric"
                         "cl-defmethod"
                         "gv-define-simple-setter"
                         "gv-define-setter"
                         "defmacro"
                         "with-file-modes"
                         "condition-case-unless-debug"
                         "ignore-errors"
                         "with-demoted-errors"
                         "easy-menu-define"
                         "save-window-excursion"
                         "iter-defun"
                         "iter-lambda"
                         "iter-yield"
                         "iter-yield-from"
                         "iter-do"
                         "setq-local"
                         "defvar-local"
                         "define-generic-mode"
                         "with-local-quit"
                         "dolist"
                         "dotimes"
                         "save-mark-and-excursion"
                         "with-coding-priority"
                         "defun"
                         "define-inline"
                         "inline-quote"
                         "inline-letevals"
                         "inline-const-p"
                         "inline-const-val"
                         "inline-error"
                         "define-minor-mode"
                         "define-globalized-minor-mode"
                         "lazy-completion-table"
                         "define-obsolete-variable-alias"
                         "save-selected-window"
                         "with-selected-window"
                         "declare"
                         "with-help-window"
                         "make-help-screen"
                         "define-derived-mode"
                         "when"
                         "unless"
                         "combine-after-change-calls"
                         "with-case-table"
                         "define-obsolete-face-alias"
                         "noreturn"
                         "def-edebug-spec"
                         "while-no-input"
                         "define-advice"
                         "add-function"
                         "remove-function"
                         "lambda"
                         "define-obsolete-function-alias"
                         "with-temp-file"
                         "defgroup"
                         "with-timeout"
                         ))

(defvar xah-elisp-commands nil "List of elisp commands.")
(setq xah-elisp-commands '(
                           "debug-on-entry"
                           "cancel-debug-on-entry"
                           "beginning-of-line"
                           "end-of-line"
                           "forward-line"
                           "count-words"
                           "switch-to-buffer"
                           "switch-to-buffer-other-window"
                           "switch-to-buffer-other-frame"
                           "pop-to-buffer"
                           "indent-relative"
                           "indent-relative-maybe"
                           "run-at-time"
                           "write-abbrev-file"
                           "indent-for-tab-command"
                           "indent-according-to-mode"
                           "newline-and-indent"
                           "reindent-then-newline-and-indent"
                           "minibuffer-complete-word"
                           "minibuffer-complete"
                           "minibuffer-complete-and-exit"
                           "minibuffer-completion-help"
                           "fill-paragraph"
                           "fill-region"
                           "fill-individual-paragraphs"
                           "fill-region-as-paragraph"
                           "justify-current-line"
                           "push-button"
                           "forward-button"
                           "backward-button"
                           "append-to-file"
                           "write-region"
                           "universal-argument"
                           "digit-argument"
                           "negative-argument"
                           "suspend-emacs"
                           "suspend-frame"
                           "set-input-method"
                           "indent-to"
                           "describe-current-display-table"
                           "read-color"
                           "smie-close-block"
                           "smie-down-list"
                           "posix-search-forward"
                           "posix-search-backward"
                           "save-buffer"
                           "save-some-buffers"
                           "write-file"
                           "signal-process"
                           "exit-minibuffer"
                           "self-insert-and-exit"
                           "previous-history-element"
                           "next-history-element"
                           "previous-matching-history-element"
                           "next-matching-history-element"
                           "previous-complete-history-element"
                           "next-complete-history-element"
                           "load-file"
                           "load-library"
                           "read-only-mode"
                           "kill-emacs"
                           "indent-region"
                           "indent-rigidly"
                           "indent-code-rigidly"
                           "play-sound-file"
                           "forward-word"
                           "backward-word"
                           "auto-save-mode"
                           "do-auto-save"
                           "package-upload-file"
                           "package-upload-buffer"
                           "other-window"
                           "edebug-display-freq-count"
                           "normal-mode"
                           "fundamental-mode"
                           "getenv"
                           "setenv"
                           "smie-config-guess"
                           "smie-config-save"
                           "smie-config-show-indent"
                           "smie-config-set-indent"
                           "search-forward"
                           "search-backward"
                           "word-search-forward"
                           "word-search-forward-lax"
                           "word-search-backward"
                           "word-search-backward-lax"
                           "base64-encode-region"
                           "base64-decode-region"
                           "compile-defun"
                           "byte-compile-file"
                           "byte-recompile-directory"
                           "execute-extended-command"
                           "backtrace"
                           "make-frame-on-display"
                           "find-file"
                           "find-file-literally"
                           "find-file-other-window"
                           "find-file-read-only"
                           "format-write-file"
                           "format-find-file"
                           "format-insert-file"
                           "enable-command"
                           "disable-command"
                           "switch-to-prev-buffer"
                           "switch-to-next-buffer"
                           "describe-buffer-case-table"
                           "recursive-edit"
                           "exit-recursive-edit"
                           "abort-recursive-edit"
                           "top-level"
                           "replace-buffer-in-windows"
                           "goto-char"
                           "forward-char"
                           "backward-char"
                           "set-face-foreground"
                           "set-face-background"
                           "set-face-stipple"
                           "set-face-font"
                           "invert-face"
                           "translate-region"
                           "run-with-idle-timer"
                           "delete-window"
                           "delete-other-windows"
                           "delete-windows-on"
                           "describe-mode"
                           "select-frame"
                           "handle-switch-frame"
                           "redraw-display"
                           "apropos"
                           "strong>help-command"
                           "describe-prefix-bindings"
                           "Helper-describe-bindings"
                           "Helper-help"
                           "revert-buffer"
                           "narrow-to-region"
                           "narrow-to-page"
                           "widen"
                           "disassemble"
                           "encode-coding-region"
                           "decode-coding-region"
                           "imenu-add-to-menubar"
                           "set-keyboard-coding-system"
                           "set-terminal-coding-system"
                           "move-to-window-line"
                           "display-buffer"
                           "keyboard-quit"
                           "open-dribble-file"
                           "make-local-variable"
                           "make-variable-buffer-local"
                           "kill-local-variable"
                           "rename-buffer"
                           "describe-bindings"
                           "move-to-column"
                           "eval-region"
                           "eval-buffer"
                           "edebug-set-initial-mode"
                           "package-initialize"
                           "insert-buffer"
                           "self-insert-command"
                           "newline"
                           "list-processes"
                           "quit-window"
                           "sort-regexp-fields"
                           "sort-lines"
                           "sort-paragraphs"
                           "sort-pages"
                           "sort-fields"
                           "sort-numeric-fields"
                           "sort-columns"
                           "set-left-margin"
                           "set-right-margin"
                           "move-to-left-margin"
                           "add-name-to-file"
                           "rename-file"
                           "copy-file"
                           "make-symbolic-link"
                           "delete-file"
                           "set-file-modes"
                           "insert-char"
                           "emacs-version"
                           "iconify-frame"
                           "make-frame-visible"
                           "make-frame-invisible"
                           "minibuffer-inactive-mode"
                           "scroll-up"
                           "scroll-down"
                           "scroll-up-command"
                           "scroll-down-command"
                           "scroll-other-window"
                           "recenter"
                           "recenter-top-bottom"
                           "modify-syntax-entry"
                           "describe-syntax"
                           "re-search-forward"
                           "re-search-backward"
                           "emacs-uptime"
                           "emacs-init-time"
                           "delete-horizontal-space"
                           "delete-indentation"
                           "fixup-whitespace"
                           "just-one-space"
                           "delete-blank-lines"
                           "delete-trailing-whitespace"
                           "debug"
                           "scroll-left"
                           "scroll-right"
                           "blink-matching-open"
                           "global-set-key"
                           "global-unset-key"
                           "local-set-key"
                           "local-unset-key"
                           "raise-frame"
                           "lower-frame"
                           "delete-frame"
                           "fit-window-to-buffer"
                           "fit-frame-to-buffer"
                           "shrink-window-if-larger-than-buffer"
                           "balance-windows"
                           "balance-windows-area"
                           "maximize-window"
                           "minimize-window"
                           "delete-minibuffer-contents"
                           "open-termscript"
                           "erase-buffer"
                           "delete-region"
                           "delete-char"
                           "delete-backward-char"
                           "backward-delete-char-untabify"
                           "capitalize-region"
                           "downcase-region"
                           "upcase-region"
                           "capitalize-word"
                           "downcase-word"
                           "upcase-word"
                           "bury-buffer"
                           "unbury-buffer"
                           "make-frame"
                           "view-register"
                           "insert-register"
                           "kill-region"
                           "copy-region-as-kill"
                           "expand-abbrev"
                           "abbrev-prefix-mark"
                           "set-frame-font"
                           "list-charset-chars"
                           "make-indirect-buffer"
                           "clone-indirect-buffer"
                           "make-directory"
                           "copy-directory"
                           "delete-directory"
                           "locate-library"
                           "list-load-path-shadows"
                           "tab-to-tab-stop"
                           "kill-buffer"
                           "back-to-indentation"
                           "backward-to-indentation"
                           "forward-to-indentation"
                           "unload-feature"
                           "read-kbd-macro"
                           "serial-term"
                           "buffer-enable-undo"
                           "buffer-disable-undo"
                           "text-mode"
                           "prog-mode"
                           "special-mode"
                           "beginning-of-buffer"
                           "end-of-buffer"
                           "forward-list"
                           "backward-list"
                           "up-list"
                           "backward-up-list"
                           "down-list"
                           "forward-sexp"
                           "backward-sexp"
                           "beginning-of-defun"
                           "end-of-defun"
                           "gui-set-selection"
                           "undefined"
                           "garbage-collect"
                           "describe-categories"
                           "load-theme"
                           "enable-theme"
                           "disable-theme"
                           "not-modified"
                           "yank"
                           "yank-pop"
                           "split-window-right"
                           "split-window-below"
                           "set-visited-file-name"
                           ))

(defvar xah-elisp-user-options nil "List of user options.")
(setq xah-elisp-user-options '(
                               "switch-to-buffer-in-dedicated-window"
                               "switch-to-buffer-preserve-window-point"
                               "transient-mark-mode"
                               "mark-even-if-inactive"
                               "mark-ring-max"
                               "timer-max-repeats"
                               "abbrev-file-name"
                               "save-abbrevs"
                               "custom-unlispify-remove-prefixes"
                               "tab-always-indent"
                               "completion-auto-help"
                               "fill-individual-varying-indent"
                               "default-justification"
                               "sentence-end-double-space"
                               "sentence-end-without-period"
                               "sentence-end-without-space"
                               "debug-on-quit"
                               "default-input-method"
                               "indent-tabs-mode"
                               "window-adjust-process-window-size-function"
                               "create-lockfiles"
                               "completion-styles"
                               "completion-category-overrides"
                               "read-buffer-function"
                               "read-buffer-completion-ignore-case"
                               "before-save-hook"
                               "after-save-hook"
                               "file-precious-flag"
                               "require-final-newline"
                               "warning-minimum-level"
                               "warning-minimum-log-level"
                               "warning-suppress-types"
                               "warning-suppress-log-types"
                               "inhibit-startup-screen"
                               "initial-buffer-choice"
                               "inhibit-startup-echo-area-message"
                               "initial-scratch-message"
                               "enable-recursive-minibuffers"
                               "delete-exited-processes"
                               "initial-frame-alist"
                               "minibuffer-frame-alist"
                               "default-frame-alist"
                               "indicate-empty-lines"
                               "indicate-buffer-boundaries"
                               "overflow-newline-into-fringe"
                               "backup-by-copying"
                               "backup-by-copying-when-linked"
                               "backup-by-copying-when-mismatch"
                               "backup-by-copying-when-privileged-mismatch"
                               "case-fold-search"
                               "case-replace"
                               "user-mail-address"
                               "words-include-escapes"
                               "version-control"
                               "kept-new-versions"
                               "kept-old-versions"
                               "delete-old-versions"
                               "dired-kept-versions"
                               "auto-save-visited-file-name"
                               "auto-save-interval"
                               "auto-save-timeout"
                               "auto-save-default"
                               "delete-auto-save-files"
                               "auto-save-list-file-prefix"
                               "message-log-max"
                               "auto-coding-regexp-alist"
                               "file-coding-system-alist"
                               "auto-coding-alist"
                               "auto-coding-functions"
                               "only-global-abbrevs"
                               "package-archives"
                               "package-archive-upload-base"
                               "initial-major-mode"
                               "major-mode"
                               "mail-host-address"
                               "page-delimiter"
                               "paragraph-separate"
                               "paragraph-start"
                               "sentence-end"
                               "smie-config"
                               "edebug-eval-macro-args"
                               "echo-keystrokes"
                               "double-click-fuzz"
                               "double-click-time"
                               "find-file-wildcards"
                               "find-file-hook"
                               "switch-to-visible-buffer"
                               "frame-resize-pixelwise"
                               "completion-ignored-extensions"
                               "focus-follows-mouse"
                               "no-redraw-on-reenter"
                               "help-char"
                               "help-event-list"
                               "three-step-help"
                               "read-file-name-completion-ignore-case"
                               "insert-default-directory"
                               "revert-without-query"
                               "face-font-family-alternatives"
                               "face-font-selection-order"
                               "face-font-registry-alternatives"
                               "scalable-fonts-allowed"
                               "load-prefer-newer"
                               "selective-display-ellipses"
                               "inhibit-eol-conversion"
                               "display-buffer-alist"
                               "display-buffer-base-action"
                               "kill-ring-max"
                               "void-text-area-pointer"
                               "exec-suffixes"
                               "exec-path"
                               "max-lisp-eval-depth"
                               "edebug-sit-for-seconds"
                               "make-backup-files"
                               "backup-directory-alist"
                               "make-backup-file-name-function"
                               "edebug-setup-hook"
                               "edebug-all-defs"
                               "edebug-all-forms"
                               "edebug-save-windows"
                               "edebug-save-displayed-buffer-points"
                               "edebug-initial-mode"
                               "edebug-trace"
                               "edebug-test-coverage"
                               "edebug-continue-kbd-macro"
                               "edebug-unwrap-results"
                               "edebug-on-error"
                               "edebug-on-quit"
                               "edebug-global-break-condition"
                               "window-combination-limit"
                               "window-combination-resize"
                               "edebug-print-length"
                               "edebug-print-level"
                               "edebug-print-circle"
                               "frame-auto-hide-function"
                               "sort-fold-case"
                               "sort-numeric-base"
                               "fill-prefix"
                               "fill-column"
                               "left-margin"
                               "fill-nobreak-predicate"
                               "enable-local-variables"
                               "safe-local-variable-values"
                               "enable-local-eval"
                               "safe-local-eval-forms"
                               "frame-inhibit-implied-resize"
                               "display-mm-dimensions-alist"
                               "remote-file-name-inhibit-cache"
                               "read-regexp-defaults-function"
                               "max-mini-window-height"
                               "mode-line-format"
                               "eval-expression-print-length"
                               "eval-expression-print-level"
                               "scroll-margin"
                               "scroll-conservatively"
                               "scroll-down-aggressively"
                               "scroll-up-aggressively"
                               "scroll-step"
                               "scroll-preserve-screen-position"
                               "next-screen-context-lines"
                               "scroll-error-top-bottom"
                               "recenter-redisplay"
                               "recenter-positions"
                               "byte-compile-dynamic-docstrings"
                               "yank-handled-properties"
                               "yank-excluded-properties"
                               "max-specpdl-size"
                               "term-file-prefix"
                               "term-file-aliases"
                               "image-load-path"
                               "scroll-bar-mode"
                               "horizontal-scroll-bar-mode"
                               "blink-matching-paren"
                               "blink-matching-paren-distance"
                               "blink-matching-delay"
                               "underline-minimum-offset"
                               "x-bitmap-file-path"
                               "minibuffer-auto-raise"
                               "window-resize-pixelwise"
                               "fit-window-to-buffer-horizontally"
                               "fit-frame-to-buffer"
                               "fit-frame-to-buffer-margins"
                               "fit-frame-to-buffer-sizes"
                               "baud-rate"
                               "imagemagick-enabled-types"
                               "imagemagick-types-inhibit"
                               "visible-bell"
                               "ring-bell-function"
                               "site-run-file"
                               "inhibit-default-init"
                               "backward-delete-char-untabify-method"
                               "cursor-in-non-selected-windows"
                               "x-stretch-cursor"
                               "blink-cursor-alist"
                               "truncate-lines"
                               "truncate-partial-width-windows"
                               "kill-read-only-ok"
                               "pop-up-windows"
                               "split-window-preferred-function"
                               "split-height-threshold"
                               "split-width-threshold"
                               "even-window-sizes"
                               "pop-up-frames"
                               "pop-up-frame-function"
                               "pop-up-frame-alist"
                               "same-window-buffer-names"
                               "same-window-regexps"
                               "debug-on-error"
                               "debug-ignored-errors"
                               "eval-expression-debug-on-error"
                               "debug-on-signal"
                               "debug-on-event"
                               "adaptive-fill-mode"
                               "adaptive-fill-regexp"
                               "adaptive-fill-first-line-regexp"
                               "adaptive-fill-function"
                               "glyphless-char-display-control"
                               "abbrev-all-caps"
                               "temp-buffer-show-function"
                               "temp-buffer-resize-mode"
                               "temp-buffer-max-height"
                               "temp-buffer-max-width"
                               "tab-stop-list"
                               "buffer-offer-save"
                               "temporary-file-directory"
                               "small-temporary-file-directory"
                               "undo-limit"
                               "undo-strong-limit"
                               "undo-outer-limit"
                               "undo-ask-before-discard"
                               "parse-sexp-ignore-comments"
                               "ctl-arrow"
                               "tab-width"
                               "defun-prompt-regexp"
                               "open-paren-in-column-0-is-defun-start"
                               "history-length"
                               "history-delete-duplicates"
                               "selection-coding-system"
                               "meta-prefix-char"
                               "garbage-collection-messages"
                               "gc-cons-threshold"
                               "gc-cons-percentage"
                               "resize-mini-windows"
                               "max-mini-window-height"
                               "window-min-height"
                               "window-min-width"
                               "split-window-keep-point"
                               ))

(defvar xah-elisp-variables nil "List elisp variables names (excluding user options).")
(setq xah-elisp-variables '(
                            "buffer-file-name"
                            "buffer-file-truename"
                            "buffer-file-number"
                            "list-buffers-directory"
                            "yank-undo-function"
                            "header-line-format"
                            "custom-known-themes"
                            "float-e"
                            "float-pi"
                            "unicode-category-table"
                            "char-script-table"
                            "char-width-table"
                            "printable-chars"
                            "post-gc-hook"
                            "memory-full"
                            "gcs-done"
                            "gc-elapsed"
                            "module-file-suffix"
                            "history-add-new-input"
                            "minibuffer-history"
                            "query-replace-history"
                            "file-name-history"
                            "buffer-name-history"
                            "regexp-history"
                            "extended-command-history"
                            "shell-command-history"
                            "read-expression-history"
                            "face-name-history"
                            "beginning-of-defun-function"
                            "end-of-defun-function"
                            "multibyte-syntax-as-symbol"
                            "comment-end-can-be-escaped"
                            "tabulated-list-format"
                            "tabulated-list-entries"
                            "tabulated-list-revert-hook"
                            "tabulated-list-printer"
                            "tabulated-list-sort-key"
                            "font-lock-keywords"
                            "font-lock-keywords-case-fold-search"
                            "unload-feature-special-hooks"
                            "kill-buffer-query-functions"
                            "kill-buffer-hook"
                            "buffer-save-without-query"
                            "load-path"
                            "desktop-save-buffer"
                            "desktop-buffer-mode-handlers"
                            "charset-list"
                            "temp-buffer-setup-hook"
                            "temp-buffer-show-hook"
                            "abbrev-start-location"
                            "abbrev-start-location-buffer"
                            "last-abbrev"
                            "last-abbrev-location"
                            "last-abbrev-text"
                            "abbrev-expand-function"
                            "process-adaptive-read-buffering"
                            "glyphless-char-display"
                            "debug-on-message"
                            "enable-multibyte-characters"
                            "char-property-alias-alist"
                            "default-text-properties"
                            "wrap-prefix"
                            "line-prefix"
                            "register-alist"
                            "cursor-type"
                            "before-make-frame-hook"
                            "after-make-frame-functions"
                            "frame-inherited-parameters"
                            "buffer-list-update-hook"
                            "overlay-arrow-string"
                            "overlay-arrow-position"
                            "overlay-arrow-variable-list"
                            "inhibit-message"
                            "before-init-hook"
                            "after-init-hook"
                            "emacs-startup-hook"
                            "window-setup-hook"
                            "user-init-file"
                            "user-emacs-directory"
                            "image-format-suffixes"
                            "mouse-position-function"
                            "tool-bar-map"
                            "auto-resize-tool-bars"
                            "auto-raise-tool-bar-buttons"
                            "tool-bar-button-margin"
                            "tool-bar-button-relief"
                            "tool-bar-border"
                            "text-property-default-nonsticky"
                            "completing-read-function"
                            "frame-title-format"
                            "icon-title-format"
                            "multiple-frames"
                            "blink-paren-function"
                            "menu-bar-final-items"
                            "menu-bar-update-hook"
                            "vertical-scroll-bar"
                            "horizontal-scroll-bar"
                            "scroll-bar-width"
                            "scroll-bar-height"
                            "cons-cells-consed"
                            "floats-consed"
                            "vector-cells-consed"
                            "symbols-consed"
                            "string-chars-consed"
                            "misc-objects-consed"
                            "intervals-consed"
                            "strings-consed"
                            "tty-setup-hook"
                            "fontification-functions"
                            "search-spaces-regexp"
                            "face-remapping-alist"
                            "other-window-scroll-buffer"
                            "system-key-alist"
                            "x-alt-keysym"
                            "x-meta-keysym"
                            "x-hyper-keysym"
                            "x-super-keysym"
                            "standard-output"
                            "print-quoted"
                            "print-escape-newlines"
                            "print-escape-nonascii"
                            "print-escape-multibyte"
                            "print-length"
                            "print-level"
                            "print-circle"
                            "print-gensym"
                            "print-continuous-numbering"
                            "print-number-table"
                            "float-output-format"
                            "after-load-functions"
                            "text-quoting-style"
                            "minibuffer-setup-hook"
                            "minibuffer-exit-hook"
                            "minibuffer-help-form"
                            "minibuffer-scroll-window"
                            "last-command"
                            "real-last-command"
                            "last-repeatable-command"
                            "this-command"
                            "this-original-command"
                            "last-nonmenu-event"
                            "last-command-event"
                            "last-event-frame"
                            "disable-point-adjustment"
                            "global-disable-point-adjustment"
                            "standard-translation-table-for-decode"
                            "standard-translation-table-for-encode"
                            "translation-table-for-input"
                            "minibuffer-allow-text-properties"
                            "minibuffer-local-map"
                            "minibuffer-local-ns-map"
                            "process-connection-type"
                            "inhibit-file-name-handlers"
                            "inhibit-file-name-operation"
                            "dir-locals-class-alist"
                            "dir-locals-directory-cache"
                            "enable-dir-local-variables"
                            "max-image-size"
                            "minor-mode-list"
                            "change-major-mode-after-body-hook"
                            "after-change-major-mode-hook"
                            "noninteractive"
                            "emacs-build-time"
                            "emacs-version"
                            "emacs-major-version"
                            "emacs-minor-version"
                            "font-lock-keywords-only"
                            "font-lock-syntax-table"
                            "font-lock-syntactic-face-function"
                            "process-file-side-effects"
                            "interprogram-paste-function"
                            "interprogram-cut-function"
                            "inhibit-local-variables-regexps"
                            "file-local-variables-alist"
                            "before-hack-local-variables-hook"
                            "hack-local-variables-hook"
                            "ignored-local-variables"
                            "window-point-insertion-type"
                            "font-lock-defaults"
                            "overwrite-mode"
                            "extra-keyboard-modifiers"
                            "keyboard-translate-table"
                            "executing-kbd-macro"
                            "defining-kbd-macro"
                            "last-kbd-macro"
                            "kbd-macro-termination-hook"
                            "emacs-save-session-functions"
                            "write-region-annotate-functions"
                            "write-region-post-annotation-function"
                            "after-insert-file-functions"
                            "features"
                            "buffer-backed-up"
                            "backup-enable-predicate"
                            "backup-inhibited"
                            "num-input-keys"
                            "values"
                            "buffer-file-coding-system"
                            "save-buffer-coding-system"
                            "last-coding-system-used"
                            "file-name-coding-system"
                            "inhibit-null-byte-detection"
                            "inhibit-iso-escape-detection"
                            "exec-directory"
                            "obarray"
                            "lexical-binding"
                            "buffer-display-table"
                            "standard-display-table"
                            "pre-redisplay-function"
                            "pre-redisplay-functions"
                            "x-pointer-shape"
                            "x-sensitive-text-pointer-shape"
                            "font-lock-mark-block-function"
                            "font-lock-extra-managed-props"
                            "font-lock-fontify-buffer-function"
                            "font-lock-unfontify-buffer-function"
                            "font-lock-fontify-region-function"
                            "font-lock-unfontify-region-function"
                            "font-lock-flush-function"
                            "font-lock-ensure-function"
                            "change-major-mode-hook"
                            "window-persistent-parameters"
                            "ignore-window-parameters"
                            "quit-flag"
                            "inhibit-quit"
                            "most-positive-fixnum"
                            "most-negative-fixnum"
                            "global-map"
                            "minor-mode-map-alist"
                            "minor-mode-overriding-map-alist"
                            "overriding-local-map"
                            "overriding-terminal-local-map"
                            "overriding-local-map-menu-flag"
                            "special-event-map"
                            "emulation-mode-map-alists"
                            "kill-ring"
                            "kill-ring-yank-pointer"
                            "display-buffer-overriding-action"
                            "buffer-undo-list"
                            "undo-auto-current-boundary-timer"
                            "undo-in-progress"
                            "pre-command-hook"
                            "post-command-hook"
                            "imenu-generic-expression"
                            "imenu-case-fold-search"
                            "imenu-syntax-alist"
                            "imenu-prev-index-position-function"
                            "imenu-extract-index-name-function"
                            "imenu-create-index-function"
                            "doc-directory"
                            "coding-system-for-read"
                            "coding-system-for-write"
                            "selective-display"
                            "electric-future-map"
                            "load-history"
                            "command-line-processed"
                            "command-switch-alist"
                            "command-line-args"
                            "command-line-args-left"
                            "command-line-functions"
                            "load-suffixes"
                            "load-file-rep-suffixes"
                            "inhibit-point-motion-hooks"
                            "show-help-function"
                            "command-history"
                            "face-font-rescale-alist"
                            "locale-coding-system"
                            "system-messages-locale"
                            "system-time-locale"
                            "menu-prompt-more-char"
                            "left-margin-width"
                            "right-margin-width"
                            "completion-ignore-case"
                            "completion-regexp-list"
                            "buffer-invisibility-spec"
                            "global-abbrev-table"
                            "local-abbrev-table"
                            "abbrev-minor-mode-table-alist"
                            "fundamental-mode-abbrev-table"
                            "text-mode-abbrev-table"
                            "lisp-mode-abbrev-table"
                            "revert-buffer-in-progress-p"
                            "revert-buffer-function"
                            "revert-buffer-insert-file-contents-function"
                            "before-revert-hook"
                            "after-revert-hook"
                            "buffer-stale-function"
                            "input-method-function"
                            "read-file-name-function"
                            "minibuffer-local-shell-command-map"
                            "glyph-table"
                            "help-map"
                            "help-form"
                            "prefix-help-command"
                            "data-directory"
                            "byte-boolean-vars"
                            "auto-window-vscroll"
                            "focus-in-hook"
                            "focus-out-hook"
                            "query-replace-map"
                            "multi-query-replace-map"
                            "replace-search-function"
                            "replace-re-search-function"
                            "warning-levels"
                            "warning-prefix-function"
                            "warning-series"
                            "warning-fill-prefix"
                            "warning-type-format"
                            "split-string-default-separators"
                            "before-change-functions"
                            "after-change-functions"
                            "first-change-hook"
                            "inhibit-modification-hooks"
                            "buffer-display-count"
                            "buffer-display-time"
                            "command-error-function"
                            "filter-buffer-substring-function"
                            "filter-buffer-substring-functions"
                            "buffer-substring-filters"
                            "ascii-case-table"
                            "disabled-command-function"
                            "format-alist"
                            "buffer-file-format"
                            "buffer-auto-save-file-format"
                            "find-file-not-found-functions"
                            "find-file-literally"
                            "delete-terminal-functions"
                            "num-nonmacro-input-events"
                            "debugger"
                            "debug-on-next-call"
                            "command-debug-status"
                            "insert-directory-program"
                            "font-lock-extend-after-change-region-function"
                            "cursor-in-echo-area"
                            "echo-area-clear-hook"
                            "message-truncate-lines"
                            "fringes-outside-margins"
                            "left-fringe-width"
                            "right-fringe-width"
                            "tooltip-frame-parameters"
                            "tooltip-functions"
                            "byte-compile-dynamic"
                            "standard-input"
                            "read-circle"
                            "image-cache-eviction-delay"
                            "system-configuration"
                            "system-type"
                            "process-environment"
                            "initial-environment"
                            "path-separator"
                            "invocation-name"
                            "invocation-directory"
                            "installation-directory"
                            "tty-erase-char"
                            "buffer-access-fontify-functions"
                            "buffer-access-fontified-property"
                            "input-decode-map"
                            "local-function-key-map"
                            "key-translation-map"
                            "interpreter-mode-alist"
                            "magic-mode-alist"
                            "magic-fallback-mode-alist"
                            "auto-mode-alist"
                            "process-coding-system-alist"
                            "network-coding-system-alist"
                            "default-process-coding-system"
                            "unread-command-events"
                            "last-input-event"
                            "buffer-auto-save-file-name"
                            "auto-save-hook"
                            "buffer-saved-size"
                            "auto-save-list-file-name"
                            "inhibit-field-text-motion"
                            "find-word-boundary-function-table"
                            "default-minibuffer-frame"
                            "init-file-user"
                            "play-sound-functions"
                            "customize-package-emacs-version-alist"
                            "delayed-warnings-list"
                            "delayed-warnings-hook"
                            "fringe-cursor-alist"
                            "indent-region-function"
                            "fringe-indicator-alist"
                            "dynamic-library-alist"
                            "kill-emacs-hook"
                            "kill-emacs-query-functions"
                            "abbrev-table-name-list"
                            "buffer-read-only"
                            "inhibit-read-only"
                            "window-size-fixed"
                            "load-in-progress"
                            "load-file-name"
                            "load-read-function"
                            "image-types"
                            "pure-bytes-used"
                            "purify-flag"
                            "bidi-display-reordering"
                            "bidi-paragraph-direction"
                            "write-file-functions"
                            "write-contents-functions"
                            "window-scroll-functions"
                            "window-size-change-functions"
                            "window-configuration-change-hook"
                            "window-system"
                            "initial-window-system"
                            "font-lock-multiline"
                            "completion-styles-alist"
                            "completion-extra-properties"
                            "current-input-method"
                            "input-method-alist"
                            "suspend-hook"
                            "suspend-resume-hook"
                            "default-directory"
                            "current-prefix-arg"
                            "prefix-arg"
                            "last-prefix-arg"
                            "fill-paragraph-function"
                            "fill-forward-paragraph-function"
                            "use-hard-newlines"
                            "minibuffer-completion-table"
                            "minibuffer-completion-predicate"
                            "minibuffer-completion-confirm"
                            "minibuffer-confirm-exit-commands"
                            "minibuffer-local-completion-map"
                            "minibuffer-local-must-match-map"
                            "minibuffer-local-filename-completion-map"
                            "auto-fill-function"
                            "normal-auto-fill-function"
                            "auto-fill-chars"
                            "generate-autoload-cookie"
                            "generated-autoload-file"
                            "x-resource-class"
                            "x-resource-name"
                            "inhibit-x-resources"
                            "indent-line-function"
                            "abbrevs-changed"
                            "mode-line-mule-info"
                            "mode-line-modified"
                            "mode-line-frame-identification"
                            "mode-line-buffer-identification"
                            "mode-line-position"
                            "vc-mode"
                            "mode-line-modes"
                            "mode-line-remote"
                            "mode-line-client"
                            "mode-name"
                            "mode-line-process"
                            "mode-line-front-space"
                            "mode-line-end-spaces"
                            "mode-line-misc-info"
                            "minor-mode-alist"
                            "global-mode-string"
                            "deactivate-mark"
                            "mark-active"
                            "activate-mark-hook"
                            "deactivate-mark-hook"
                            "mark-ring"
                            "parse-sexp-lookup-properties"
                            "syntax-propertize-function"
                            "syntax-propertize-extend-region-functions"
                            "completion-at-point-functions"
                            ))

(defvar xah-elisp-all-symbols nil "List of all elisp symbols.")
(setq xah-elisp-all-symbols nil)

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

;; java

;; [[file:~/.emacs.d/config/emacs-config.org::*java][java:1]]
(font-lock-add-keywords
 'java-mode
 '(
   ("[a-z]<[a-zA-Z]+>"  . 'font-lock-type-face)
   ))
(add-hook 'java-mode-hook 'weiss-java-face)

(defun weiss-java-face ()
  (interactive)
  (face-remap-add-relative
   'font-lock-function-name-face '((:foreground "#383a42" :box '(:line-width 1))) font-lock-function-name-face)
  (face-remap-add-relative
   'font-lock-variable-name-face '((:foreground "#383a42" :underline t)) font-lock-variable-name-face)
  (face-remap-add-relative
   'c-annotation-face '((:foreground "#A9AAAE")))
  (face-remap-add-relative
   'font-lock-type-face '((:foreground "#737C79" :background "#F7EBFC")))
  )
;; java:1 ends here

;; org

;; [[file:~/.emacs.d/config/emacs-config.org::*org][org:1]]
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
;; org:1 ends here

;; python

;; [[file:~/.emacs.d/config/emacs-config.org::*python][python:1]]
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

;; misc

;; [[file:~/.emacs.d/config/emacs-config.org::*misc][misc:1]]
(set-face-attribute 'cursor '((nil (:background weiss/cursor-color))))
(use-package emojify 
  :diminish
  ;; :hook (after-init . global-emojify-mode)
  )
;; misc:1 ends here

;; ryo-bind-keys
;; Ryo-modal-mode can not bind void functions, so we bind keys at last.

;; [[file:~/.emacs.d/config/emacs-config.org::*ryo-bind-keys][ryo-bind-keys:1]]
(ryo-modal-keys
 (:mc-all t)
 ("RET" newline :first '(deactivate-mark) :mode 'prog-mode)
 ("'"  xah-cycle-hyphen-underscore-space)
 (","  xah-backward-left-bracket)
 ("-"  weiss-switch-to-same-side-frame)
 ("="  ryo-modal-repeat)
 ("."  xah-forward-right-bracket)
 (";"  rotate-text)
 ("/"  xah-goto-matching-bracket)
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
 ("7"  weiss-select-sexp :then '(weiss-select-mode-turn-on))
 ("8"  xah-select-text-in-quote)
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

(ryo-modal-keys
 ("SPC" (
         (","  (
                ("e"  weiss-excute-buffer)
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
                ("k" save-buffers-kill-terminal)
                ("p" xah-copy-file-path)
                ("b" ignore
                 :name "copy whole buffer"
                 :then ((lambda () (interactive) (kill-new (buffer-string)))))
                ))
         ("d" (
               ;; ("a"  weiss-custom-daily-agenda)
               ("b"  weiss-save-current-content)
               ("c"  calendar)
               ("d"  weiss-switch-and-bookmarks-search)
               ("j" yasdcv-translate-input)
               ("l"  list-buffers)
               ("m"  magit-status)
               ("n"  xah-new-empty-buffer)
               ("o"  xah-open-file-at-cursor)
               ("s" yasdcv-translate-at-point)
               ("t"  telega)
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
               ("h"  global-hl-line-mode)
               ;; ("l"  visual-line-mode)             ;wrap-line
               ("l"  highlight-symbol)             ;wrap-line
               ("m"  shell-command)
               ("n"  display-line-numbers-mode)
               ("p"  sql-postgres)
               ("r"  weiss-dired-toggle-read-only :exit t)
               ("s"  sudo-edit)
               ("w"  toggle-word-wrap)
               ))
         ("m"  dired-jump)
         ("n"  end-of-buffer)
         ("o" (
               ("n" mc/mark-more-like-this-extended)
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
               ("n"  make-frame-command)
               ("t"  weiss-test)
               ("l"  xref-pop-marker-stack)
               ("y"  winner-undo)                  ;windows setting
               ("r"  winner-redo)
               ("k"  delete-frame)
               ("o"  org-babel-tangle-jump-to-org)
               ))
         ;; ("x"  xah-cut-all-or-region)
         ;; ("y"  xah-search-current-word)
         )))
;; ryo-bind-keys:1 ends here

;; tramp

;; [[file:~/.emacs.d/config/emacs-config.org::*tramp][tramp:1]]
;; Tramp ivy interface
(setq remote-file-name-inhibit-cache nil)

(use-package sudo-edit)

(use-package counsel-tramp
  :bind (:map counsel-mode-map
              ("C-c c T" . counsel-tramp)))

(use-package docker-tramp)
;; tramp:1 ends here

;; recentf

;; [[file:~/.emacs.d/config/emacs-config.org::*recentf][recentf:1]]
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
  (setq weiss-reduce-recentf-file-path-alist
        '(
          ("🅲🅻🅿" . "Compiler and Language-Processing Tools")
          ("🆂🅲" . "scientififc computing")
          ("🆅" . "Documents/Vorlesungen")
          ("🅥" . "Nutstore Files/Vorlesungen")
          ("🅹" . "src/main/java")
          ("🅙🅣" . "src/test/java")
          ))

  (defun weiss-reduce-file-path (filename &optional r)
    "replace long file paths with symbol"
    (interactive)
    (let ((search-str)
          (replace-str))
      (dolist (x weiss-reduce-recentf-file-path-alist)
        (if r
            (setq search-str (car x) 
                  replace-str (cdr x))
          (setq search-str (cdr x) 
                replace-str (car x)))      
        (setq filename (replace-regexp-in-string search-str replace-str filename t))
        )
      )  
    filename
    )

  (add-to-list 'recentf-filename-handlers 'abbreviate-file-name)
  (load (weiss--get-config-file-path "recentf"))
  (setq recentf-save-file (weiss--get-config-file-path "recentf"))
  :config
  (defun recentf-cleanup ()
    "Cleanup the recent list.
That is, remove duplicates, non-kept, and excluded files."
    (interactive)
    (message "Cleaning up the recentf list...")
    (let ((n 0)
          (ht (make-hash-table
               :size recentf-max-saved-items
               :test 'equal))
          newlist key)
      (dolist (f recentf-list)
        (setq f (weiss-reduce-file-path (recentf-expand-file-name f) t)
              key (if recentf-case-fold-search (downcase f) f))
        (if (and (recentf-include-p f)
                 (recentf-keep-p f)
                 (not (gethash key ht)))
            (progn
              (push (weiss-reduce-file-path f) newlist)
              (puthash key t ht))
          (setq n (1+ n))
          (message "File %s removed from the recentf list" f)))
      (message "Cleaning up the recentf list...done (%d removed)" n)
      (setq recentf-list (nreverse newlist))))
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
                     ))
  )
(add-to-list 'recentf-filename-handlers 'weiss-reduce-file-path)
(load (weiss--get-config-file-path "recentf"))
;; recentf:1 ends here

;; misc

;; [[file:~/.emacs.d/config/emacs-config.org::*misc][misc:1]]
(bookmark-load "/home/weiss/.emacs.d/bookmarks" t t t)
(setq bookmark-save-flag 1)

(ignore-errors (savehist-mode 1))
(save-place-mode 1)

(dbus-init-bus :session)   ; for EAF DUMP

(setq weiss-left-top-window (selected-frame))
(setq weiss-right-top-window (make-frame-command))
(select-frame-set-input-focus weiss-left-top-window)

(setq gc-cons-threshold (* (expt 1024 2) 32)
      gc-cons-percentage 0.5)
;; misc:1 ends here
