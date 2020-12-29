;; -*- lexical-binding: t -*-
;; start, bind

;; [[file:../emacs-config.org::*start, bind][start, bind:1]]
(use-package lsp-mode
  ;; :disabled
  :diminish
  :commands lsp
  :hook (
         (java-mode . lsp-deferred)
         ;; (c++-mode . lsp-deferred)
         )
  :bind (:map lsp-mode-map
              ("M-p" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
;; start, bind:1 ends here

;; init

;; [[file:../emacs-config.org::*init][init:1]]
:init
;; init:1 ends here

;; variable


;; [[file:../emacs-config.org::*variable][variable:1]]
(setq
 lsp-log-io nil                       ;; enable log only for debug
 lsp-headerline-breadcrumb-enable nil
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
 lsp-modeline-diagnostics-enable t  ;; as above
 lsp-idle-delay 0.1                   ;; lazy refresh
 ;; lsp-diagnostics-provider :flycheck   ;; prefer `flycheck'
 lsp-lens-enable t                    ;; enable lens
 lsp-auto-guess-root t                ;; auto guess root
 lsp-keep-workspace-alive nil         ;; auto kill lsp server
 lsp-eldoc-enable-hover t           ;; disable eldoc hover
 lsp-signature-auto-activate t        ;; show function signature
 lsp-signature-doc-lines 2            ;; but dont take up more lines
 lsp-restart 'auto-restart  ;; auto restart lsp
 lsp-enable-completion-at-point nil    ;; Please note `company-lsp' is automatically enabled if installed
 ;; lsp-completion-provider :capf
 lsp-prefer-capf t
 )
;; variable:1 ends here

;; lsp-ui

;; [[file:../emacs-config.org::*lsp-ui][lsp-ui:1]]
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


;; [[file:../emacs-config.org::*lsp-java][lsp-java:1]]
(use-package lsp-java
  ;; :disabled
  :hook (java-mode . (lambda ()
                       (require 'lsp-java)
                       (make-local-variable 'lsp-diagnostic-package)
                       (setq lsp-diagnostic-package :flycheck)
                       (lsp-completion-mode)
                       ;; (lsp-ui-flycheck-enable t)
                       ;; (lsp-ui-sideline-mode)
                       ))
  :requires (lsp-ui-flycheck lsp-ui-sideline)
  :init
  ;; (add-hook 'java-mode-hook 'lsp-completion-mode)
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

;; company-lsp

;; [[file:../emacs-config.org::*company-lsp][company-lsp:1]]
(use-package company-lsp
  :disabled
  :after  company
  :ensure t
  :config
  (add-hook 'java-mode-hook (lambda () (push 'company-lsp company-backends)))
  (setq company-lsp-enable-snippet t
        company-lsp-cache-candidates t)
  (push 'java-mode company-global-modes))
;; company-lsp:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
)
;; end:1 ends here

;; nox

;; [[file:../emacs-config.org::*nox][nox:1]]
(use-package nox
  ;; :disabled
  :quelpa (nox
           :fetcher github
           :repo manateelazycat/nox)
  ;; :ensure nil
  ;; :load-path "/home/weiss/.emacs.d/local-package/nox/"
  :init
  (defvar is-nox-activate-p nil)
  ;; (advice-add 'nox-ensure :after (lambda () (interactive) (make-local-variable 'is-nox-activate-p) (setq is-nox-activate-p t)))
  (setq nox-python-server "mspyls")
  ;; (setq nox-python-server "pyls")
  (setq nox-optimization-p nil)

  :hook (
         (python-mode . nox-ensure)
         (go-mode . nox-ensure)
         ;; (nox-managed-mode-hook . ryo-modal-restart)
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

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-lsp)
;; end:1 ends here
