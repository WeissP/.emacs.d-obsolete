;; -*- lexical-binding: t -*-
;; rime
;; :PROPERTIES:
;; :header-args: :tangle rime/weiss-rime.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*rime][rime:1]]
(use-package rime
  :load-path "/home/weiss/.emacs.d/emacs-rime/"
  :ensure nil
  :custom
  (default-input-method "rime")
  :config
  (define-key global-map (kbd "<home>") 'toggle-input-method)

  (defun +rime-predicate-current-uppercase-letter-p ()
    "If the current charactor entered is a uppercase letter.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'."
    (and rime--current-input-key
         (>= rime--current-input-key ?A)
         (<= rime--current-input-key ?Z)))

  (defun +rime-predicate-current-input-punctuation-p ()
    "If the current charactor entered is a punctuation.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'."
    (and rime--current-input-key
         (or (and (<= #x21 rime--current-input-key) (<= rime--current-input-key #x2f))
             (and (<= #x3a rime--current-input-key) (<= rime--current-input-key #x40))
             (and (<= #x5b rime--current-input-key) (<= rime--current-input-key #x60))
             (and (<= #x7b rime--current-input-key) (<= rime--current-input-key #x7f)))))

  (defun +rime-predicate-punctuation-after-space-cc-p ()
    "If input a punctuation after a Chinese charactor with whitespace.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'.\""
    (and (> (point) (save-excursion (back-to-indentation) (point)))
         (+rime-predicate-current-input-punctuation-p)
         (looking-back "\\cc +" 2)))

  (defun +rime-predicate-after-special-punctuation-p ()
    "If the cursor is after a string prefixed a special punctuation.
Can be used in `rime-disable-predicates' and `rime-inline-predicates'."
    (and (> (point) (save-excursion (back-to-indentation) (point)))
         (looking-back "[@:/][a-zA-Z0-9-_]*" 1)))

  (defun weiss-rime-predicate-after-word-and-char-p ()
    "If the cursor is after [an ascii-word + space + an ascii-char]"
    (and (> (point) (save-excursion (back-to-indentation) (point)))
         (looking-back "[a-zA-Z] " 1)))

  (defun weiss-ryo-modal-mode-p ()
    "DOCSTRING"
    (interactive)
    ryo-modal-mode
    )

  (setq
   rime-show-candidate 'minibuffer
   rime-translate-keybindings  '("C-f" "C-b" "C-n" "C-p" "C-g")
   rime-inline-ascii-trigger 'control-r
   )

  (setq rime-disable-predicates
        '(
          weiss-ryo-modal-mode-p
          rime-predicate-after-alphabet-char-p
          rime-predicate-auto-english-p
          rime-predicate-punctuation-line-begin-p
          +rime-predicate-punctuation-after-space-cc-p
          +rime-predicate-after-special-punctuation-p
          ))

  (setq enter-rime-inline-predicates
        '(
          ;; rime-predicate-auto-english-p
          ;; rime--after-alphabet-char-p
          weiss-rime-predicate-after-word-and-char-p
          )
        )

  (defun enter-rime--should-inline-ascii-p ()
    "If we should toggle to inline ascii mode."
    (seq-find 'funcall enter-rime-inline-predicates))



  (defun weiss-rime-return ()
    "DOCSTRING"
    (interactive)
    (if (and (enter-rime--should-inline-ascii-p)
             (not (rime--ascii-mode-p))
             )
        (rime-inline-ascii)
      (rime--return)
      )
    )

  (define-key rime-active-mode-map (kbd "<return>") 'weiss-rime-return)

  (define-key rime-mode-map (kbd "C-n") 'rime-force-enable)

  ;; (add-hook 'telega-chat-mode-hook '(lambda () (set-input-method "rime")))
  ;; (remove-hook 'snails-mode-hook '(lambda () (set-input-method "")))
  ;; (add-hook 'eaf-edit-mode-hook '(lambda () (set-input-method "rime")))
  ;; (add-hook 'org-mode-hook '(lambda () (set-input-method "rime")))
  ;; (add-hook 'switch-buffer-functions 'weiss-activate-rime)
  )

;; (weiss-activate-rime)

;; (define-key global-map (kbd "<f4>") 'rime-send-keybinding)

(provide 'weiss-rime)
;; rime:1 ends here
