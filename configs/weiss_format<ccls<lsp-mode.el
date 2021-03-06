(with-eval-after-load 'ccls
  ;; use  "bsd"  "java"  "k&r"  "stroustrup"  "whitesmith"  "banner"  "gnu"  "linux"   "horstmann"
  (setq c-default-style "linux"
        indent-tabs-mode nil
        c-basic-offset 4)
  ;; align a continued string under the one it continues
  (c-set-offset 'statement-cont 'c-lineup-string-cont)
  ;; align or indent after an assignment operator 
  (c-set-offset 'statement-cont 'c-lineup-math)
  ;; align closing brace/paren with opening brace/paren
  (c-set-offset 'arglist-close 'c-lineup-close-paren)
  (c-set-offset 'brace-list-close 'c-lineup-close-paren)
  ;; align current argument line with opening argument line 
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist)
  ;; don't change indent of java 'throws' statement in method declaration
  ;;     and other items after the function argument list
  (c-set-offset 'func-decl-cont 'c-lineup-dont-change)  
  ;; not Indent Namespaces
  (c-set-offset  'namespace-open 0)
  (c-set-offset  'namespace-close 0)
  (c-set-offset  'innamespace 0)
  ;; Indent Classes
  (c-set-offset  'class-open 0)
  (c-set-offset  'class-close 0)
  (c-set-offset  'inclass 16)
  )

(provide 'weiss_format<ccls<lsp-mode)
