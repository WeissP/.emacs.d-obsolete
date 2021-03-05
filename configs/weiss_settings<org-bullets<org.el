(add-hook 'org-mode-hook org-bullets-mode)

(with-eval-after-load 'org-bullets
  (setq  org-bullets-bullet-list '("◉" "◆" "●" "◇" "○" "→" "·" ))
  ;; “♰” “☥” “✞” “✟” “✝” “†” “✠” “✚” “✜” “✛” “✢” “✣” “✤” “✥” “♱” "✙”  "◉"  "○" "✸" "✿" ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
  )

(provide 'weiss_settings<org-bullets<org)
