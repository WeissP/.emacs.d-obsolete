(add-hook 'inferior-python-mode #'(lambda ()
                                    (process-query-on-exit-flag
                                     (get-process "Python"))))

(setq python-shell-completion-native-enable nil)

(with-eval-after-load 'python
  ;; Default to Python 3. Prefer the versioned Python binaries since some
  ;; systems stupidly make the unversioned one point at Python 2.
  (when (and (executable-find "python3")
             (string= python-shell-interpreter "python"))
    (setq python-shell-interpreter "python3"))
  ;; Env vars
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-env "PYTHONPATH"))
  )

(provide 'weiss_settings<python)
