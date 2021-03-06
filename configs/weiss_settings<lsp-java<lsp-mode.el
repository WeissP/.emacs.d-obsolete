(add-hook 'java-mode-hook #'(lambda ()
                              (require 'lsp-java)
                              (make-local-variable 'lsp-diagnostic-package)
                              (setq lsp-diagnostic-package :flycheck)
                              (lsp-completion-mode)
                              ;; (lsp-ui-flycheck-enable t)
                              ;; (lsp-ui-sideline-mode)
                              ))

(setq
 lsp-java-format-enabled t
 ;; lsp-java-format-comments-enabled nil
 ;; lsp-java-format-settings-profile "GoogleStyle"
 ;; java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
 lsp-java-format-settings-url " https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
 ;; lsp-java-format-settings-url "/home/weiss/Documents/Vorlesungen/Compiler-and-Language-Processing-Tools/bai-bozhou/rules.xml"
 )

(with-eval-after-load 'lsp-java

    )

(provide 'weiss_settings<lsp-java<lsp-mode)
