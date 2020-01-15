(use-package pdf-tools
  :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
  :magic ("%PDF" . pdf-view-mode)
  :init
  (defun weiss-pdf-command-mode-define-keys ()
    (weiss--define-keys
     xah-fly-key-map
     '(

       ;; ("~" . nil)
       ;; (":" . nil)

       ;; ("SPC" . xah-fly-leader-key-map)
       ;; ("DEL" . xah-fly-leader-key-map)

       ;; ("'" . xah-cycle-hyphen-underscore-space)
       ;; ("," . weiss-switch-frame-and-refresh-xfk)
       ("-" . pdf-view-shrink)
       ;; ("." . xah-forward-right-bracket)
       ;; (";" . xah-end-of-line-or-block)
       ;; ("/" . xah-goto-matching-bracket)
       ;; ("\\" . nil)
       ("=" . pdf-view-enlarge)
       ;; ("[" . hippie-expand )
       ;; ("]" . nil)
       ;; ("`" . other-frame)

       ;; ("<backtab>" . weiss-indent)
       ;; ("V" . weiss-paste-with-linebreak)

       ;; ("#" . xah-backward-quote)
       ;; ("$" . xah-forward-punct)

       ("1" . weiss-pdf-view-previous-page-quickly)
       ("2" . weiss-pdf-view-next-page-quickly)
       ;; ("3" . delete-other-windows)
       ;; ("4" . split-window-below)
       ;; ("5" . delete-char)
       ;; ("6" . xah-select-block)
       ;; ("7" . xah-select-line)
       ;; ("8" . xah-extend-selection)
       ;; ("9" . xah-select-text-in-quote)
       ("0" . pdf-view-scale-reset)

       ;; ("a" . execute-extended-command)
       ;; ("b" . xah-toggle-letter-case)
       ;; ("c" . xah-copy-line-or-region)
       ("d" . weiss-direct-insert-note)
       ;; ("e" . xah-backward-kill-word)
       ;; ("f" . xah-fly-insert-mode-activate)
       ;; ("g" . xah-delete-current-text-block)
       ("h" . pdf-view-fit-height-to-window)
       ;; ("i" . xah-beginning-of-line-or-block)
       ("j" . pdf-view-scroll-up-or-next-page)
       ("k" . pdf-view-scroll-down-or-previous-page)
       ;; ("l" . xah-fly-insert-mode-activate-space-before)
       ;; ("l" . forward-char)
       ;; ("m" . xah-backward-left-bracket)
       ("n" . isearch-forward)
       ;; ("o" . forward-word)
       ("p" . pdf-view-fit-page-to-window)
       ;; ("q" . xah-reformat-lines)
       ;; ("r" . xah-kill-word)
       ("s" . weiss-direct-annot-and-insert-note)
       ;; ("t" . set-mark-command)
       ;; ("u" . backward-word)
       ;; ("v" . xah-paste-or-paste-previous)
       ("w" . pdf-view-fit-width-to-window)
       ;; ("x" . xah-cut-line-or-region)
       ;; ("y" . undo)
       ;; ("z" . xah-comment-dwim)
       )))
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

(use-package org-noter
  :after org
  :defer t
  :config

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


