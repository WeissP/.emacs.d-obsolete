(menu-bar-mode -1)
(tool-bar-mode -1)
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; (ignore-errors (savehist-mode 1))
;; (save-place-mode 1)

(set-face-attribute 'region nil :background "#e8f2ff")

(when (file-exists-p (expand-file-name "~/.emacs.d/emacs.pdmp"))
  (setq package-enable-at-startup nil
        file-name-handler-alist nil
        auto-window-vscroll nil))
