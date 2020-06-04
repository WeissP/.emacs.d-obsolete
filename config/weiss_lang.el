;; Python Mode
;; Install:
;;   pip install pyflakes
;;   pip install autopep8
(use-package python
  :defer t
  :ensure nil
  :hook (inferior-python-mode . (lambda ()
                                  (process-query-on-exit-flag
                                   (get-process "Python"))))
  :init
  ;; Disable readline based native completion
  (setq python-shell-completion-native-enable nil)
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
  (use-package live-py-mode)

  ;; Format using YAPF
  ;; Install: pip install yapf
  (use-package yapfify
    :disabled
    :diminish yapf-mode
    :hook (python-mode . yapf-mode)))

(use-package php-mode)

(use-package xah-elisp-mode)

;;;; ESS/R
(use-package ess)
(use-package company-ess
  :disabled
  :hook (ess-mode . (lambda ()
                      (set (make-local-variable 'company-backends) '(company-ess))
                      (company-mode)))
  ;; :config
  ; Enabling the backend :
  ; Globally - company ess-backend checks ess mode 
  ;; (add-to-list 'company-backends 'company-ess-backend)

  ; OR locally to ess mode
  ;(add-hook 'ess-mode-hook  
  )


(use-package quickrun)

;;;; Java
(use-package emacs-google-java-format
  :disabled
  :quelpa (emacs-google-java-format
           :fetcher github
           :repo sideshowcoder/emacs-google-java-format)
  :hook (java-mode . emacs-google-java-format-indention-settings))

(use-package meghanada
  :disabled
  :init
  (add-hook 'java-mode-hook
            (lambda ()
              (meghanada-mode t)
              (rainbow-delimiters-mode t)
              (highlight-symbol-mode t)
              (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))

  :config
  (use-package realgud
    :ensure t)
  (use-package autodisass-java-bytecode)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq c-basic-offset 2)
  (setq meghanada-server-remote-debug t)
  (setq meghanada-javac-xlint "-Xlint:all,-processing")
  :commands
  (meghanada-mode))

(provide 'weiss_lang)
