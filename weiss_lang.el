;; Python Mode
;; Install:
;;   pip install pyflakes
;;   pip install autopep8
(use-package python
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
    :diminish yapf-mode
    :hook (python-mode . yapf-mode)))

(use-package fsharp-mode)

;; (use-package xah-elisp-mode)
