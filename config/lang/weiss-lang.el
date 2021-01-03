;; -*- lexical-binding: t -*-
;; python

;; [[file:../emacs-config.org::*python][python:1]]
(use-package python
  ;; :disabled
  :ensure nil
  ;; :load-path "/home/weiss/.emacs.d/local-package"
  :hook ((inferior-python-mode . (lambda ()
                                   (process-query-on-exit-flag
                                    (get-process "Python"))))
         (python-mode . (lambda ()
                          (setq flycheck-checker 'python-pylint
                                ;; python-mode-skeleton-abbrev-table nil
                                ;; python-skeleton-autoinsert t
                                )
                          )))
  :init
  ;; Disable readline based native completion
  (setq python-shell-completion-native-enable nil)
  ;; (setq python-skeleton-autoinsert t)
  :config
  ;; Default to Python 3. Prefer the versioned Python binaries since some
  ;; systems stupidly make the unversioned one point at Python 2.
  (when (and (executable-find "python3")
             (string= python-shell-interpreter "python"))
    (setq python-shell-interpreter "python3"))
  ;; Env vars
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-env "PYTHONPATH"))
  ;; Live Coding in Python
  ;; (use-package live-py-mode)

  ;; Format using YAPF
  ;; Install: pip install yapf
  (use-package yapfify
    :disabled
    :diminish yapf-mode
    :hook (python-mode . yapf-mode))
  )
;; python:1 ends here

;; html

;; [[file:../emacs-config.org::*html][html:1]]
(use-package http
  :config
  (ryo-modal-keys
   (:mode 'sgml-mode)
   ("<escape> <escape>" (
                  ("b" ignore
                   :name "<b>"
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "<b>" "</b>" quick-insert-new-line)))
                   )
                  ("i" ignore
                   :name "<i>"
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "<i>" "</i>" quick-insert-new-line)))
                   )
                  ("u" ignore
                   :name "<u>"
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "<u>" "</u>" quick-insert-new-line)))
                   )

                  ("p" ignore
                   :name "<p>"
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "<p>" "</p>" quick-insert-new-line)))
                   )
                  ("l" ignore
                   :name "<li>"
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "<li>" "</li>" quick-insert-new-line)))
                   )
                  ("s" ignore
                   :name "<span>"
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "<span >" "</span>" quick-insert-new-line)))
                   )

                  ("d" ignore
                   :name "<div>"
                   :then ((lambda () (interactive) (weiss-insert-bracket-pair "<div >" "</div>" quick-insert-new-line)))
                   )
                  )
    )
   )
  )
;; html:1 ends here

;; c++

;; [[file:../emacs-config.org::*c++][c++:1]]
(use-package ccls
  :disabled
  :defines projectile-project-root-files-top-down-recurring
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls) (lsp)))
  :init
  ;; (setq ccls-executable "/home/weiss/c++/ccls")
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
;; c++:1 ends here

;; misc

;; [[file:../emacs-config.org::*misc][misc:1]]
(use-package markdown-mode
  :ensure t
  :ryo
  (:mode 'markdown-mode)
  ("u" markdown-toggle-inline-images)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

;; (use-package jflex-mode
;;   :load-path "/home/weiss/.emacs.d/local-package/"
;;   :after lsp-java 
;;   :mode (("\\.flex\\'" . jflex-mode))
;;   )

(use-package cup-java-mode
  :load-path "/home/weiss/.emacs.d/local-package/"
  :mode (("\\.cup\\'" . cup-java-mode))
  )

(use-package php-mode)
(use-package quickrun
  :config
  (setq quickrun-timeout-seconds 100)
  (quickrun-add-command
    "go/go"
    '((:exec . ((lambda ()
                  (cond
                   ((string-match-p "_test\\.go\\'" (or (buffer-file-name)
                                                        (buffer-name)))
                    "%c test %o")
                   ((string-match-p "main\\.go\\'" (or (buffer-file-name)
                                                       (buffer-name)))
                    "%c run %o %s %a")
                   (t
                    ;; if the current filename is not main.go, then find the main.go in this project and run it.
                    (format "go run %smain.go" (projectile-acquire-root))
                    )
                   )
                  ))))
    :override t)
  )
