(defvar weiss-mode-line-projectile-root-dir nil)
(make-variable-buffer-local 'weiss-mode-line-projectile-root-dir)
(defun weiss-mode-line-get-projectile-root-dir ()
  "get the parent dir of the projectile root"
  (setq weiss-mode-line-projectile-root-dir
        (if-let ((r (projectile-project-root)))
            (if (< (length r) 1) 
                "nil"
              (substring (file-relative-name r (file-name-directory (substring r 0 -1)))
                         0 -1)
              )             
          "nil"
          )
        ))

(add-hook 'find-file-hook 'weiss-mode-line-get-projectile-root-dir)

(provide 'weiss_root-dir<modeline<ui)
