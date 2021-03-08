(with-eval-after-load 'hydra
  (defhydra hydra-kmacro (:foreign-keys run :hint nil)
    "
_f_ call with func    _d_ call in region             _C-g_ deactivate-mark
_e_ call infinite     _s_ call                         _q_ Quit
"
    ("f" weiss-call-kmacro)
    ("e" weiss-call-kmacro-infinite :exit t)
    ("s" call-last-kbd-macro)
    ("d" weiss-call-kmacro-dwim  :exit t)
    ("1" weiss-apply-macro-1)
    ("2" weiss-apply-macro-2)
    ("3" weiss-apply-macro-3)
    ("4" weiss-apply-macro-4)
    ("5" weiss-apply-macro-5)
    ("6" weiss-apply-macro-6)
    ("7" weiss-apply-macro-7)
    ("8" weiss-apply-macro-8)
    ("9" weiss-apply-macro-9)
    ("0" weiss-apply-macro-0)
    ("C-g" (deactivate-mark))  
    ("q" nil nil)
    )

  (defhydra hydra-error (global-map "M-g")
    "goto-error"
    ("h" first-error "first")
    ("j" next-error "next")
    ("k" previous-error "prev")
    ("v" recenter-top-bottom "recenter")
    ("q" nil "quit"))

  (defhydra hydra-resize-window (global-map "M-w")
    "resize window"
    ("k" shrink-window "height+")
    ("j" enlarge-window "height-")
    ("h" shrink-window-horizontally "width-")
    ("l" enlarge-window-horizontally "width+")
    ("q" nil "quit")
    )
  )

(provide 'weiss_hydras<hydra<wks)
