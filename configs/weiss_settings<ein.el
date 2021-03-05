(with-eval-after-load 'ein
  (defun weiss-ein-execute-all-cells-above-inclusively ()
    "execute all cells above inclusive current cell"
    (interactive)
    (call-interactively 'ein:worksheet-execute-all-cells-above)
    (call-interactively 'ein:worksheet-execute-cell)
    )

  (defun weiss-execute-buffer-python ()
    "execute cell if in jupyter otherwise execute buffer"
    (interactive)
    (if ein:notebook-mode
        (call-interactively 'ein:worksheet-execute-cell) 
      (weiss-execute-buffer))
    )
  (setq ein:output-area-inlined-images t)

  (with-eval-after-load 'ein-notebook
    (define-key ein:notebook-mode-map [remap save-buffer] 'ein:notebook-save-notebook-command)      
    (define-key ein:notebook-mode-map [remap weiss-execute-buffer] 'ein:worksheet-execute-all-cells-above)      
    )

  (defun xor-preview-md-cell-latex ()
    "Preview LaTeX from the current markdown cell in a separate buffer."
    ;; https://github.com/millejoh/emacs-ipython-notebook/issues/88
    (interactive)
    (let* ((cell (ein:worksheet-get-current-cell))
           (buffer (if (ein:markdowncell-p cell)
                       (get-buffer-create " *ein: LaTeX in Markdown preview*")
                     (error "Not on a markdown cell"))))
      (with-current-buffer buffer
        (when buffer-read-only
          (toggle-read-only))
        (unless (= (point-min) (point-max))
          (delete-region (point-min) (point-max)))
        (insert (slot-value cell :input))
        (goto-char (point-min))
        (org-mode)
        (org-toggle-latex-fragment 16)
        (special-mode)
        (unless buffer-read-only
          (toggle-read-only))
        (display-buffer
         buffer
         '((display-buffer-below-selected display-buffer-at-bottom)
           (inhibit-same-window . t)))
        (fit-window-to-buffer (window-in-direction 'below)))))
  )

(provide 'weiss_settings<ein)
