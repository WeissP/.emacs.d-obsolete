(ryo-modal-keys
 (:mode 'latex-mode)
 ("u" weiss-org-preview-latex-and-image)
 ("<escape> <escape>" (
                       ("i" ignore
                        :name "mathit"
                        :then ((lambda()(weiss--quick-add-latex-style "mathit")))
                        )
                       ("t" ignore
                        :name "texttt"
                        :then ((lambda()(weiss--quick-add-latex-style "texttt")))
                        )
                       ("b" ignore
                        :name "mathbb"
                        :then ((lambda()(weiss--quick-add-latex-style "mathbb")))
                        )
                       ("r" ignore
                        :name "textrm"
                        :then ((lambda()(weiss--quick-add-latex-style "textrm")))
                        )
                       ("s" ignore
                        :name "textsc"
                        :then ((lambda()(weiss--quick-add-latex-style "textsc")))
                        )
                       ("u" ignore
                        :name "underline"
                        :then ((lambda()(weiss--quick-add-latex-style "underline")))
                        )
                       ("f" ignore
                        :name "textbf"
                        :then ((lambda()(weiss--quick-add-latex-style "textbf")))
                        )
                       ("h" ignore
                        :name "hat"
                        :then ((lambda()(weiss--quick-add-latex-style "hat")))
                        )
                       ("c" ignore
                        :name "mathcal"
                        :then ((lambda()(weiss--quick-add-latex-style "mathcal")))
                        )
                       ("RET" ignore
                        :name "new line"
                        :then ((lambda()(weiss-insert-bracket-pair "&" "\\\\")))
                        )
                       ("-" weiss-quick-add-latex-style-sout
                        :name "sout")
                       )
  )
 )

(provide 'weiss_keybindings<latex)
