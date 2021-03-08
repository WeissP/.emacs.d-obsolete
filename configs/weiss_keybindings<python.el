(wks-define-key
 python-mode-map ""
 '(
   ("8" . weiss-execute-buffer-python)
   ("t e" . weiss-ein-execute-all-cells-above-inclusively)
   )
 )

;; (ryo-modal-keys
;;  (:mode 'python-mode)
;;  ("8" weiss-execute-buffer-python)
;;  ("t e" weiss-ein-execute-all-cells-above-inclusively)
;;  )

(provide 'weiss_keybindings<python)
