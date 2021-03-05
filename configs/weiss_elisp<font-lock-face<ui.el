(defface elisp-attribute-face
  '((nil :background "#F0DFF9"))
  "Face for :xxx."
  :group 'emacs-lisp-mode )

(font-lock-add-keywords
 'emacs-lisp-mode
 `(
   (,(regexp-opt xah-elisp-ampersand-words 'symbols) . font-lock-builtin-face)
   (,(regexp-opt xah-elisp-functions 'symbols) . font-lock-function-name-face)
   (,(regexp-opt xah-elisp-special-forms 'symbols) . font-lock-keyword-face)
   (,(regexp-opt xah-elisp-macros 'symbols) . font-lock-keyword-face)
   (,(regexp-opt xah-elisp-commands 'symbols) . 'font-lock-function-name-face)
   (,(regexp-opt xah-elisp-user-options 'symbols) . font-lock-variable-name-face)
   (,(regexp-opt xah-elisp-variables 'symbols) . font-lock-variable-name-face)
   (":[a-z\\-]+\\b" . 'elisp-attribute-face)
   ))

(provide 'weiss_elisp<font-lock-face<ui)
