(setq weiss/modules
      '(
        (global :skip-install t) (table :skip-install t)
        rg (server :after-dump t :local t) quickrun esup which-key super-save keyfreq
        (wks
         :skip-install t
         :first (
                 ;; (weiss-select-mode :local t)
                 ;; (weiss-temp-insert-mode :local t)
                 hydra
                 ))
        (org
         :local t
         :first ((weiss-org-sp-mode :skip-install t))
         :then (
                (babel
                 :skip-install t
                 :first (
                         ob-fsharp ob-C ob-go ob-rust ob-java ob-sql-mode
                         (ob-javascript :github "zweifisch/ob-javascript"))
                 )
                (org-agenda :local t)
                (org-tempo :local t)
                (org-roam
                 :then (org-roam-server org-roam-protocol (org-transclusion :disabled t)))
                org-fancy-priorities
                (org-table-to-qmk-keymap :local t)
                (org-bullets :disabled t)
                (org-rich-yank :disabled t)
                )
         )
        (snails
         :local t
         :then (snails-roam))
        (dired
         :local t
         ;; :after-dump-all t
         :then (
                wdired diredfl all-the-icons-dired dired-hacks-utils dired-avfs dired-collapse
                dired-quick-sort peep-dired dired-filter (weiss-dired-single-handed-mode :local t)
                )
         )
        (counsel
         :then (amx prescient ivy-prescient ivy-rich)
         )
        (abbrevs :skip-install t)
        (latex
         ;; :skip-install t
         :local t
         :then (
                (ox-latex :local t)
                (org-edit-latex :local t)     
                magic-latex-buffer
                )
         )
        (ui     
         :skip-install t
         :then (
                (modeline :skip-install t) popwin
                (doom-modeline :after-dump t :disabled t) (nyan-mode :disabled t)
                highlight-indent-guides
                rainbow-mode highlight-parentheses hl-todo (color-outline :local t)
                highlight-symbol anzu hl-line web-beautify origami (whitespace :disabled t)
                (ligature :github "mickeynp/ligature.el")
                (all-the-icons :when (display-graphic-p) :after-dump t)
                command-log-mode emojify (hideshow :disabled t)
                (display-line-numbers :local t :after-dump t)
                (font-lock-face :skip-install t)
                )
         )
        (company :then (company-box))

        (rotate-text :github "nschum/rotate-text.el")
        (casease :github "DogLooksGood/casease")
        (shiftless :local t)
        expand-region    

        (js :skip-install t :then (js-format))
        json-mode
        (python :local t :then (yapfify ein))
        (http :then (auto-rename-tag)) (markdown-mode :local t) (cup-java-mode :local t)
        web-mode jastadd-ast-mode llvm-mode dockerfile-mode
        (go-mode
         :then (
                go-dlv go-impl go-fill-struct
                (flycheck-golangci-lint :disabled t)
                (go-tag :disabled t) (go-gen-test :disabled t) (gotest :disabled t)
                )
         )
        (sql :then ((sql-indent :github "alex-hhh/emacs-sql-indent")))

        (haskell :skip-install t :then ((hasky-stack :disabled t) ormolu))
        (lsp-mode
         :then (lsp-ui lsp-java lsp-python-ms ccls (lsp-haskell))
         )
        csv-mode
        (magit :then (
                      git-timemachine git-messenger browse-at-remote gitattributes-mode
                      gitignore-mode gitconfig-mode))
        (aweshell :github "manateelazycat/aweshell") (vterm :disabled t)
        (pdf-tools :then (pdf-view-restore))
        (flycheck :then ((flycheck-posframe :when (display-graphic-p))))
        (flyspell :skip-install t :then (wucuo))    
        (rime :local t :after-dump t)
        (telega :after-dump t)
        (yasdcv :local t)
        projectile maxima magit
        (tramp :after-dump-all t :local t :then (sudo-edit counsel-tramp docker-tramp))
        (recentf :after-dump t :local t)
        (emacs-yakuake :local t :after-dump t)
        (gcmh :after-dump t)
        ))

(provide 'weiss_modules)
