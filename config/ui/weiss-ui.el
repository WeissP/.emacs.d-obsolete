;; -*- lexical-binding: t -*-
;; themes

;; [[file:../emacs-config.org::*themes][themes:1]]
(use-package doom-themes)
;; themes:1 ends here

;; format/indent

;; [[file:../emacs-config.org::*format/indent][format/indent:1]]
(use-package web-beautify)
(use-package origami)
;; format/indent:1 ends here

;; Functions

;; [[file:../emacs-config.org::*Functions][Functions:1]]
(defun weiss-toggle-hl-line ()
  "toggle hl line using weiss-enable-hl-line"
  (interactive)
  (if hl-line-mode
      (hl-line-mode -1)
    (weiss-enable-hl-line)
    )
  )

(defun weiss-enable-hl-line ()
  "change hl line face by major-mode"
  (interactive)
  (unless (eq major-mode 'snails-mode)
    (hl-line-mode -1)
    (cond
     (weiss-dired-single-handed-mode
      (set (make-local-variable 'hl-line-face) 'emphasis-hl-line)
      )
     ((eq major-mode 'dired-mode)
      (set (make-local-variable 'hl-line-face) 'normal-hl-line)
      )
     (t (set (make-local-variable 'hl-line-face) 'box-hl-line))
     )
    (hl-line-mode 1)
    )
  )
;; Functions:1 ends here

;; icons

;; [[file:../emacs-config.org::*icons][icons:1]]
;; NOTE: Must run `M-x all-the-icons-install-fonts', and install fonts manually 
(use-package all-the-icons 
  :diminish
  :if (display-graphic-p)
  :config
  (add-to-list 'all-the-icons-mode-icon-alist '(xah-elisp-mode all-the-icons-fileicon "elisp" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(eaf-mode all-the-icons-alltheicon "atom" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(debugger-mode all-the-icons-faicon "bug" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(telega-root-mode all-the-icons-fileicon "telegram" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist '(telega-chat-mode all-the-icons-material "chat" :height 1.0 :v-adjust -0.2 :face all-the-icons-purple))
  (with-no-warnings
    (defun all-the-icons-reset ()
      "Reset (unmemoize/memoize) the icons."
      (interactive)
      (dolist (f '(all-the-icons-icon-for-file
                   all-the-icons-icon-for-mode
                   all-the-icons-icon-for-url
                   all-the-icons-icon-family-for-file
                   all-the-icons-icon-family-for-mode
                   all-the-icons-icon-family))
        (ignore-errors
          (memoize-restore f)
          (memoize f)))
      (message "Reset all-the-icons"))))
;; icons:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-ui)
;; end:1 ends here

;; out of use

;; [[file:../emacs-config.org::*out of use][out of use:1]]
(use-package rainbow-blocks
  :disabled
  :hook (xah-elisp-mode . rainbow-blocks-mode)
  :config  
  )

(use-package elispfl 
  :diminish
  :disabled
  :quelpa (elispfl :type git
                   :host github
                   :repo "cireu/elispfl")
  :hook (elisp-mode . elispfl-mode))

(use-package rainbow-delimiters
  :disabled
  :hook (prog-mode . (lambda () (interactive) (unless (eq major-mode 'java-mode) (rainbow-delimiters-mode-enable)))))

(use-package hideshow 
  :disabled
  :diminish
  :ensure nil
  :diminish hs-minor-mode
  :bind (:map prog-mode-map
              ("C-c TAB" . hs-toggle-hiding)
              ("M-+" . hs-show-all))
  :hook (prog-mode . hs-minor-mode)
  :custom
  (hs-special-modes-alist
   (mapcar 'purecopy
           '((c-mode "{" "}" "/[*/]" nil nil)
             (c++-mode "{" "}" "/[*/]" nil nil)
             (rust-mode "{" "}" "/[*/]" nil nil)))))
;; out of use:1 ends here
