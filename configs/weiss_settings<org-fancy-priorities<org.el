(add-hook 'org-mode-hook #'org-fancy-priorities-mode)

(with-eval-after-load 'org-fancy-priorities
  (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")
        org-priority-faces '((65 :foreground "#de3d2f" :weight bold)
                             (66 :foreground "#da8548" :weight bold)
                             (67 :foreground "#0098dd")))
  )

(provide 'weiss_settings<org-fancy-priorities<org)
