(setq weiss-dumped-p t)

;; Disable GC
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(load "/home/weiss/.emacs.d/config/init/weiss-startup.el")

(load-theme 'doom-one-light t t)

(load "/home/weiss/.emacs.d/recentf")

;; We have to unload tramp in pdump, otherwise tramp will not work.
(tramp-unload-tramp)

(save-place-mode -1)


(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
