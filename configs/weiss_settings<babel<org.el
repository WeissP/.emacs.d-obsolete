(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

(setq load-language-list '((emacs-lisp . t)
                           (shell . t)
                           (python . t)
                           (ruby . t)
                           (ob-fsharp . t)
                           (ob-javascript . t)
                           (ob-go . t)
                           (ob-rust . t)
                           (ob-java . t)
                           (ob-sql-mode . t)
                           (js . t)
                           (css . t)
                           (sass . t)
                           (C . t)
                           (plantuml . t)))



(provide 'weiss_settings<babel<org)
