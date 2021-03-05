(defvar weiss-org-sp-mode-map (make-sparse-keymap))

(define-minor-mode weiss-org-sp-mode
  "weiss-org-sp-mode"
  :keymap weiss-org-sp-mode-map
  (if weiss-org-sp-mode
      (progn
        (weiss-overriding-ryo-push-map weiss-org-sp-mode weiss-org-sp-mode-map)
        (add-hook 'ryo-modal-mode-hook 'weiss-org-sp--push-keymap)
        )
    (setq minor-mode-overriding-map-alist (assq-delete-all 'weiss-org-sp-mode minor-mode-overriding-map-alist))
    (remove-hook 'ryo-modal-mode 'weiss-org-sp--push-keymap)
    )
  )

(defun weiss-org-sp--push-keymap ()
  "DOCSTRING"
  (interactive)
  (when ryo-modal-mode
    (weiss-overriding-ryo-push-map weiss-org-sp-mode weiss-org-sp-mode-map))  
  )

;; only work in special position
(let ((key-cmd-list '(
                      ("j" weiss-org-sp-down)
                      ("k" weiss-org-sp-up)
                      ("i" weiss-org-sp-left)
                      ("l" weiss-org-sp-right)
                      ("r" weiss-org-refile)
                      ("v" org-paste-special)
                      ("w" org-narrow-to-subtree)
                      ))
      (fun (lambda (cmd) (interactive) (when (and ryo-modal-mode (weiss-org-sp--special-p))  cmd))))
  (weiss-overriding-ryo-define-key weiss-org-sp-mode-map key-cmd-list fun)  
  )

;; only work in heading or #+ block begin and there is no region
(let ((key-cmd-list '(
                      ("c" weiss-org-sp-copy)
                      ("d" weiss-org-sp-cut)
                      ))
      (fun (lambda (cmd) (interactive)
             (when (and ryo-modal-mode
                        (not (use-region-p))
                        (or (org-at-heading-p) (looking-at-p weiss-org-sp-sharp-begin))) cmd))))
  (weiss-overriding-ryo-define-key weiss-org-sp-mode-map key-cmd-list fun)  
  )

(provide 'weiss_define-mode<weiss-org-sp-mode<org)
