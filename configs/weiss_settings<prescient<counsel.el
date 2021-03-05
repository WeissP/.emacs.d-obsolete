(setq prescient-filter-method '(literal regexp initialism fuzzy))
(with-eval-after-load 'prescient
  (prescient-persist-mode 1)
  )

(provide 'weiss_settings<prescient<counsel)
