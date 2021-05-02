(with-eval-after-load 'super-save
  (add-to-list 'super-save-triggers 'find-file)
  (add-to-list 'super-save-triggers 'org-edit-special)
  (add-to-list 'super-save-triggers 'other-frame)
  (add-to-list 'super-save-triggers 'select-frame-set-input-focus)
  (add-to-list 'super-save-triggers 'dired-jump)
  (super-save-mode +1)
  )

(provide 'weiss_settings<super-save)

