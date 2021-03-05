(add-hook 'python-mode #'highlight-indent-guides-mode)

(with-eval-after-load 'highlight-indent-guides
  ;; (defun my-highlighter (level responsive display)
  ;;   ;; (if (or (< level 2)(= 0 (mod level 2)))
  ;;   ;; (if (= 0 (mod level 2))
  ;;   (if (or (< level 1))
  ;;       nil
  ;;     (highlight-indent-guides--highlighter-default level responsive display)))
  ;; character style
  ;; (setq highlight-indent-guides-method 'character)
  ;; (setq highlight-indent-guides-character ?\>)
  ;; (setq highlight-indent-guides-highlighter-function 'my-highlighter)

  ;; column style
  (setq highlight-indent-guides-auto-enabled nil)
  (setq highlight-indent-guides-method 'character)
  (set-face-attribute 'highlight-indent-guides-character-face nil :foreground "gray")
  ;; (setq highlight-indent-guides-auto-odd-face-perc #a9a9a9)
  ;; (set-face-background 'highlight-indent-guides-odd-face "#a9a9a9")
  ;; (set-face-background 'highlight-indent-guides-even-face "#FAFAFA")
  ;; (setq highlight-indent-guides-auto-even-face-perc 15)
  )

(provide 'weiss_settings<highlight-indent-guides<ui)
