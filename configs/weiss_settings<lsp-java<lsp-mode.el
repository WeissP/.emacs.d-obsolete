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
 lsp-java-format-settings-profile "WeissGoogleStyle"
 ;; java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
 lsp-java-format-settings-url "file:///home/weiss/weiss/format-style/WeissGoogleStyle.xml"
 ;; lsp-java-format-settings-url "/home/weiss/Documents/Vorlesungen/Compiler-and-Language-Processing-Tools/bai-bozhou/rules.xml"
 lsp-java-vmargs '("-noverify" "-Xmx1G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication" "-javaagent:/home/daniel/.m2/repository/org/projectlombok/lombok/1.18.12/lombok-1.18.12.jar" "-Xbootclasspath/a:/home/daniel/.m2/repository/org/projectlombok/lombok/1.18.12/lombok-1.18.12.jar")
 )

(with-eval-after-load 'lsp-java

    )

(provide 'weiss_settings<lsp-java<lsp-mode)
