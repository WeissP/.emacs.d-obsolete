;; -*- lexical-binding: t -*-
;; projectile
;; :PROPERTIES:
;; :header-args: :tangle project/weiss-project.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*projectile][projectile:1]]
(use-package projectile
  :bind
  (:map
   projectile-mode-map
   ("C-c C-p" . 'projectile-command-map))
  :init
  (projectile-global-mode 1))

(provide 'weiss-project)
;; projectile:1 ends here
