(with-eval-after-load 'casease
  (advice-add 'weiss--ahf-indent :after #'casease--end)
  (advice-add 'weiss--ahf :after #'casease--end)
  (casease-setup
   :hook java-mode-hook
   :separator ?-
   :entries
   ((pascal "\\(=\\)[a-z]" "[A-Z]")
    (snake "\\(\\,\\)[a-z]")
    (camel "[a-z]")
    ))
  (casease-setup
   :hook c++-mode-hook
   :separator ?-
   :entries
   ((pascal "\\(=\\)[a-z]" "[A-Z]")
    (camel "[a-z]")
    ))
  (casease-setup
   :hook go-mode-hook
   :separator ?-
   :entries
   ((pascal "\\(=\\)[a-z]" "[A-Z]")
    (camel "[a-z]")))
  (casease-setup
   :hook python-mode-hook
   :separator ?-
   :entries
   ((pascal "\\(=\\)[a-z]" "[A-Z]")
    (snake "[a-z]")))

  )

(provide 'weiss_settings<casease)
