(with-eval-after-load 'dired
  (defun weiss-dired-ediff-files ()
    (interactive)
    (let ((files (dired-get-marked-files))
          (wnd (current-window-configuration)))
      (if (<= (length files) 2)
          (let ((file1 (car files))
                (file2 (if (cdr files)
                           (cadr files)
                         (read-file-name
                          "file: "
                          (dired-dwim-target-directory)))))
            (if (file-newer-than-file-p file1 file2)
                (ediff-files file2 file1)
              (ediff-files file1 file2))
            (add-hook 'ediff-after-quit-hook-internal
                      (lambda ()
                        (setq ediff-after-quit-hook-internal nil)
                        (set-window-configuration wnd))))
        (error "no more than 2 files should be marked"))))

  (defun weiss-dired-copy-file-name ()
    "copy file name or copy path with prefix-arg"
    (interactive)
    (if current-prefix-arg
        (let ((current-prefix-arg 0))
          (dired-copy-filename-as-kill)
          )
      (let ((current-prefix-arg nil))
        (dired-copy-filename-as-kill)      
        )
      ))

  (defun weiss-exit-wdired-mode ()
    "exit wdired mode"
    (interactive)
    (wdired-finish-edit)
    (dired-revert)
    (ryo-modal-restart))

  (defun weiss-dired-delete-files-force ()
    "delete files without ask"
    (interactive)
    (dired-delete-file weiss-dired-marked-files)
    ;; (dired-delete-file "/home/weiss/Downloads/mp1.pdf")
    ;; (message "%s" "123")
    )

  (defun weiss-revert-all-dired-buffer ()
    "DOCSTRING"
    (interactive)
    (dolist (x (buffer-list) nil)
      (when (string-match "dired" (format "%s" (with-current-buffer x major-mode)))
        (with-current-buffer x
          (revert-buffer))
        ))
    )
  )

(provide 'weiss_miscs<dired)