;; misc:1 ends here

;; go

;; [[file:../emacs-config.org::*go][go:1]]
(use-package go-mode
  :functions (go-packages-gopkgs go-update-tools)
  :bind (:map go-mode-map
              ("C-c R" . go-remove-unused-imports)
              ("<f1>" . godoc-at-point))
  :config
  (ryo-modal-keys
   (:mode 'go-mode)
   ("8" weiss-excute-buffer)
   )
  (setq-mode-local go-mode completion-ignore-case t)

  ;; Env vars
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-envs '("GOPATH" "GO111MODULE" "GOPROXY")))

  ;; Install or update tools
  (defvar go--tools '("golang.org/x/tools/cmd/goimports"
                      "github.com/go-delve/delve/cmd/dlv"
                      "github.com/josharian/impl"
                      "github.com/cweill/gotests/..."
                      "github.com/fatih/gomodifytags"
                      "github.com/davidrjenni/reftools/cmd/fillstruct")
    "All necessary go tools.")

  ;; Do not use the -u flag for gopls, as it will update the dependencies to incompatible versions
  ;; https://github.com/golang/tools/blob/master/gopls/doc/user.md#installation
  (defvar go--tools-no-update '("golang.org/x/tools/gopls@latest")
    "All necessary go tools without update the dependencies.")

  (defun go-update-tools ()
    "Install or update go tools."
    (interactive)
    (unless (executable-find "go")
      (user-error "Unable to find `go' in `exec-path'!"))

    (message "Installing go tools...")
    (let ((proc-name "go-tools")
          (proc-buffer "*Go Tools*"))
      (dolist (pkg go--tools-no-update)
        (message ": %s" pkg)
        (set-process-sentinel
         (start-process proc-name proc-buffer "go" "get" "-v" pkg)
         (lambda (proc _)
           (let ((status (process-exit-status proc)))
             (if (= 0 status)
                 (message "Installed %s" pkg)
               (message "Failed to install %s: %d" pkg status))))))

      (dolist (pkg go--tools)
        (set-process-sentinel
         (start-process proc-name proc-buffer "go" "get" "-u" "-v" pkg)
         (lambda (proc _)
           (let ((status (process-exit-status proc)))
             (if (= 0 status)
                 (message "Installed %s" pkg)
               (message "Failed to install %s: %d" pkg status))))))))

  ;; Try to install go tools if `gopls' is not found
  (unless (executable-find "gopls")
    (go-update-tools))

  ;; Misc
  (use-package go-dlv)
  (use-package go-fill-struct)
  (use-package go-impl)

  ;; Install: See https://github.com/golangci/golangci-lint#install
  (use-package flycheck-golangci-lint
    :if (executable-find "golangci-lint")
    :after flycheck
    :defines flycheck-disabled-checkers
    :hook (go-mode . (lambda ()
                       "Enable golangci-lint."
                       (setq flycheck-disabled-checkers '(go-gofmt
                                                          go-golint
                                                          go-vet
                                                          go-build
                                                          go-test
                                                          go-errcheck))
                       (flycheck-golangci-lint-setup))))

  (use-package go-tag
    :bind (:map go-mode-map
                ("C-c t t" . go-tag-add)
                ("C-c t T" . go-tag-remove))
    :init (setq go-tag-args (list "-transform" "camelcase")))

  (use-package go-gen-test
    :bind (:map go-mode-map
                ("C-c t g" . go-gen-test-dwim)))

  (use-package gotest
    :bind (:map go-mode-map
                ("C-c t a" . go-test-current-project)
                ("C-c t m" . go-test-current-file)
                ("C-c t ." . go-test-current-test)
                ("C-c t x" . go-run))))
;; go:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-lang)
;; end:1 ends here
