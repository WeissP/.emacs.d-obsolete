(setq
 org-link-frame-setup
 '(
   (vm . vm-visit-folder)
   (vm-imap . vm-visit-imap-folder)
   (gnus . gnus)
   (file . find-file)
   (wl . wl-frame))

 org-file-apps
 '((auto-mode . emacs)
   ("\\.mm\\'" . default)
   ("\\.x?html?\\'" . default)
   ("\\.pdf\\'" . emacs)
   ("\\.mp4\\'" . "vlc \"%s\"")
   ("\\.txt\\'" . emacs)
   ("\\.xopp\\'" . "xournalpp \"%s\"")
   )
 )

(provide 'weiss_open<org)
