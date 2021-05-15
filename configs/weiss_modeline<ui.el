;; get total line numbers
(defvar weiss-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'weiss-mode-line-buffer-line-count)

(defun weiss-mode-line-count-lines ()
  (setq weiss-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'weiss-mode-line-count-lines)
(add-hook 'after-save-hook 'weiss-mode-line-count-lines)
(add-hook 'after-revert-hook 'weiss-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'weiss-mode-line-count-lines)

;; get projectile root dir
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

(setq-default mode-line-format
              `(
                " "
                (:eval (if wks-vanilla-mode "Vanilla" "Normal "))
                "   "
                mode-line-mule-info mode-line-modified mode-line-remote
                "   "
                (list 'line-number-mode "L%l/")
                (list 'line-number-mode weiss-mode-line-buffer-line-count)
                (list 'column-number-mode " C%c ")        
                "   "
                "Root:" weiss-mode-line-projectile-root-dir
                "   "
                "%e" mode-line-buffer-identification "   " 
                (vc-mode vc-mode)
                "  " mode-line-misc-info mode-line-end-spaces
                )
              )

(with-eval-after-load 'pdf-tools
  ;; comes from doom-modeline
  (defvar-local weiss-mode-line-pdf-pages nil)
  (defun weiss-mode-line-update-pdf-pages ()
    "Update PDF pages."
    (setq weiss-mode-line-pdf-pages
          (format "  P%d/%d "
                  (eval `(pdf-view-current-page))
                  (pdf-cache-number-of-pages))))
  (add-hook 'pdf-view-change-page-hook #'weiss-mode-line-update-pdf-pages)
  ;; (remove-hook 'pdf-view-mode #'weiss-mode-line-update-pdf-pages)

  (defun weiss-mode-line-pdf-mode ()
    "DOCSTRING"
    (interactive)
    (setq mode-line-format
          `(
            " "
            (:eval (if wks-vanilla-mode "Vanilla" "Normal "))
            "   "
            mode-line-mule-info mode-line-modified mode-line-remote
            "   "
            weiss-mode-line-pdf-pages
            "   "
            "Root:" weiss-mode-line-projectile-root-dir
            "   "
            "%e" mode-line-buffer-identification "   " 
            (vc-mode vc-mode)
            "  " mode-line-misc-info mode-line-end-spaces
            )
          ))
  (add-hook 'pdf-view-change-page-hook #'weiss-mode-line-pdf-mode)  
  ;; (remove-hook 'pdf-view-mode #'weiss-mode-line-pdf-mode)  
  )

(provide 'weiss_modeline<ui)
