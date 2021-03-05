(ryo-modal-keys
 (:mode 'sgml-mode)
 ("<escape> <escape>" (
                       ("b" ignore
                        :name "<b>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<b>" "</b>" quick-insert-new-line)))
                        )
                       ("i" ignore
                        :name "<i>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<i>" "</i>" quick-insert-new-line)))
                        )
                       ("u" ignore
                        :name "<u>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<u>" "</u>" quick-insert-new-line)))
                        )

                       ("p" ignore
                        :name "<p>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<p>" "</p>" quick-insert-new-line)))
                        )
                       ("l" ignore
                        :name "<li>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<li>" "</li>" quick-insert-new-line)))
                        )
                       ("m" ignore
                        :name "<span block>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<span class=\"block\">" "</span>" quick-insert-new-line)))
                        )
                       ("s" ignore
                        :name "<span>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<span >" "</span>" quick-insert-new-line)))
                        )

                       ("d" ignore
                        :name "<div>"
                        :then ((lambda () (interactive) (weiss-insert-bracket-pair "<div >" "</div>" quick-insert-new-line)))
                        )
                       )
  )
 )

(provide 'weiss_keybindings<http)
