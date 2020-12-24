;; -*- lexical-binding: t -*-
;; multiple-cursors                                                


;; [[file:~/.emacs.d/config/emacs-config.org::*multiple-cursors][multiple-cursors:1]]
(use-package multiple-cursors
  :init
  ;; (add-hook 'multiple-cursors-mode-hook 'ryo-modal-restart)
  (setq mc/always-run-for-all t)
  :hook
  (multiple-cursors-mode . (lambda () (interactive)
                             (if multiple-cursors-mode
                                 (progn
                                   (weiss-overriding-define-key
                                    '(
                                      ("n" mc/mark-more-like-this-extended)
                                      ("j" next-line)
                                      ("k" previous-line)
                                      ("l" right-char)
                                      ("i" left-char)
                                      ("1" mc/cycle-backward)
                                      ("2" mc/cycle-forward)
                                      (";" right-charmc-hide-unmatched-lines-mode)
                                      ("u" left-charmc/mark-all-like-this-dwim)
                                      ("s" set-mark-command)
                                      )
                                    )
                                   (weiss-overriding-ryo-mode t)
                                   )
                               (weiss-overriding-ryo-mode -1)
                               )
                             ))
  :config
  (global-unset-key (kbd "S-<down-mouse-1>"))
  (global-set-key (kbd "S-<mouse-1>") 'mc/add-cursor-on-click)
  (global-set-key (kbd "C-c n") 'mc/mark-more-like-this-extended)
  (define-key mc/keymap (kbd "<return>") nil)
  ;; (defconst right-char-maybe
  ;;   '(menu-item "" right-char
  ;;               :filter (lambda (cmd) (and ryo-modal-mode cmd)))
  ;;   )
  ;; (global-set-key (kbd "C-n") right-char-maybe)
  )
;; multiple-cursors:1 ends here

;; rotate-text

;; [[file:~/.emacs.d/config/emacs-config.org::*rotate-text][rotate-text:1]]
(use-package rotate-text
  :quelpa (rotate-text
           :fetcher github
           :repo nschum/rotate-text.el
           )
  :diminish
  :config
  (setq rotate-text-words '(("true" "false")
                            ("nil" "t")
                            ("car" "cdr")
                            ("add" "remove")
                            ("width" "height")
                            ("left" "right")
                            ("top" "bottom")                            
                            ("Background" "Foreground")
                            ("background" "foreground")
                            ("next" "previous")
                            ("beginning" "end")
                            ("below" "above")
                            ("up" "down")
                            ("Up" "Down")
                            ("forward" "backward")
                            ("downward" "upward")
                            ("expand" "contract")
                            ("enable" "disable")
                            ("increase" "decrease")
                            ("shrink" "enlarge")
                            ("copy" "yank")
                            ("show" "hide")
                            ("start" "end")
                            ("min" "max")
                            ("on" "off")
                            ("ON" "OFF")
                            ("when" "unless")
                            ("even" "odd")
                            ("columns" "rows")
                            ("after" "before")
                            ;; Germany Language
                            ("der" "das" "die")
                            )))
;; rotate-text:1 ends here

;; misc

;; [[file:~/.emacs.d/config/emacs-config.org::*misc][misc:1]]
(use-package shiftless 
  :diminish
  :load-path "/home/weiss/.emacs.d/local-package/shiftless.el"
  :ensure nil
  :config
  (shiftless-programming)
  (setq shiftless-delay 0.6)
  (setq shiftless-interval 0.08)
  ;; (advice-add 'sp--post-self-insert-hook-handler :around #'shiftless--prevent-advice)
  (shiftless-mode 1)
  )

(use-package pcre2el
  :disabled
  :config
  )

(use-package expand-region)
;; misc:1 ends here

;; end

;; [[file:~/.emacs.d/config/emacs-config.org::*end][end:1]]
(provide 'weiss-edit)
;; end:1 ends here
