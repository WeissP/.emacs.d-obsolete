;; -*- lexical-binding: t -*-
;; pdf
;; :PROPERTIES:
;; :header-args: :tangle pdf/weiss-pdf.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*pdf][pdf:1]]
(use-package org-noter
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
   ;; org-noter-notes-window-behavior '(start)
   org-noter-notes-window-location 'other-frame
   org-noter-always-create-frame nil
   )

  (defun org-noter-select-noter-frame ()
    "DOCSTRING"
    (interactive)
    (select-frame-set-input-focus (window-frame (org-noter--get-notes-window 'force))))

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
    ;; (xah-fly-command-mode-activate)
    )

  (defun weiss-direct-insert-note()
    "direct annot and insert note with selected text"
    (interactive)
    (let ((pdfBuffer (buffer-name))
          (markedText (org-noter--get-precise-info))
          )
      (org-noter-insert-precise-note)
      )
    ;; (xah-fly-command-mode-activate)
    )
  )

(use-package pdf-tools
  ;; need to M-x pdf-tools-install
  :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
  :magic ("%PDF" . pdf-view-mode)
  :after org-noter
  :ryo
  (:mode 'pdf-view-mode)
  ("," ignore
   :then '((lambda()(interactive)(image-previous-line 2)))
   :name "scroll down"
   )
  ("." ignore
   :then '((lambda()(interactive)(image-next-line 2)))
   :name "scroll up"
   )
  ("="  pdf-view-scale-reset)
  ("["  pdf-view-shrink )
  ("]"  pdf-view-enlarge)
  ("1"  weiss-pdf-view-previous-page-quickly)
  ("2"  weiss-pdf-view-next-page-quickly)
  ;; ("a"  weiss-direct-annot-and-insert-note)
  ("c"  pdf-view-kill-ring-save)
  ;; ("d"  weiss-direct-insert-note)
  ("h"  pdf-view-fit-height-to-window)
  ("i"  image-backward-hscroll)
  ("j"  pdf-view-next-page-command :then '((lambda() (image-set-window-vscroll 0))))
  ("k"  pdf-view-previous-page-command :then '((lambda() (image-set-window-vscroll 0))))
  ("l"  image-forward-hscroll)
  ("n"  isearch-forward)
  ("p"  pdf-view-fit-page-to-window)
  ("w"  pdf-view-fit-width-to-window)    
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

  (use-package pdf-view-restore
    :after pdf-tools
    :init
    (setq pdf-view-restore-filename "~/.emacs.d/.pdf-view-restore")
    :config
    (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))
  )

(defun weiss-pdf-mode-setup()
  (interactive)
  (linum-mode -1)
  (setq-local cursor-type nil)
  (pdf-annot-minor-mode)
  (setq
   display-line-numbers 'nil)
  )

(add-hook 'pdf-view-mode-hook 'weiss-pdf-mode-setup)


(provide 'weiss-pdf)
;; pdf:1 ends here
