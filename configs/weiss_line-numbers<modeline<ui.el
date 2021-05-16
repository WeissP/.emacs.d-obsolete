(defvar weiss-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'weiss-mode-line-buffer-line-count)

(defun weiss-mode-line-count-lines ()
  (setq weiss-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'weiss-mode-line-count-lines)
(add-hook 'after-save-hook 'weiss-mode-line-count-lines)
(add-hook 'after-revert-hook 'weiss-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'weiss-mode-line-count-lines)

(provide 'weiss_line-numbers<modeline<ui)
