;; -*- lexical-binding: t -*-
(defvar weiss-write-mode-map (make-sparse-keymap) "Keybinding for weiss-write minor mode.")
(defvar weiss-write-info--overlay-content)
(defvar weiss-write-info--sep "°€°")

(setq weiss-write-mode-switch-scirpt-path "/home/weiss/Python/emacs-edit/emacs-edit.py")

(defface weiss-write-info-face
  '((t (:foreground "#FF9D72" :weight bold :font "lato")))
  "Default face for weiss-write-info.")

(defun weiss-write-mode-set-overlay ()
  "DOCSTRING"
  (interactive)
  (goto-char (point-min))
  (let ((s (split-string
            (s-trim (buffer-substring-no-properties (point) (line-end-position)))
            weiss-write-info--sep))
        )
    (setq weiss-write-info--overlay-content
          (make-overlay (line-beginning-position) (line-end-position)))
    (overlay-put weiss-write-info--overlay-content 'face 'weiss-write-info-face)
    (overlay-put weiss-write-info--overlay-content 'display
                 (format "ID:%s Name:%s" (nth 0 s) (nth 1 s)))
    )
  )

(defun weiss-edit-with-emacs (id name)
  "DOCSTRING"
  (interactive)
  (select-frame-set-input-focus (weiss-write-new-frame))  
  (switch-to-buffer "*weiss-write*")
  (weiss-write-mode t)
  (insert (format "%s%s%s\n\n" id weiss-write-info--sep name))
  (weiss-write-mode-set-overlay)
  (goto-line 2)
  )

(defun weiss-write-new-frame ()
  "DOCSTRING"
  (interactive)
  (let ((f '((tool-bar-lines . 0)
             (width . 63) ; chars
             (height . 15) ; lines
             (left . 555)
             (top . 1185)))
        )
    (make-frame f)
    )
  )

(defun weiss-write-mode-enable ()
  "DOCSTRING"
  (interactive)
  (wks-vanilla-mode-enable)
  (call-interactively 'toggle-input-method)
  (rime-force-enable)
  )

(defun weiss-write-mode-disable ()
  "DOCSTRING"
  (interactive)
  (when (string= (buffer-name) "*weiss-write*")
    (goto-char (point-min))
    (let ((info (split-string
                 (s-trim (buffer-substring-no-properties (point) (line-end-position)))
                 weiss-write-info--sep)) 
          s
          )
      (goto-line 2)
      (setq s (s-trim-right (buffer-substring-no-properties (line-beginning-position) (point-max))))
      (delete-frame)    
      (ignore-errors (kill-buffer "*weiss-write*"))      
      (let ((select-enable-clipboard t))
        (kill-new s))      
      (shell-command (format "python %s %s \'%s\'"
                             weiss-write-mode-switch-scirpt-path
                             (nth 0 info)
                             (nth 1 info)))
      )
    )
  )

(wks-define-key
 weiss-write-mode-map ""
 '(
   ("<return>" . weiss-write-mode)
   ))

;;;###autoload
(define-minor-mode weiss-write-mode
  "Save selected text and activate insert mode, press enter to exit and keep the selected text. When direct go back to Command mode, the selected text will be deleted."
  :lighter " write" ; set a simple mode name in the minor-mode-alist
  :keymap weiss-write-mode-map
  (if weiss-write-mode
      (weiss-write-mode-enable)
    (weiss-write-mode-disable)
    )
  )



(provide 'weiss_weiss-write-mode<wks)
