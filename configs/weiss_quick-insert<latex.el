(define-prefix-command 'wks-latex-quick-insert-keymap)

(wks-define-key
 wks-latex-quick-insert-keymap ""
 '(
   ("i" . (weiss-latex-insert-mathit (weiss--quick-add-latex-style "mathit")))
   ("t" . (weiss-latex-insert-texttt (weiss--quick-add-latex-style "texttt")))
   ("b" . (weiss-latex-insert-mathbb (weiss--quick-add-latex-style "mathbb")))
   ("r" . (weiss-latex-insert-textrm (weiss--quick-add-latex-style "textrm")))
   ("s" . (weiss-latex-insert-textsc (weiss--quick-add-latex-style "textsc")))
   ("e" . (weiss-latex-insert-textem (weiss--quick-add-latex-style "emph")))
   ("u" . (weiss-latex-insert-underline (weiss--quick-add-latex-style "underline")))
   ("f" . (weiss-latex-insert-textbf (weiss--quick-add-latex-style "textbf")))
   ("h" . (weiss-latex-insert-hat (weiss--quick-add-latex-style "hat")))
   ("c" . (weiss-latex-insert-mathcal (weiss--quick-add-latex-style "mathcal")))
   ("RET" . (weiss-latex-insert-new-line (weiss-insert-pair "&" "\\\\")))
   ("-" . weiss-quick-add-latex-style-sout)
   )
 )


(provide 'weiss_quick-insert<latex)
