;; -*- lexical-binding: t -*-
;; lsp-mode

;; [[file:~/.emacs.d/config/emacs-config.org::*lsp-mode][lsp-mode:1]]
(use-package lsp-mode
  ;; :disabled
  :diminish
  :commands lsp
  :hook (
         ;; (python-mode . lsp-deferred)
         (java-mode . lsp-deferred)
         ;; (c++-mode . lsp-deferred)
         ;; (sql-mode . lsp-deferred)
         )
  :bind (:map lsp-mode-map
              ("M-p" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
  :defines (lsp-clients-python-library-directories lsp-rust-rls-server-command)
  :init
  (setq
   lsp-response-timeout 100
   lsp-completion-enable-additional-text-edit t
   lsp-prefer-flymake nil
   lsp-diagnostic-package :flycheck
   lsp-auto-guess-root t        ; Detect project root
   lsp-keep-workspace-alive nil ; Auto-kill LSP server
   lsp-enable-indentation t
   flymake-fringe-indicator-position 'right-fringe
   ;; lsp-auto-configure nil
   lsp-ui-doc-enable nil
   lsp-enable-symbol-highlighting nil
   lsp-flycheck-live-reporting nil
   lsp-enable-links nil                 ;; no clickable links
   lsp-enable-folding nil               ;; use `hideshow' instead
   lsp-enable-snippet nil               ;; no snippet
   lsp-enable-file-watchers nil         ;; turn off for better performance
   lsp-enable-text-document-color nil   ;; as above
   lsp-enable-semantic-highlighting nil ;; as above
   lsp-enable-symbol-highlighting nil   ;; as above
   lsp-enable-on-type-formatting nil    ;; disable formatting on the fly
   lsp-modeline-code-actions-enable nil ;; keep modeline clean
   lsp-modeline-diagnostics-enable nil  ;; as above
   lsp-idle-delay 0.5                   ;; lazy refresh
   lsp-log-io nil                       ;; enable log only for debug
   ;; lsp-diagnostics-provider :flycheck   ;; prefer `flycheck'
   lsp-lens-enable t                    ;; enable lens
   lsp-auto-guess-root t                ;; auto guess root
   lsp-keep-workspace-alive nil         ;; auto kill lsp server
   lsp-eldoc-enable-hover t           ;; disable eldoc hover
   lsp-signature-auto-activate t        ;; show function signature
   lsp-signature-doc-lines 2            ;; but dont take up more lines
   )
  ;; enable log only for debug
  (setq lsp-log-io nil)

  ;; use `evil-matchit' instead
  (setq lsp-enable-folding nil)

  ;; no real time syntax check
  ;; (setq lsp-diagnostic-package nil)

  ;; handle yasnippet by myself
  (setq lsp-enable-snippet nil)

  ;; use `company-ctags' only.
  ;; Please note `company-lsp' is automatically enabled if installed
  (setq lsp-enable-completion-at-point nil)

  ;; use ffip instead
  ;; (setq lsp-enable-links nil)

  ;; auto restart lsp
  (setq lsp-restart 'auto-restart)

  ;; don't ping LSP lanaguage server too frequently
  ;; (defvar lsp-on-touch-time 0)
  ;; (defadvice lsp-on-change (around lsp-on-change-hack activate)
  ;;   ;; don't run `lsp-on-change' too frequently
  ;;   (when (> (- (float-time (current-time))
  ;;               lsp-on-touch-time) 30) ;; 30 seconds
  ;;     (setq lsp-on-touch-time (float-time (current-time)))
  ;;     ad-do-it))
  ;; :config
  (setq lsp-signature-auto-activate nil) ; disable doc in minibuffer

  ;; For `lsp-clients'
  (require 'lsp-clients)
  (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
  (unless (executable-find "rls")
    (setq lsp-rust-rls-server-command '("rustup" "run" "stable" "rls")))

  ;; Completion
  (use-package company-lsp
    :init (setq company-lsp-cache-candidates 'auto)
    :commands company-lsp)
  ;; (lsp-ui-flycheck-enable)

  (use-package lsp-ui
    ;; :disabled
    :commands lsp-ui-mode
    :bind (:map lsp-mode-map
                ("M-d" . 'lsp-ui-doc-show))
    :init (setq lsp-ui-doc-enable nil
                lsp-ui-doc-use-webkit nil
                lsp-ui-doc-delay 0.2
                lsp-ui-doc-include-signature t
                lsp-ui-doc-position 'at-point
                lsp-ui-doc-border (face-foreground 'default)
                lsp-eldoc-enable-hover nil ; Disable eldoc displays in minibuffer

                lsp-ui-sideline-enable t
                lsp-ui-sideline-show-hover nil
                lsp-ui-sideline-show-diagnostics nil
                lsp-ui-sideline-update-mode 'line
                lsp-ui-sideline-delay 1
                lsp-ui-sideline-show-code-actions nil
                lsp-ui-sideline-ignore-duplicate nil
                )
    )


  ;; ;; Origami integration
  ;; (use-package lsp-origami
  ;;   :after lsp-mode
  ;;   :hook (origami-mode . lsp-origami-mode))

  ;; Microsoft python-language-server support




  ;; (use-package lsp-pyright
  ;;   :quelpa ( lsp-pyright
  ;;             :fetcher github 
  ;;             :repo emacs-lsp/lsp-pyright)
  ;;   :hook (python-mode . (lambda ()
  ;;                          (require 'lsp-pyright)
  ;;                          (setq flycheck-checker 'python-pylint
  ;;                                python-mode-skeleton-abbrev-table nil
  ;;                                ;; python-skeleton-autoinsert t
  ;;                                )
  ;;                          (face-remap-add-relative
  ;;                           'font-lock-variable-name-face
  ;;                           '((:foreground "#383a42" :underline t))
  ;;                           font-lock-variable-name-face)
  ;;                          (face-remap-add-relative
  ;;                           'default
  ;;                           '((:weight normal))
  ;;                           )
  ;;                          (lsp-deferred)
  ;;                          ))
  ;;   )




  ;; lsp-java-generate-to-string - Generate toString method.
  ;; lsp-java-generate-equals-and-hash-code - Generate equals and hashCode methods.
  ;; lsp-java-generate-overrides - Generate method overrides
  ;; lsp-java-generate-getters-and-setters - Generate getters and setters.

  )

(use-package nox
  ;; :disabled
  :quelpa (nox
           :fetcher github
           :repo manateelazycat/nox)
  ;; :ensure nil
  ;; :load-path "/home/weiss/.emacs.d/local-package/nox/"
  :init
  (defvar is-nox-activate-p nil)
  (advice-add 'nox-ensure :after (lambda () (interactive) (make-local-variable 'is-nox-activate-p) (setq is-nox-activate-p t)))
  (setq nox-python-server "mspyls")
  ;; (setq nox-python-server "pyls")
  (setq nox-optimization-p nil)

  :hook (
         (python-mode . nox-ensure)
         (go-mode . nox-ensure)
         (nox-managed-mode-hook . ryo-modal-restart)
         )
  :bind (:map nox-mode-map
              ("M-d" . nox-show-doc)
              )
  :ryo
  (:mode 'nox-mode)
  ("t" nox-rename)
  ("u" nox-show-doc)  
  :config
  (setq nox-doc-tooltip-font-size "12"
        nox-doc-tooltip-border-width 3)
  ;; (setq nox-python-server 'pyls)
  )


(use-package eglot
  :disabled
  :hook ((python-mode . eglot-ensure)
         (java-mode . eglot-ensure)
         )
  )

(provide 'weiss-lsp)
;; lsp-mode:1 ends here

;; start, bind

;; [[file:~/.emacs.d/config/emacs-config.org::*start, bind][start, bind:1]]
(use-package lsp-mode
  ;; :disabled
  :diminish
  :commands lsp
  :hook (
         ;; (python-mode . lsp-deferred)
         (java-mode . lsp-deferred)
         ;; (c++-mode . lsp-deferred)
         ;; (sql-mode . lsp-deferred)
         )
  :bind (:map lsp-mode-map
              ("M-p" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
  :defines (lsp-clients-python-library-directories lsp-rust-rls-server-command)
;; start, bind:1 ends here

;; init

;; [[file:~/.emacs.d/config/emacs-config.org::*init][init:1]]
:init
;; init:1 ends here

;; variable


;; [[file:~/.emacs.d/config/emacs-config.org::*variable][variable:1]]
(setq
 lsp-log-io nil                       ;; enable log only for debug
 lsp-response-timeout 100
 lsp-completion-enable-additional-text-edit t
 lsp-prefer-flymake nil
 lsp-diagnostic-package :flycheck
 lsp-auto-guess-root t        ; Detect project root
 lsp-keep-workspace-alive nil ; Auto-kill LSP server
 lsp-enable-indentation t
 flymake-fringe-indicator-position 'right-fringe
 ;; lsp-auto-configure nil
 lsp-ui-doc-enable nil
 lsp-enable-symbol-highlighting nil
 lsp-flycheck-live-reporting nil
 lsp-enable-links nil                 ;; no clickable links
 lsp-enable-folding nil               ;; use `hideshow' instead
 lsp-enable-snippet nil               ;; no snippet
 lsp-enable-file-watchers nil         ;; turn off for better performance
 lsp-enable-text-document-color nil   ;; as above
 lsp-enable-semantic-highlighting nil ;; as above
 lsp-enable-symbol-highlighting nil   ;; as above
 lsp-enable-on-type-formatting nil    ;; disable formatting on the fly
 lsp-modeline-code-actions-enable nil ;; keep modeline clean
 lsp-modeline-diagnostics-enable nil  ;; as above
 lsp-idle-delay 0.5                   ;; lazy refresh
 ;; lsp-diagnostics-provider :flycheck   ;; prefer `flycheck'
 lsp-lens-enable t                    ;; enable lens
 lsp-auto-guess-root t                ;; auto guess root
 lsp-keep-workspace-alive nil         ;; auto kill lsp server
 lsp-eldoc-enable-hover t           ;; disable eldoc hover
 lsp-signature-auto-activate t        ;; show function signature
 lsp-signature-doc-lines 2            ;; but dont take up more lines
 lsp-restart 'auto-restart  ;; auto restart lsp
 lsp-enable-completion-at-point nil    ;; Please note `company-lsp' is automatically enabled if installed
 )

;; don't ping LSP lanaguage server too frequently
(defvar lsp-on-touch-time 0)
(defadvice lsp-on-change (around lsp-on-change-hack activate)
  ;; don't run `lsp-on-change' too frequently
  (when (> (- (float-time (current-time))
              lsp-on-touch-time) 30) ;; 30 seconds
    (setq lsp-on-touch-time (float-time (current-time)))
    ad-do-it))
;; variable:1 ends here

;; lsp-clients, company-lsp

;; [[file:~/.emacs.d/config/emacs-config.org::*lsp-clients, company-lsp][lsp-clients, company-lsp:1]]
;; For `lsp-clients'
(require 'lsp-clients)
(setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
(unless (executable-find "rls")
  (setq lsp-rust-rls-server-command '("rustup" "run" "stable" "rls")))

;; Completion
(use-package company-lsp
  :init (setq company-lsp-cache-candidates 'auto)
  :commands company-lsp)
;; lsp-clients, company-lsp:1 ends here

;; lsp-ui

;; [[file:~/.emacs.d/config/emacs-config.org::*lsp-ui][lsp-ui:1]]
(use-package lsp-ui
    ;; :disabled
    :commands lsp-ui-mode
    :bind (:map lsp-mode-map
                ("M-d" . 'lsp-ui-doc-show))
    :init (setq lsp-ui-doc-enable nil
                lsp-ui-doc-use-webkit nil
                lsp-ui-doc-delay 0.2
                lsp-ui-doc-include-signature t
                lsp-ui-doc-position 'at-point
                lsp-ui-doc-border (face-foreground 'default)
                lsp-eldoc-enable-hover nil ; Disable eldoc displays in minibuffer

                lsp-ui-sideline-enable t
                lsp-ui-sideline-show-hover nil
                lsp-ui-sideline-show-diagnostics nil
                lsp-ui-sideline-update-mode 'line
                lsp-ui-sideline-delay 1
                lsp-ui-sideline-show-code-actions nil
                lsp-ui-sideline-ignore-duplicate nil
                )
    )
;; lsp-ui:1 ends here

;; lsp-java


;; [[file:~/.emacs.d/config/emacs-config.org::*lsp-java][lsp-java:1]]
(use-package lsp-java
    ;; :disabled
    :hook (java-mode . (lambda ()
                         (require 'lsp-java)
                         (make-local-variable 'lsp-diagnostic-package)
                         (setq lsp-diagnostic-package :flycheck)
                         ))
    :init
    ;; (setq lsp-java-jdt-download-url  "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")
    (setq
     lsp-java-format-enabled nil
     lsp-java-format-comments-enabled nil
     lsp-java-format-settings-profile "GoogleStyle"
     ;; java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
     lsp-java-format-settings-url "/home/weiss/.emacs.d/local-package/eclipse-java-google-style.xml"
     )
    :ryo
    (:mode 'java-mode)
    ("u" lsp-rename)
    ("t" (
          ("t" lsp-java-generate-to-string)
          ("e" lsp-java-generate-equals-and-hash-code)
          ("o" lsp-java-generate-overrides)
          ("g" lsp-java-generate-getters-and-setters)             
          ))    
    )
;; lsp-java:1 ends here

;; out of use


;; [[file:~/.emacs.d/config/emacs-config.org::*out of use][out of use:1]]
(use-package lsp-mssql
  :disabled
  :quelpa (lsp-mssql
           :fetcher github
           :repo "emacs-lsp/lsp-mssql"
           )
  (setq lsp-mssql-connections
        [(:server "localhost"
                  :database "uni"
                  :user "weiss"
                  )])
  )

(use-package dap-mode
  :disabled
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package lsp-pyright
  :disabled
  :quelpa ( lsp-pyright
            :fetcher github 
            :repo emacs-lsp/lsp-pyright)
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         ;; (setq flycheck-checker 'python-pylint
                         ;;       python-mode-skeleton-abbrev-table nil
                         ;;       ;; python-skeleton-autoinsert t
                         ;;       )
                         ;; (face-remap-add-relative
                         ;;  'font-lock-variable-name-face
                         ;;  '((:foreground "#383a42" :underline t))
                         ;;  font-lock-variable-name-face)
                         ;; (face-remap-add-relative
                         ;;  'default
                         ;;  '((:weight normal))
                         ;;  )
                         (lsp-deferred)
                         ))
  )

(use-package lsp-python-ms
  :disabled
  :init
  (setq lsp-python-ms-auto-install-server t)
  (when (executable-find "python3")
    (setq lsp-python-ms-python-executable-cmd "python3"))
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp-deferred)))
  )

(use-package lsp-fsharp
  :disabled                           
  :quelpa (lsp-fsharp
           :fetcher github
           :repo "emacs-lsp/lsp-mode")
  :hook (fsharp-mode . (lambda () (require 'lsp-fsharp)))
  :init
  (setq lsp-fsharp-server-install-dir "~/.emacs.d/lsp-fsharp")
  )
;; out of use:1 ends here

;; end

;; [[file:~/.emacs.d/config/emacs-config.org::*end][end:1]]
)
;; end:1 ends here

;; nox

;; [[file:~/.emacs.d/config/emacs-config.org::*nox][nox:1]]
(use-package nox
  ;; :disabled
  :quelpa (nox
           :fetcher github
           :repo manateelazycat/nox)
  ;; :ensure nil
  ;; :load-path "/home/weiss/.emacs.d/local-package/nox/"
  :init
  (defvar is-nox-activate-p nil)
  (advice-add 'nox-ensure :after (lambda () (interactive) (make-local-variable 'is-nox-activate-p) (setq is-nox-activate-p t)))
  (setq nox-python-server "mspyls")
  ;; (setq nox-python-server "pyls")
  (setq nox-optimization-p nil)

  :hook (
         (python-mode . nox-ensure)
         (go-mode . nox-ensure)
         (nox-managed-mode-hook . ryo-modal-restart)
         )
  :bind (:map nox-mode-map
              ("M-d" . nox-show-doc)
              )
  :ryo
  (:mode 'python-mode)
  ("u" nox-rename)
  ("t" nox-show-doc)  
  :config
  (setq nox-doc-tooltip-font-size "12"
        nox-doc-tooltip-border-width 3)
  ;; (setq nox-python-server 'pyls)
  )
;; nox:1 ends here

;; end

;; [[file:~/.emacs.d/config/emacs-config.org::*end][end:1]]
(provide 'weiss-lsp)
;; end:1 ends here
