(defun ivy-prescient-non-fuzzy (str)
  "Generate an Ivy-formatted non-fuzzy regexp list for the given STR.
This is for use in `ivy-re-builders-alist'."
  (let ((prescient-filter-method '(literal regexp)))
    (ivy-prescient-re-builder str)))

(setq ivy-prescient-retain-classic-highlighting t
      ivy-re-builders-alist
      '((counsel-ag . ivy-prescient-non-fuzzy)
        (counsel-rg . ivy-prescient-non-fuzzy)
        (org-refile . ivy-prescient-non-fuzzy)
        (org-roam-find-file . ivy-prescient-non-fuzzy)
        (org-roam-insert . ivy-prescient-non-fuzzy)
        (counsel-recentf . ivy-prescient-non-fuzzy)
        (counsel-bookmark . ivy-prescient-non-fuzzy)
        (counsel-pt . ivy-prescient-non-fuzzy)
        (counsel-grep . ivy-prescient-non-fuzzy)
        (counsel-imenu . ivy-prescient-non-fuzzy)
        (counsel-org-goto . ivy-prescient-non-fuzzy)
        (counsel-org-goto-all . ivy-prescient-non-fuzzy)
        ;; (counsel-M-x . ivy-prescient-non-fuzzy)
        (counsel-yank-pop . ivy-prescient-non-fuzzy)
        (swiper . ivy-prescient-non-fuzzy)
        (swiper-isearch . ivy-prescient-non-fuzzy)
        (swiper-all . ivy-prescient-non-fuzzy)
        (ivy-switch-buffer . ivy-prescient-non-fuzzy)
        (lsp-ivy-workspace-symbol . ivy-prescient-non-fuzzy)
        (lsp-ivy-global-workspace-symbol . ivy-prescient-non-fuzzy)
        (insert-char . ivy-prescient-non-fuzzy)
        (counsel-unicode-char . ivy-prescient-non-fuzzy)
        (t . ivy-prescient-re-builder))
      ivy-prescient-sort-commands
      '(:not swiper swiper-isearch ivy-switch-buffer
             counsel-grep counsel-git-grep counsel-ag counsel-imenu
             counsel-yank-pop counsel-recentf counsel-buffer-or-recentf))

(ivy-prescient-mode 1)

(provide 'weiss_settings<ivy-prescient<counsel)
