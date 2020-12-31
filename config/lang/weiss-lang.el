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
  (setq quickrun-timeout-seconds 100))
;; misc:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-lang)
;; end:1 ends here
