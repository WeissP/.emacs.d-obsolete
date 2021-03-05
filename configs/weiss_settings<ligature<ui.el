(with-eval-after-load 'ligature
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (let ((ligatures '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                     ":::" "::=" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                     "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "-<<"
                     "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                     "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                     "..." "+++" "/==" "_|_" "www" "&&" "^=" "~~" "~="
                     "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                     "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                     ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                     "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                     "##" "#?" "#_" "%%" ".-" ".." ".?" "+>" "++" "?:"
                     "?=" "?." "??" ";;" "/*" "/>" "__" "~~" "(*" "*)"
                     "://"))
        )
    (ligature-set-ligatures 'prog-mode ligatures)    
    (ligature-set-ligatures 'sgml-mode ligatures)    
    )
  (global-ligature-mode t)
  )

(provide 'weiss_settings<ligature<ui)
