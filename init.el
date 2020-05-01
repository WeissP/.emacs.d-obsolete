(load "~/.emacs.d/config/weiss_init.el")


(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default-input-method "rime")
;;  '(dired-filter-saved-filters '(("swag" (name . "swag") (omit))))
;;  '(hs-special-modes-alist
;;    '((c-mode "{" "}" "/[*/]" nil nil)
;;      (c++-mode "{" "}" "/[*/]" nil nil)
;;      (rust-mode "{" "}" "/[*/]" nil nil)) t)
;;  '(package-selected-packages
;;    '(rainbow-mode org-rich-yank ob-ipython ob-rust ob-go ob-javascript telega visual-fill-column rime chinese-yasdcv pyim pyim-basedict flycheck-posframe posframe flycheck pkg-info epl cdlatex ob-fsharp fsharp-mode eglot org-bullets org-fancy-priorities ivy-dired-history dired-rsync dired-quick-sort dired-collapse dired-avfs dired-filter dired-hacks-utils aweshell gitignore-mode gitconfig-mode gitattributes-mode browse-at-remote git-messenger popup git-timemachine forge ghub treepy closql emacsql-sqlite emacsql magit git-commit with-editor async ivy-rich counsel-tramp counsel-world-clock flyspell-correct-ivy flyspell-correct ivy-xref ivy-yasnippet ivy-prescient amx counsel swiper ivy rg wgrep transient xah-elisp-mode php-mode live-py-mode yasnippet-snippets yasnippet lsp-mode lv markdown-mode company-quickhelp pos-tip company-box dash-functional company-prescient prescient company which-key sudo-edit expand-region anzu emojify ht dashboard page-break-lines popwin doom-modeline shrink-path f s all-the-icons memoize doom-themes keyfreq super-save esup auto-package-update dash diminish switch-buffer-functions quelpa-use-package hydra)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(flycheck-posframe-border-face ((t (:inherit default))))
;;  '(git-timemachine-minibuffer-author-face ((t (:inherit success))))
;;  '(git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
;;  '(ivy-minibuffer-match-face-1 ((t (:inherit font-lock-doc-face :foreground nil))))
;;  '(lsp-ui-doc-background ((t (:background nil))))
;;  '(lsp-ui-sideline-code-action ((t (:inherit warning))))
;;  '(org-ellipsis ((t (:foreground nil))))
;;  '(region ((t (:extend t :background "CadetBlue3"))))
;;  '(snails-select-line-face ((t (:background "#e5b781" :foreground "#fafafa" :slant italic)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-abort-manual-when-too-short t)
 '(company-begin-commands
   '(xah-fly-insert-mode-activate self-insert-command weiss-disable-abbrev-and-activate-insert-mode kill-line weiss-delete-forward-with-region weiss-delete-backward-with-region weiss-cut-line-or-delete-region))
 '(company-dabbrev-downcase nil)
 '(company-frontends
   '(company-tng-frontend company-pseudo-tooltip-frontend company-echo-metadata-frontend))
 '(company-global-modes '(not dired-mode dired-sidebar-mode))
 '(company-idle-delay 0.3)
 '(company-minimum-prefix-length 3)
 '(company-require-match nil)
 '(default-input-method "rime")
 '(hs-special-modes_'((c-mode "{" "}" "/[*/]" nil nil)
                      (c++-mode "{" "}" "/[*/]" nil nil)
                      (rust-mode "{" "}" "/[*/]" nil nil)) t)
 '(hs-special-modes-alist'((c-mode "{" "}" "/[*/]" nil nil)
                           (c++-mode "{" "}" "/[*/]" nil nil)
                           (rust-mode "{" "}" "/[*/]" nil nil)) t)
 '(package-selected-packagE'(rainbow-delimiters paredit yasnippet-snippets xah-elisp-mode which-key telega switch-buffer-functions super-save sudo-edit rotate-text rime rg rainbow-mode quelpa-use-package popwin php-mode peep-dired org-rich-yank org-fancy-priorities org-bullets ob-rust ob-javascript ob-ipython ob-go ob-fsharp lsp-ui lsp-python-ms lsp-origami lsp-julia lsp-java live-py-mode keyfreq ivy-yasnippet ivy-xref ivy-rich ivy-prescient ivy-dired-history gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger forge flyspell-correct-ivy flycheck-posframe expand-region esup emojify doom-themes doom-modeline diredfl dired-rsync dired-quick-sort dired-filter dired-collapse dired-avfs diminish dashboard counsel-world-clock counsel-tramp company-quickhelp company-prescient company-lsp company-box chinese-yasdcv cdlatex ccls browse-at-remote aweshell auto-package-update anzu amx all-the-icons-dired))
 '(package-selected-packages'(emacs-google-java-format flycheck-infer highlight-symbol meghanada quickrun ess auc-tikz nox magic-latex-buffer company-auctex org-edit-latex org-edit-latex-mode auctex webkit-katex-render tablist org-noter pdf-tools yasnippet-snippets xah-elisp-mode which-key telega switch-buffer-functions super-save sudo-edit rotate-text rime rg rainbow-mode rainbow-delimiters quelpa-use-package popwin php-mode peep-dired org-rich-yank org-fancy-priorities org-bullets ob-rust ob-javascript ob-ipython ob-go ob-fsharp lsp-ui lsp-python-ms lsp-origami lsp-julia lsp-java live-py-mode keyfreq ivy-yasnippet ivy-xref ivy-rich ivy-prescient ivy-dired-history gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger forge flyspell-correct-ivy flycheck-posframe expand-region esup emojify doom-themes doom-modeline diredfl dired-rsync dired-quick-sort dired-filter dired-collapse dired-avfs diminish dashboard counsel-world-clock counsel-tramp company-quickhelp company-prescient company-lsp company-box chinese-yasdcv cdlatex ccls browse-at-remote aweshell auto-package-update anzu amx all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-posframe-border-face ((t (:inherit default))))
 '(git-timemachine-minibuffer-author-face ((t (:inherit success))))
 '(git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
 '(ivy-minibuffer-match-face-1 ((t (:inherit font-lock-doc-face :foreground nil))))
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-sideline-code-action ((t (:inherit warning))))
 '(org-ellipsis ((t (:foreground nil)))))
