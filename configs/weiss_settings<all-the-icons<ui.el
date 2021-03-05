(with-eval-after-load 'all-the-icons
  (add-to-list 'all-the-icons-mode-icon-alist '(xah-elisp-mode all-the-icons-fileicon "elisp" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(eaf-mode all-the-icons-alltheicon "atom" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(debugger-mode all-the-icons-faicon "bug" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(telega-root-mode all-the-icons-fileicon "telegram" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(telega-chat-mode all-the-icons-material "chat" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (with-no-warnings
    (defun all-the-icons-reset ()
      "Reset (unmemoize/memoize) the icons."
      (interactive)
      (dolist (f '(all-the-icons-icon-for-file
                   all-the-icons-icon-for-mode
                   all-the-icons-icon-for-url
                   all-the-icons-icon-family-for-file
                   all-the-icons-icon-family-for-mode
                   all-the-icons-icon-family))
        (ignore-errors
          (memoize-restore f)
          (memoize f)))
      (message "Reset all-the-icons")))
  )


(provide 'weiss_settings<all-the-icons<ui)
