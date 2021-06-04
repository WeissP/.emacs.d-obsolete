(setq tramp-default-method "ssh")
(setq tramp-terminal-type "tramp")
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(provide 'weiss_settings<tramp)
