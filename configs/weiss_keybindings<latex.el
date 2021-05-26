(wks-define-key
 LaTeX-mode-map ""
 '(
   ("<escape> <escape>" . wks-latex-quick-insert-keymap)
   ("<tab>" . weiss-indent)
   ("y" . weiss-org-preview-latex-and-image)
   )
 )

(wks-define-key
 latex-mode-map ""
 '(
   ("<escape> <escape>" . wks-latex-quick-insert-keymap)
   ("<tab>" . weiss-indent)
   ("y" . weiss-org-preview-latex-and-image)
   )
 )

(provide 'weiss_keybindings<latex)
