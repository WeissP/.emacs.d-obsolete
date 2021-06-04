;; (with-eval-after-load 'ccls
  ;; (wks-unset-key c++-mode-map '(","))     
  ;; (wks-unset-key c++-mode-map '(";"))     
  ;; )

(wks-unset-key c-mode-map '("," "/"))
(wks-unset-key c++-mode-map '("," "/"))

(provide 'weiss_keybindings<ccls)
