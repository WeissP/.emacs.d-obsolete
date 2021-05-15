(with-eval-after-load 'telega
  (add-hook 'telega-chat-mode-hook #'(lambda ()
                                       (set (make-local-variable 'company-backends)
                                            (append '(telega-company-emoji
                                                      telega-company-username
                                                      telega-company-hashtag)
                                                    (when (telega-chat-bot-p telega-chatbuf--chat)
                                                      '(telega-company-botcmd))))
                                       (company-mode 1)
                                       (emojify-mode)
                                       ))

  (add-hook 'telega-root-mode-hook #'(lambda () 
                                       (emojify-mode)
                                       ))


  (defun weiss-get-telega-marked-text ()
    "Delete marked messages in chatbuf.
If `\\[universal-argument]' is specified, then kill
messages (delete for me only), otherwise revoke message (delete
for everyone).
If chatbuf is supergroups, channels or secret chat, then always revoke."
    (interactive)
    (when-let ((marked-messages (or (reverse telega-chatbuf--marked-messages)
                                    (when-let ((msg-at-point (telega-msg-at (point))))
                                      (list msg-at-point)))))
      ;; (message ": %s" (length marked-messages))
      (mapconcat (lambda (msg) (telega-tl-str (plist-get msg :content) :text)) marked-messages "\n\n")    
      ))

  (defun weiss-telega-copy-msg ()
    "DOCSTRING"
    (interactive)
    (if (use-region-p)
        (xah-copy-line-or-region)        
      (kill-new (weiss-get-telega-marked-text))
      )
    )

  (setq telega-open-file-function 'org-open-file)
  ;; (setq telega-server-libs-prefix "/usr/lib")
  (telega-notifications-mode 1)
  )

(provide 'weiss_settings<telega)
