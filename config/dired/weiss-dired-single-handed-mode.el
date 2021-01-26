;; -*- lexical-binding: t -*-
;; weiss-dired-single-handed-mode
;; :PROPERTIES:
;; :header-args: :tangle dired/weiss-dired-single-handed-mode.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*weiss-dired-single-handed-mode][weiss-dired-single-handed-mode:1]]
(define-minor-mode weiss-dired-single-handed-mode
  "weiss-dired-single-handed-mode"
  :lighter " single-hand"
  :group 'weiss-dired-single-handed-mode
  (if weiss-dired-single-handed-mode
      (progn
        (weiss-overriding-define-key
         '(
           ("x" hydra-dired-quick-sort/body)
           ("d" next-line)
           ("e" previous-line)
           ("f" xah-open-in-external-app)
           ("g" (lambda()(interactive)(dired-find-alternate-file)(weiss-dired-single-handed-mode)))
           ("q" weiss-dired-single-handed-mode)
           ("s" (lambda()(interactive)(find-alternate-file "..")(weiss-dired-single-handed-mode)))
           ("v" hydra-dired-filter-actress/body)
           ("c" hydra-dired-filter-tag/body)
           )
         )
        ;; (make-local-variable cursor-type)
        ;; (setq cursor-type nil)
        ;; (hl-line-mode nil)
        ;; (set (make-local-variable 'hl-line-face) 'emphasis-hl-line)
        ;; (hl-line-mode t)
        (weiss-overriding-ryo-mode 1)
        )
    ;; (setq cursor-type t)
    ;; (hl-line-mode -1)
    (weiss-overriding-ryo-mode -1)    
    )
  )

(provide 'weiss-dired-single-handed-mode)
;; weiss-dired-single-handed-mode:1 ends here
