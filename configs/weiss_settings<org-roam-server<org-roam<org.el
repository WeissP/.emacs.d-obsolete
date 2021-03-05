(with-eval-after-load 'org-roam-server
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 9090
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20)
  )

(provide 'weiss_settings<org-roam-server<org-roam<org)
