(setq weiss-dumped-p t)

;; Disable GC
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(load "/home/weiss/.emacs.d/config/init/weiss-basic-and-misc.el")  

(load-theme 'doom-one-light t t)

(require 'weiss-keybinding)
(require 'weiss-edit)
(require 'weiss-completion)
(require 'weiss-lang)
(require 'weiss-ivy)
(require 'weiss-vcs)
(require 'weiss-shell-or-terminal)
(require 'weiss-dired)
(require 'weiss-org)
(require 'weiss-pdf)
(require 'weiss-flycheck)
(require 'weiss-translation)
(require 'weiss-snails)
(require 'weiss-sql)
(require 'weiss-rime)
(require 'weiss-latex)
(require 'weiss-telega)
(require 'weiss-abbrev-mode)
(require 'weiss-project)
(require 'weiss-lsp)
(require 'weiss-ui)


(load "/home/weiss/.emacs.d/recentf")

;; We have to unload tramp in pdump, otherwise tramp will not work.
(tramp-unload-tramp)

(save-place-mode -1)


(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
