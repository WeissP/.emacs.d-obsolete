;; -*- lexical-binding: t -*-
;; weiss-temp-insert-mode

;; [[file:~/.emacs.d/config/emacs-config.org::*weiss-temp-insert-mode][weiss-temp-insert-mode:1]]
(defvar weiss-temp-insert-mode-map (make-sparse-keymap) "Keybinding for weiss-temp-insert minor mode.")
(defvar weiss-temp-insert-mode-p nil "nil")

(defun weiss-temp-insert-go-back-and-insert ()
  "DOCSTRING"
  (interactive)
  (when weiss-temp-insert-mode-selected-text (insert weiss-temp-insert-mode-selected-text))
  (when weiss-temp-insert-mode (weiss-temp-insert-mode -1))
  ;; (xah-fly-command-mode-activate)
  ;; (ryo-modal-mode 1)
  )

(defun weiss-temp-insert-go-back-without-insert ()
  "DOCSTRING"
  (interactive)
  (when weiss-temp-insert-mode (weiss-temp-insert-mode -1))
  )

(defun weiss-temp-insert-mode-enable ()
  "DOCSTRING"
  (interactive)
  (when weiss-select-mode (weiss-select-mode-turn-off))
  (setq weiss-temp-insert-mode-selected-text nil
        weiss-temp-insert-mode-p t)
  ;; (add-hook 'ryo-modal-mode-hook 'weiss-temp-insert-go-back-without-insert)
  ;; (add-hook 'xah-fly-keys-hook 'weiss-temp-insert-go-back-without-insert)
  (if (use-region-p)
      (setq weiss-temp-insert-mode-selected-text (delete-and-extract-region (region-beginning) (region-end)))
    (let ((bounds (ignore-errors (bounds-of-thing-at-point 'word ))))
      (setq weiss-temp-insert-mode-selected-text (ignore-errors (delete-and-extract-region (car bounds) (cdr bounds))))))
  ;; (xah-fly-insert-mode-activate)
  ;; (ryo-modal-mode -1)
  )

(defun weiss-temp-insert-mode-disable ()
  "DOCSTRING"
  (setq weiss-temp-insert-mode-p nil)
  ;; (remove-hook 'ryo-modal-mode-hook 'weiss-temp-insert-go-back-without-insert nil)
  ;; (remove-hook 'xah-fly-keys-hook 'weiss-temp-insert-go-back-without-insert nil)
  )

(define-key weiss-temp-insert-mode-map (kbd "RET") 'weiss-temp-insert-go-back-and-insert)
(define-key weiss-temp-insert-mode-map (kbd "<end>") 'weiss-temp-insert-go-back-without-insert)

;;;###autoload
(define-minor-mode weiss-temp-insert-mode
  "Save selected text and activate insert mode, press enter to go back and insert the selected text. When direct go back to Command mode, the selected text will be deleted."
  ;; t "temp" weiss-temp-insert-mode-map
  :lighter " temp" ; set a simple mode name in the minor-mode-alist
  (if weiss-temp-insert-mode
      (weiss-temp-insert-mode-enable)
    (weiss-temp-insert-mode-disable)
    )
  )

(provide 'weiss-temp-insert-mode)
;;; weiss-temp-insert-mode.el ends here
;; weiss-temp-insert-mode:1 ends here
