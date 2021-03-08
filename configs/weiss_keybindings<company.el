(wks-define-key
 company-active-map ""
 '(
   ("<tab>" . company-complete-common-or-cycle)
   ("TAB" . company-complete-common-or-cycle)
   ("9" . weiss-company-select-next-or-toggle-main-frame)
   ("8" . (weiss-company-select-previous (company-complete-common-or-cycle -1)))
   ;; ("<escape>" . nil)
   ;; ("<return>" . nil)
   ;; ("RET" . nil)
   ;; ("SPC" . nil)
   )
 )

(define-key company-active-map (kbd "<escape>") nil)
(define-key company-active-map (kbd "RET") nil)
(define-key company-active-map (kbd "<return>") nil)
(define-key company-active-map (kbd "SPC") nil)

;; (define-key company-active-map (kbd "<tab>") #'company-complete-common-or-cycle)
;; (define-key company-active-map (kbd "TAB") #'company-complete-common-or-cycle)
;; (define-key company-active-map (kbd "9") #'weiss-company-select-next-or-toggle-main-frame)
;; (define-key company-active-map (kbd "8") #'(lambda () (interactive) (company-complete-common-or-cycle -1)))
;; (define-key company-active-map (kbd "<escape>") nil)
;; (define-key company-active-map (kbd "RET") nil)
;; (define-key company-active-map (kbd "<return>") nil)
;; (define-key company-active-map (kbd "SPC") nil)

(provide 'weiss_keybindings<company)
