(with-eval-after-load 'ryo-modal
  (defvar weiss/disable-ryo-list)
  (setq weiss/disable-ryo-list
        '(magit-mode magit-status-mode magit-revision-mode snails-mode ediff-mode telega-chat-mode telega-root-mode org-agenda-mode))

  (defun weiss-check-ryo ()
    "enable or disable ryo by disable-ryo-list"
    (interactive)
    (if (member major-mode weiss/disable-ryo-list)
        (when ryo-modal-mode (ryo-modal-mode -1))
      (unless ryo-modal-mode (ryo-modal-mode 1))    
      )
    )

  ;; (add-to-list 'weiss/after-buffer-change-function-list 'weiss-check-ryo)
  ;; (add-to-list 'weiss/after-major-mode-function-list 'weiss-check-ryo)

  (setq ryo-modal-cursor-color weiss/cursor-color)
  :config
  ;; the default cursor face config for cursor is wrong before dump.
  (defconst ryo-modal-default-cursor-color weiss/cursor-color  "Default color of cursor.")
  (defun ryo-modal-restart ()
    "restart ryo modal"
    (interactive)
    (ryo-modal-mode -1)
    (ryo-modal-mode 1)
    )

  (push '((nil . "ryo:.*:") . (nil . "")) which-key-replacement-alist)
  )

(provide 'weiss_miscs<ryo-modal<ks)
