;; init-company.el --- Initialize company configurations.	-*- lexical-binding: t -*-
;; https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-company.el
;;; Code:

(use-package company
  :diminish
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :commands company-abort
  :bind (("M-/" . company-complete)
         ("<backtab>" . company-yasnippet)
         :map company-active-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("<tab>" . company-complete-common-or-cycle)
         ("<backtab>" . my-company-yasnippet)
         ;; ("C-c C-y" . my-company-yasnippet)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))
  :hook (after-init . global-company-mode)
  :init
  (defun my-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-abort)
    (call-interactively 'company-yasnippet))
  :config
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 12
        company-idle-delay 0
        company-echo-delay (if (display-graphic-p) nil 0)
        company-minimum-prefix-length 2
        company-require-match nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode shell-mode)
        company-backends '(company-capf)
        company-frontends '(company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend))

  ;; Better sorting and filtering
  (use-package company-prescient
    :init (company-prescient-mode 1))

  ;; Icons and quickhelp
  (use-package company-box
    :diminish
    :hook (company-mode . company-box-mode)
    :init (setq company-box-backends-colors nil
                company-box-show-single-candidate t
                company-box-max-candidates 50
                company-box-doc-delay 2)
    :config
    (with-no-warnings
      ;; Highlight `company-common'
      (defun my-company-box--make-line (candidate)
        (-let* (((candidate annotation len-c len-a backend) candidate)
                (color (company-box--get-color backend))
                ((c-color a-color i-color s-color) (company-box--resolve-colors color))
                (icon-string (and company-box--with-icons-p (company-box--add-icon candidate)))
                (candidate-string (concat (propertize (or company-common "") 'face 'company-tooltip-common)
                                          (substring (propertize candidate 'face 'company-box-candidate)
                                                     (length company-common) nil)))
                (align-string (when annotation
                                (concat " " (and company-tooltip-align-annotations
                                                 (propertize " " 'display `(space :align-to (- right-fringe ,(or len-a 0) 1)))))))
                (space company-box--space)
                (icon-p company-box-enable-icon)
                (annotation-string (and annotation (propertize annotation 'face 'company-box-annotation)))
                (line (concat (unless (or (and (= space 2) icon-p) (= space 0))
                                (propertize " " 'display `(space :width ,(if (or (= space 1) (not icon-p)) 1 0.75))))
                              (company-box--apply-color icon-string i-color)
                              (company-box--apply-color candidate-string c-color)
                              align-string
                              (company-box--apply-color annotation-string a-color)))
                (len (length line)))
          (add-text-properties 0 len (list 'company-box--len (+ len-c len-a)
                                           'company-box--color s-color)
                               line)
          line))
      (advice-add #'company-box--make-line :override #'my-company-box--make-line)

      ;; Prettify icons
      (defun my-company-box-icons--elisp (candidate)
        (when (derived-mode-p 'emacs-lisp-mode)
          (let ((sym (intern candidate)))
            (cond ((fboundp sym) 'Function)
                  ((featurep sym) 'Module)
                  ((facep sym) 'Color)
                  ((boundp sym) 'Variable)
                  ((symbolp sym) 'Text)
                  (t . nil)))))
      (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp))

    (when (and (display-graphic-p)
               (require 'all-the-icons nil t))
      (declare-function all-the-icons-faicon 'all-the-icons)
      (declare-function all-the-icons-material 'all-the-icons)
      (declare-function all-the-icons-octicon 'all-the-icons)
      (setq company-box-icons-all-the-icons
            `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.85 :v-adjust -0.2))
              (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.05))
              (Method . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Function . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Constructor . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Field . ,(all-the-icons-octicon "tag" :height 0.8 :v-adjust 0 :face 'all-the-icons-lblue))
              (Variable . ,(all-the-icons-octicon "tag" :height 0.8 :v-adjust 0 :face 'all-the-icons-lblue))
              (Class . ,(all-the-icons-material "settings_input_component" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Interface . ,(all-the-icons-material "share" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Module . ,(all-the-icons-material "view_module" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.05))
              (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.85 :v-adjust -0.2))
              (Value . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Enum . ,(all-the-icons-material "storage" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.85 :v-adjust -0.2))
              (Snippet . ,(all-the-icons-material "format_align_center" :height 0.85 :v-adjust -0.2))
              (Color . ,(all-the-icons-material "palette" :height 0.85 :v-adjust -0.2))
              (File . ,(all-the-icons-faicon "file-o" :height 0.85 :v-adjust -0.05))
              (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.85 :v-adjust -0.2))
              (Folder . ,(all-the-icons-faicon "folder-open" :height 0.85 :v-adjust -0.05))
              (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Constant . ,(all-the-icons-faicon "square-o" :height 0.85 :v-adjust -0.05))
              (Struct . ,(all-the-icons-material "settings_input_component" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Event . ,(all-the-icons-octicon "zap" :height 0.8 :v-adjust 0 :face 'all-the-icons-orange))
              (Operator . ,(all-the-icons-material "control_point" :height 0.85 :v-adjust -0.2))
              (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.05))
              (Template . ,(all-the-icons-material "format_align_left" :height 0.85 :v-adjust -0.2)))
            company-box-icons-alist 'company-box-icons-all-the-icons)))

  ;; Popup documentation for completion candidates
  (use-package company-quickhelp
    :defines company-quickhelp-delay
    :bind (:map company-active-map
                ([remap company-show-doc-buffer] . company-quickhelp-manual-begin))
    :hook (global-company-mode . company-quickhelp-mode)
    :init (setq company-quickhelp-delay 0.5)))

;;; LSP

(use-package lsp-mode
  :diminish
  :hook (prog-mode . (lambda ()
                       (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                         (lsp-deferred))))
  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point))
  :init
  (setq
   ;; lsp-auto-guess-root t        ; Detect project root
   lsp-keep-workspace-alive nil ; Auto-kill LSP server
   lsp-prefer-flymake nil       ; Use lsp-ui and flycheck
   flymake-fringe-indicator-position 'right-fringe)
  :config
  (setq lsp-signature-auto-activate nil) ; disable doc in minibuffer

  ;; Configure LSP clients
  (use-package lsp-clients
    :straight nil
    :functions (lsp-format-buffer lsp-organize-imports)
    :hook (go-mode . (lambda ()
                       "Format and add/delete imports."
                       (add-hook 'before-save-hook #'lsp-format-buffer t t)
                       (add-hook 'before-save-hook #'lsp-organize-imports t t)))
    :init
    (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
    (unless (executable-find "rls")
      (setq lsp-rust-rls-server-command '("rustup" "run" "stable" "rls"))))

  (when (and lsp-auto-configure lsp-auto-require-clients)
    (require 'lsp-clients))
  
  (use-package lsp-ui
    :custom-face
    (lsp-ui-doc-background ((t (:background ,(face-background 'tooltip)))))
    (lsp-ui-sideline-code-action ((t (:inherit warning))))
    :bind (("C-c u" . lsp-ui-imenu)
           :map lsp-ui-mode-map
           ("M-<f6>" . lsp-ui-hydra/body)
           ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
           ([remap xref-find-references] . lsp-ui-peek-find-references))
    :init (setq lsp-ui-doc-enable nil
                lsp-ui-doc-use-webkit nil
                lsp-ui-doc-delay 2
                lsp-ui-doc-include-signature t
                lsp-ui-doc-position 'at-point
                lsp-ui-doc-border (face-foreground 'default)
                lsp-eldoc-enable-hover nil ; Disable eldoc displays in minibuffer

                lsp-ui-imenu-enable nil
                lsp-ui-imenu-colors `(,(face-foreground 'font-lock-keyword-face)
                                      ,(face-foreground 'font-lock-string-face)
                                      ,(face-foreground 'font-lock-constant-face)
                                      ,(face-foreground 'font-lock-variable-name-face))

                lsp-ui-sideline-enable t
                lsp-ui-sideline-show-hover nil
                lsp-ui-sideline-show-diagnostics nil
                lsp-ui-sideline-ignore-duplicate t)
    :config
    (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

    ;; `C-g'to close doc
    (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

    ;; Reset `lsp-ui-doc-background' after loading theme
    (add-hook 'after-load-theme-hook
              (lambda ()
                (setq lsp-ui-doc-border (face-foreground 'default))
                (set-face-background 'lsp-ui-doc-background
                                     (face-background 'tooltip))))

    ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
    ;; @see https://github.com/emacs-lsp/lsp-ui/issues/243
    (defun my-lsp-ui-imenu-hide-mode-line ()
      "Hide the mode-line in lsp-ui-imenu."
      (setq mode-line-format nil))
    (advice-add #'lsp-ui-imenu :after #'my-lsp-ui-imenu-hide-mode-line))

  ;; Completion
  (use-package company-lsp
    :init (setq company-lsp-cache-candidates 'auto))

  ;; Origami integration
  (use-package lsp-origami
    :after lsp-mode
    :hook (origami-mode . lsp-origami-mode))

  ;; Microsoft python-language-server support
  (use-package lsp-python-ms
    :hook (python-mode . (lambda () (require 'lsp-python-ms)))
    :init
    (when (executable-find "python3")
      (setq lsp-python-ms-python-executable-cmd "python3")))

  ;; C/C++/Objective-C support
  (use-package ccls
    :defines projectile-project-root-files-top-down-recurring
    :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls)))
    :config
    (with-eval-after-load 'projectile
      (setq projectile-project-root-files-top-down-recurring
            (append '("compile_commands.json"
                      ".ccls")
                    projectile-project-root-files-top-down-recurring))))

  (use-package lsp-fsharp
    ;; :disabled                           
    :straight (lsp-fsharp
               :type git
               :host github
               :repo "emacs-lsp/lsp-mode")
    :hook (fsharp-mode . (lambda () (require 'lsp-fsharp)))
    :init
    (setq lsp-fsharp-server-install-dir "~/.emacs.d/lsp-fsharp")
    )

  ;; Julia support
  (use-package lsp-julia
    :hook (julia-mode . (lambda () (require 'lsp-julia))))

  ;; Java support
  (use-package lsp-java
    :hook (java-mode . (lambda () (require 'lsp-java))))
  )

;; lsp blacklist
;; (setf (lsp-session-folders-blacklist (lsp-session)) nil)
;; (lsp--persist-session (lsp-session))

;; tabnie
(use-package company-tabnine
  :disabled
  )

(use-package yasnippet
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode)
  :config (use-package yasnippet-snippets))


(provide 'weiss_company)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; weiss_company.el ends here

