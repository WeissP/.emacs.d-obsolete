;; -*- lexical-binding: t -*-
;; weiss-temp-insert-mode

;; [[file:~/.emacs.d/config/emacs-config.org::*weiss-temp-insert-mode][weiss-temp-insert-mode:1]]
(defvar weiss-temp-insert-mode-map (make-sparse-keymap) "Keybinding for weiss-temp-insert minor mode.")
(defvar weiss-temp-insert--overlay-content)
(defface weiss-temp-insert-selected-text-face
  '((t (:strike-through t :foreground "#e45649" :background "#f0f0f0" :weight bold)))
  "Default face for selected text.")

(defun weiss-temp-insert-exit-and-keep-content ()
  "exit mode and keep content"
  (interactive)
  (weiss-temp-insert--remove-overlay t)
  (when weiss-temp-insert-mode (weiss-temp-insert-mode -1))
  (ryo-modal-mode 1)
  )

(defun weiss-temp-insert-exit-and-remove-content ()
  "exit mode and remove contetn"
  (interactive)
  (weiss-temp-insert--remove-overlay nil)
  (when weiss-temp-insert-mode (weiss-temp-insert-mode -1))
  (ryo-modal-mode 1)
  )

(defun weiss-temp-insert--set-overlay (p1 p2)
  "set overlay between p1 and p2"
  (interactive)
  ;; it's not necessary to show space at p1
  (let ((str (buffer-substring-no-properties (1+ p1) p2)))
    (setq weiss-temp-insert--overlay-content (make-overlay p1 p2 nil t))
    (overlay-put weiss-temp-insert--overlay-content 'face 'weiss-temp-insert-selected-text-face)
    (overlay-put weiss-temp-insert--overlay-content 'display str)
    ))


(defun weiss-temp-insert--remove-overlay (&optional keep-content)
  "delete the overlay"
  (interactive)
  (when (overlayp weiss-temp-insert--overlay-content)
    (let ((p1 (overlay-start weiss-temp-insert--overlay-content))
          (p2 (overlay-end weiss-temp-insert--overlay-content)))
      (delete-overlay weiss-temp-insert--overlay-content)      
      (setq weiss-temp-insert--overlay-content nil)
      (if keep-content
          (delete-region p1 (1+ p1))    
        (delete-region p1 p2)                
        )
      ))
  )

(defun weiss-temp-insert-mode-enable ()
  "enable temp insert mode"
  (interactive)
  (undo-collapse-begin)
  (when weiss-select-mode (weiss-select-mode-turn-off))
  (setq weiss-temp-insert-mode-selected-text nil
        weiss-temp-insert-mode-p t)
  (let (p1 p2)
    (if (use-region-p)
        (progn
          (setq p1 (region-beginning)
                p2 (region-end))
          (goto-char p1)
          (deactivate-mark)
          )
      (setq p2 (point))
      (skip-syntax-backward "\\w")
      (setq p1 (point))
      ) 
    ;; insert a space to make sure that completion works 
    (save-excursion (insert " "))
    (weiss-temp-insert--set-overlay p1 (1+ p2))
    )
  )

(defun weiss-temp-insert-mode-disable ()
  "disable temp insert mode"
  (undo-collapse-end)
  (setq weiss-temp-insert-mode-p nil)
  )

(define-key weiss-temp-insert-mode-map (kbd "RET") 'weiss-temp-insert-exit-and-keep-content)
(define-key weiss-temp-insert-mode-map [remap ryo-modal-mode] 'weiss-temp-insert-exit-and-remove-content)

;;;###autoload
(define-minor-mode weiss-temp-insert-mode
  "Save selected text and activate insert mode, press enter to exit and keep the selected text. When direct go back to Command mode, the selected text will be deleted."
  :lighter " temp" ; set a simple mode name in the minor-mode-alist
  (if weiss-temp-insert-mode
      (weiss-temp-insert-mode-enable)
    (weiss-temp-insert-mode-disable)
    )
  )


(provide 'weiss-temp-insert-mode)
;; weiss-temp-insert-mode:1 ends here
