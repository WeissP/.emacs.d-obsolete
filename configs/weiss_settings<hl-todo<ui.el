(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("STUB"   . "#1E90FF")))

(with-eval-after-load 'hl-todo
  (defhydra hydra-todo (global-map "M-t")
    "goto-todo"
    ("o" hl-todo-occur "occur")
    ("j" hl-todo-next "next")
    ("k" hl-todo-previous "prev")
    ("i" hl-todo-insert "insert")
    ("q" nil "quit"))
  (global-hl-todo-mode)
  )

(provide 'weiss_settings<hl-todo<ui)
