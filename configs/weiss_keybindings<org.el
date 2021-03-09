(wks-define-key
 org-mode-map ""
 '(
   ("M-i" . org-shiftmetaleft)
   ("M-k" . org-metaup)
   ("M-j" . org-metadown)
   ("M-l" . org-shiftmetaright)
   ("M-o" . org-metaleft)
   ("M-p" . org-metaright)
   ("M-p" . org-metaright)

   ("<shifttab>" . org-shifttab)
   ("5" . +org/dwim-at-point)
   ("6" . org-insert-heading-respect-content)
   ("8" . org-export-dispatch)
   ("C" . org-copy-subtree)
   ("d" . weiss-org-cut-line-or-delete-region)
   ("j" . (weiss-org-next-line (next-line) (deactivate-mark)))
   ("k" . (weiss-org-previous-line (previous-line) (deactivate-mark)))
   ("u" . weiss-org-preview-latex-and-image)
   ("n" . weiss-org-search)
   ("x" . weiss-org-exchange-point-or-switch-to-sp)
   ("X" . org-refile)

   ("t a" . weiss-org-screenshot)
   ("t o" . org-noter)
   ("t d" . weiss-org-download-img)
   ("t q" . weiss-set-org-tags)
   ("t s" . org-noter-sync-current-note)
   ("t t" . org-todo)
   ("t b" . org-mark-ring-goto)
   ("t j s" . weiss-org-copy-heading-link)

   ("<escape> <escape>" . wks-org-quick-insert-keymap)
   )
 )

(wks-define-key
 org-agenda-mode-map ""
 '(
   ("-" . xah-backward-punct)
   ("=" . xah-forward-punct)                  
   )
 )

(fset 'org-agenda-done "td")

(provide 'weiss_keybindings<org)
