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

(provide 'weiss_pdf<modeline<ui)
