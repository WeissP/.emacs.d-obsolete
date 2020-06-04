(use-package org-noter
  ;; :disabled
  :after org
  :bind (:map org-noter-notes-mode-map
              ("M-o" . org-metaleft)
              ("M-i" . org-shiftmetaleft)
              ("M-k" . org-metaup)
              ("M-j" . org-metadown)
              ("M-l" . org-shiftmetaright)
              ("M-o" . org-metaleft)
              ("M-p" . org-metaright))
  :config
  (set-face-attribute 'org-noter-notes-exist-face nil
                      :height 1.0
                      :foreground "medium violet red"
                      :weight 'bold)

  (setq
   org-noter-insert-note-no-questions 't
   org-noter-auto-save-last-location 't
   )

  (defun weiss-direct-annot-and-insert-note()
    (interactive)
    (let ((pdfBuffer (buffer-name))
          (markedText (org-noter--get-precise-info))
          (list (pdf-view-active-region))
          )
      (pdf-annot-add-markup-annotation list 'highlight)
      (org-noter-insert-precise-note)
      (org-up-element)
      (org-set-tags ":Frage:")
      )
    (xah-fly-command-mode-activate)
    )

  (defun weiss-direct-insert-note()
    "direct annot and insert note with selected text"
    (interactive)
    (let ((pdfBuffer (buffer-name))
          (markedText (org-noter--get-precise-info))
          )
      (org-noter-insert-precise-note)
      )
    (xah-fly-command-mode-activate)
    )
  )



(defun weiss-pdf-mode-setup()
  (interactive)
  (linum-mode -1)
  (pdf-annot-minor-mode)
  (setq
   display-line-numbers 'nil)
  )

(add-hook 'pdf-view-mode-hook 'weiss-pdf-mode-setup)


(provide 'weiss_pdf_tools)
