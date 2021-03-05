(ryo-modal-keys
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

 )

(provide 'weiss_keybindings<pdf-view-mode)
