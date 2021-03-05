(with-eval-after-load 'org
  (advice-add 'org-edit-special
              :after
              '(lambda () (interactive)
                 (maximize-window)
                 (weiss-shrink-window-if-larger-than-buffer nil (/ (frame-height) 3))))
  )

(provide 'weiss_org-edit-special<org)
