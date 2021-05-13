(add-hook 'dired-mode-hook (lambda () (interactive)
                             (dired-hide-details-mode 1)
                             (dired-collapse-mode)
                             (dired-utils-format-information-line-mode)
                             ;; (all-the-icons-dired-mode)
                             (dired-omit-mode)
                             (setq dired-auto-revert-buffer 't)
                             ))

(with-eval-after-load 'dired
  (setq
   weiss-test-var "123"
   dired-dwim-target t
   dired-recursive-deletes 'always
   dired-recursive-copies (quote always)
   dired-auto-revert-buffer t
   dired-omit-files "\\`[.]?#\\|\\`[.][.]?\\'|\\|.*aria2$\\|^.*frag-master.*$\\|^\\."
   dired-listing-switches "-altGh"
   )
  )
(defun dired-uncache (dir)
  "Remove directory DIR from any directory cache."
  (let ((handler (find-file-name-handler dir 'dired-uncache)))
    (if handler
	(funcall handler 'dired-uncache dir))))
(provide 'weiss_settings<dired)
