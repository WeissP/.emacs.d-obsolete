;; -*- lexical-binding: t -*-
;; start, hook, bind

;; [[file:../emacs-config.org::*start, hook, bind][start, hook, bind:1]]
(use-package lsp-mode
  ;; :disabled
  :diminish
  :commands lsp
  :hook (
         (java-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp-deferred)))
         (c++-mode . lsp-deferred)
         )
  :bind (:map lsp-mode-map
              ("M-p" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
;; start, hook, bind:1 ends here

;; init

;; [[file:../emacs-config.org::*init][init:1]]
:init
;; init:1 ends here

;; variable


;; [[file:../emacs-config.org::*variable][variable:1]]
(setq
 lsp-clients-python-library-directories '("/usr/local/" "/usr/")
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
 lsp-lens-enable nil                    ;; disable lens
 lsp-auto-guess-root t                ;; auto guess root
 lsp-keep-workspace-alive nil         ;; auto kill lsp server
 lsp-eldoc-enable-hover t           ;; disable eldoc hover
 lsp-signature-auto-activate t        ;; show function signature
 lsp-signature-doc-lines 2            ;; but dont take up more lines
 lsp-restart 'auto-restart  ;; auto restart lsp
 lsp-enable-completion-at-point t    ;; Please note `company-lsp' is automatically enabled if installed
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
   lsp-java-format-enabled t
   ;; lsp-java-format-comments-enabled nil
   ;; lsp-java-format-settings-profile "GoogleStyle"
   ;; java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
   lsp-java-format-settings-url " https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
   ;; lsp-java-format-settings-url "/home/weiss/Documents/Vorlesungen/Compiler-and-Language-Processing-Tools/bai-bozhou/rules.xml"
   )
  :ryo
  (:mode 'java-mode)
  ("u" lsp-rename)
  ("t" (
        ("a" lsp-execute-code-action)
        ("t" lsp-java-generate-to-string)
        ("f" weiss-format-current-java-file)
        ("F" weiss-format-current-java-dir)
        ("e" lsp-java-generate-equals-and-hash-code)
        ("o" lsp-java-generate-overrides)
        ("g" lsp-java-generate-getters-and-setters)             
        ))    
  :config
  (defun async-shell-command-no-window
      (command)
    (interactive)
    (let
        ((display-buffer-alist
          (list
           (cons
            "\\*Async Shell Command\\*.*"
            (cons #'display-buffer-no-window nil)))))
      (async-shell-command
       command)))
  (defun weiss--format-java (dir)
    "DOCSTRING"
    (save-buffer)
    (message "start format file")
    (let ((display-buffer-alist (list (cons "\\*Async Shell Command\\*.*"
                                            (cons #'display-buffer-no-window nil))))
          )
      (async-shell-command
       (concat
        "/home/weiss/idea/idea-IU-201.6668.121/bin/idea.sh format -s /home/weiss/weiss/Bai-JavaCodeStyle.xml "
        (if dir 
            (concat "-r " default-directory)
          (buffer-file-name)))))

    )
  (defun weiss-format-current-java-file ()
    "format current java file using idea"
    (interactive)
    (weiss--format-java nil))
  (defun weiss-format-current-java-dir ()
    "format current directory using idea"
    (interactive)
    (weiss--format-java t))

  )
;; lsp-java:1 ends here

;; python

;; [[file:../emacs-config.org::*python][python:1]]
(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . yas-minor-mode)
  )
;; python:1 ends here

;; C/C++/Objective-C

;; [[file:../emacs-config.org::*C/C++/Objective-C][C/C++/Objective-C:1]]
;; C/C++/Objective-C support
(use-package ccls
  :disabled
  :defines projectile-project-root-files-top-down-recurring
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls) (lsp)))
  :init
  ;; (setq ccls-executable "/home/weiss/c++/ccls")
  (setq ccls-executable "/usr/bin/ccls")
  ;; use  "bsd"  "java"  "k&r"  "stroustrup"  "whitesmith"  "banner"  "gnu"  "linux"   "horstmann"
  (setq c-default-style "linux"
        indent-tabs-mode nil
        c-basic-offset 4)
  ;; align a continued string under the one it continues
  (c-set-offset 'statement-cont 'c-lineup-string-cont)
  ;; align or indent after an assignment operator 
  (c-set-offset 'statement-cont 'c-lineup-math)
  ;; align closing brace/paren with opening brace/paren
  (c-set-offset 'arglist-close 'c-lineup-close-paren)
  (c-set-offset 'brace-list-close 'c-lineup-close-paren)
  ;; align current argument line with opening argument line 
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist)
  ;; don't change indent of java 'throws' statement in method declaration
  ;;     and other items after the function argument list
  (c-set-offset 'func-decl-cont 'c-lineup-dont-change)  
  ;; not Indent Namespaces
  (c-set-offset  'namespace-open 0)
  (c-set-offset  'namespace-close 0)
  (c-set-offset  'innamespace 0)
  ;; Indent Classes
  (c-set-offset  'class-open 0)
  (c-set-offset  'class-close 0)
  (c-set-offset  'inclass 16)
  :config
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json" ".ccls")
                  projectile-project-root-files-top-down-recurring)))

  ;; compile_commands.json
  ;; cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
  ;; ln -s Debug/compile_commands.json       
  )
;; C/C++/Objective-C:1 ends here

;; config

;; [[file:../emacs-config.org::*config][config:1]]
:config
(dolist (x '(go-mode python-mode java-mode)) 
  (ryo-modal-keys
   ("t i" lsp-organize-imports :mode x)
   ("t d" lsp-describe-thing-at-point :mode x)
   ("u" lsp-rename :mode x)            
   )
  )

;; (:mode 'go-mode)
;; ("u" lsp-rename)
;; (:mode 'python-mode)
;; ("t" lsp-describe-thing-at-point)
;; ("u" lsp-rename)
;; config:1 ends here

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
  :disabled
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

  ;; :hook (
         ;; (python-mode . nox-ensure)
         ;; (go-mode . nox-ensure)
         ;; (nox-managed-mode-hook . ryo-modal-restart)
         ;; )
  :bind (:map nox-mode-map
              ("M-d" . nox-show-doc)
              )
  :ryo
  (:mode 'python-mode)
  ("u" nox-rename)
  ("t" nox-show-doc)
  ;; (:mode 'go-mode)
  ;; ("u" nox-rename)
  ;; ("t" nox-show-doc)  
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
