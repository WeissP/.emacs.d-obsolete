(with-eval-after-load 'weiss_after-dump-misc
  (font-lock-add-keywords
   'java-mode
   '(
     ("[a-z]<[a-zA-Z]+>"  . 'font-lock-type-face)
     ))
  (add-hook 'java-mode-hook 'weiss-java-face)

  (defun weiss-java-face ()
    (interactive)
    (face-remap-add-relative
     ;; 'font-lock-function-name-face '((:foreground "#383a42" :box '(:line-width 1))) font-lock-function-name-face)
     'font-lock-function-name-face '((:foreground "#383a42" :background "#f8eed4")) font-lock-function-name-face)
    (face-remap-add-relative
     'font-lock-variable-name-face '((:foreground "#383a42" :underline t)) font-lock-variable-name-face)
    (face-remap-add-relative
     'c-annotation-face '((:foreground "#A9AAAE")))
    (face-remap-add-relative
     'font-lock-type-face '((:foreground "#737C79" :background "#F7EBFC")))
  )
)

(provide 'weiss_java<font-lock-face<ui)
