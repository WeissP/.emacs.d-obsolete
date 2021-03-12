;; (setq pdf-view-mode-map (wks-define-vanilla-keymap))
(wks-unset-key pdf-view-mode-map '("SPC" "9" "-" "0" "s") t)
;; (wks-unset-key pdf-view-mode-map )

(wks-define-key
 pdf-view-mode-map ""
 '(
   ("," . (weiss-pdf-scroll-down (image-previous-line 2)))
   ("." . (weiss-pdf-scroll-up (image-next-line 2)))
   ("=" .  pdf-view-scale-reset)
   ("[" .  pdf-view-shrink )
   ("]" .  pdf-view-enlarge)
   ("1" .  weiss-pdf-view-previous-page-quickly)
   ("2" .  weiss-pdf-view-next-page-quickly)
   ;; ("a"  weiss-direct-annot-and-insert-note)
   ("c" .  pdf-view-kill-ring-save)
   ;; ("d"  weiss-direct-insert-note)
   ("h" .  pdf-view-fit-height-to-window)
   ("i" .  image-backward-hscroll)
   ("j" .  (weiss-pdf-next-page (pdf-view-next-page-command) (image-set-window-vscroll 0)))
   ("k" .  (weiss-pdf-previous-page (pdf-view-previous-page-command) (image-set-window-vscroll 0)))
   ("l" .  image-forward-hscroll)
   ("n" .  isearch-forward)
   ("p" .  pdf-view-fit-page-to-window)
   ("w" .  pdf-view-fit-width-to-window)    
   )
 )

(provide 'weiss_keybindings<pdf-view-mode)
