;; -*- lexical-binding: t -*-
;; format/indent

;; [[file:~/.emacs.d/config/emacs-config.org::*format/indent][format/indent:1]]
(use-package web-beautify)
(use-package origami)
;; format/indent:1 ends here

;; icons

;; [[file:~/.emacs.d/config/emacs-config.org::*icons][icons:1]]
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

;; [[file:~/.emacs.d/config/emacs-config.org::*end][end:1]]
(provide 'weiss-ui)
;; end:1 ends here

;; out of use

;; [[file:~/.emacs.d/config/emacs-config.org::*out of use][out of use:1]]
(use-package rainbow-blocks
  :disabled
  :hook (xah-elisp-mode . rainbow-blocks-mode)
  :config  
  )

(use-package highlight-indent-guides 
  :disabled
  :diminish
  :config
  (defun my-highlighter (level responsive display)
    ;; (if (or (< level 2)(= 0 (mod level 2)))
    ;; (if (= 0 (mod level 2))
    (if (or (< level 1))
        nil
      (highlight-indent-guides--highlighter-default level responsive display)))
  ;; character style
  ;; (setq highlight-indent-guides-method 'character)
  ;; (setq highlight-indent-guides-character ?\>)
  ;; (setq highlight-indent-guides-highlighter-function 'my-highlighter)

  ;; column style
  (setq highlight-indent-guides-auto-enabled nil)
  (setq highlight-indent-guides-method 'column)
  ;; (setq highlight-indent-guides-auto-odd-face-perc #a9a9a9)
  (set-face-background 'highlight-indent-guides-odd-face "#f5f5f5")
  (set-face-background 'highlight-indent-guides-even-face "#FAFAFA")
  ;; (setq highlight-indent-guides-auto-even-face-perc 15)
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
