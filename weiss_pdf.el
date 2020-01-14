(use-package pdf-tools
  :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
  :magic ("%PDF" . pdf-view-mode)
  :config
  (setq-default pdf-view-display-size 'fit-page
                pdf-view-use-scaling t
                pdf-view-use-imagemagick nil)

  ;; The mode-line does serve any useful purpose is annotation windows
  (add-hook 'pdf-annot-list-mode-hook #'hide-mode-line-mode)

  ;; Sets up `pdf-tools-enable-minor-modes', `pdf-occur-global-minor-mode' and
  ;; `pdf-virtual-global-minor-mode'.
  (pdf-tools-install-noverify)

  (defun weiss-pdf-view-previous-page-quickly ()
    (interactive)
    (pdf-view-previous-page-command 5))
  
  (defun weiss-pdf-view-next-page-quickly ()
    (interactive)
    (pdf-view-next-page-command 5))

  )

;; (use-package org-noter)

;; (load "/home/weiss/.emacs.d/straight/build/org-noter/org-noter.elc")
;; (require 'org-noter)

(use-package org-noter
  :after org
  :defer 5
)


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
  )

(defun weiss-direct-insert-note()
  "direct annot and insert note with selected text"
  (interactive)
  (let ((pdfBuffer (buffer-name))
        (markedText (org-noter--get-precise-info))
        )
    (org-noter-insert-precise-note)
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


