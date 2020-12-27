;; -*- lexical-binding: t -*-
;; telega
;; :PROPERTIES:
;; :header-args: :tangle telega/weiss-telega.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:~/.emacs.d/config/emacs-config.org::*telega][telega:1]]
(use-package telega
  :hook
  ('telega-chat-mode . (lambda ()
                         (set (make-local-variable 'company-backends)
                              (append '(telega-company-emoji
                                        telega-company-username
                                        telega-company-hashtag)
                                      (when (telega-chat-bot-p telega-chatbuf--chat)
                                        '(telega-company-botcmd))))
                         (company-mode 1)
                         (linum-mode -1)
                         (emojify-mode)
                         )
                     )
  ('telega-root-mode . (lambda () 
                         (emojify-mode)
                         (linum-mode -1)
                         ))

  :config
  ;; (setq telega-server-libs-prefix "/usr/lib")
  (telega-notifications-mode 1)
  ;; :ryo
  ;; (:mode 'telega)
  ;; ("g" telega-chat-with)
  ;; ("n" next-line)
  ;; ("p" previous-line)
  :bind
  (
   :map telega-chat-mode-map
   ("j" . 'telega-button-forward)
   ("k" . 'telega-button-backward)
   ("K" . 'telega-msg-delete-marked-or-at-point)
   ("j" . telega-button-forward)
   )
  )

;; (require 'telega)

(provide 'weiss-telega)
;; telega:1 ends here
