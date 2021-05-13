(setq weiss-dumped-p t)

;; Disable GC
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(load "/home/weiss/.emacs.d/configs/weiss_startup.el")

(load-theme 'doom-one-light t t)

(load "/home/weiss/.emacs.d/recentf")

(load "/home/weiss/.emacs.d/dumped-packages.el")

;; We have to unload tramp in pdump, otherwise tramp will not work.
(tramp-unload-tramp)

(save-place-mode -1)

(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
