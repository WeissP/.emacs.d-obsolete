;; -*- lexical-binding: t -*-
;; general


;; [[file:~/.emacs.d/config/emacs-config.org::*general][general:1]]
(use-package weiss-select-mode
  :load-path "/home/weiss/.emacs.d/local-package/"
  )
(use-package weiss-keybinding-functions)
(use-package weiss-temp-insert-mode)
(use-package weiss-overriding-ryo-mode)
(use-package hydra)

(global-set-key (kbd "<backtab>") 'weiss-indent)
(global-set-key (kbd "<S-delete>") (lambda () (interactive) (insert "\\")))

(define-key key-translation-map (kbd "<f12>") (kbd "C-g"))

(defhydra hydra-error (global-map "M-g")
  "goto-error"
  ("h" first-error "first")
  ("j" next-error "next")
  ("k" previous-error "prev")
  ("v" recenter-top-bottom "recenter")
  ("q" nil "quit"))

(use-package ryo-modal
  :commands ryo-modal-mode
  :bind ("M-m" . ryo-modal-mode) 
  :init 
  (defvar weiss/disable-ryo-list)
  (setq weiss/disable-ryo-list
    '(magit-mode magit-status-mode snails-mode))

  (defun weiss-check-ryo ()
    "enable or disable ryo by disable-ryo-list"
    (interactive)
    (if (member major-mode weiss/disable-ryo-list)
        (when ryo-modal-mode (ryo-modal-mode -1))

      (unless ryo-modal-mode (ryo-modal-mode 1))    
      )
    )

  (add-to-list 'weiss/after-buffer-change-function-list 'weiss-check-ryo)
  (add-to-list 'weiss/after-major-mode-function-list 'weiss-check-ryo)

  (add-to-list 'weiss/after-major-mode-function-list 'weiss-change-delimiters-list)  

  (setq ryo-modal-cursor-color weiss/cursor-color)
  :config
  (defun ryo-modal-restart ()
    "restart ryo modal"
    (interactive)
    (ryo-modal-mode -1)
    (ryo-modal-mode 1)
    )

  (push '((nil . "ryo:.*:") . (nil . "")) which-key-replacement-alist)
)
;; general:1 ends here

;; quick-insert

;; [[file:~/.emacs.d/config/emacs-config.org::*quick-insert][quick-insert:1]]
(defvar quick-insert-new-line nil)
(defvar quick-insert-if-exit-ryo nil)

;; comes from xah-fly-key
(defun weiss-insert-bracket-pair (@left-bracket @right-bracket &optional @new-line)
  "Insert brackets around selection, word, at point, and maybe move cursor in between. If @new-line is non-nil, insert then with new line.
• if there's a region, add brackets around region.
• If cursor is at end of a word or buffer, one of the following will happen, insert brackets directly
• wrap brackets around word if any. e.g. xy▮z → (xyz▮). Or just (▮)
"
  (if (use-region-p)
      (progn ; there's active region
        (let (
              ($p1 (region-beginning))
              ($p2 (region-end)))
          (goto-char $p2)
          (when @new-line (insert "\n"))
          (insert @right-bracket)
          (goto-char $p1)
          (insert @left-bracket)
          (when @new-line (insert "\n"))
          (goto-char (+ $p2 2))))
    (progn ; no text selection
      (let ($p1 $p2)
        (cond
         ((or ; cursor is at end of word or buffer. i.e. xyz▮
           (looking-at "[^-_[:alnum:]]")
           (eq (point) (point-max)))
          (progn
            (setq $p1 (point) $p2 (point))
            (if @new-line
                (insert @left-bracket "\n\n" @right-bracket)
              (insert @left-bracket @right-bracket)  
              )            
            (search-backward @right-bracket)
            (when @new-line (previous-line))
            ))
         (t (progn
              ;; wrap around “word”. basically, want all alphanumeric, plus hyphen and underscore, but don't want space or punctuations. Also want chinese chars
              (skip-chars-backward "-_[:alnum:]")
              (setq $p1 (point))
              (skip-chars-forward "-_[:alnum:]")
              (setq $p2 (point))
              (goto-char $p2)
              (when @new-line (insert "\n"))
              (insert @right-bracket)
              (goto-char $p1)
              (insert @left-bracket)
              (when @new-line (insert "\n"))
              (goto-char (+ $p2 (length @left-bracket)))))))))
  (when quick-insert-if-exit-ryo
    (ryo-modal-mode -1)
    (setq quick-insert-if-exit-ryo nil)
    )
  )

(let (
      (quick-insert
       '(
         ("j" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "(" ")" quick-insert-new-line)))
          :name "insert paren")
         ("k" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "[" "]" quick-insert-new-line)))
          :name "insert square bracket"
          )
         ("l" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "{" "}" quick-insert-new-line)))
          :name "insert brace"
          )
         (";" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "\"" "\"" quick-insert-new-line)))
          :name "insert double quote"
          )

         ("'" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "'" "'" quick-insert-new-line)))
          :name "insert single quote")
         ("9" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "\\(" "\\)" quick-insert-new-line)))
          :name "insert escape paren"
          )
         ("[" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "\\[" "\\]" quick-insert-new-line)))
          :name "insert escape square bracket"
          )
         ("]" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "\\{" "\\}" quick-insert-new-line)))
          :name "insert escape brace"
          )
         ("-" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "_" "_" quick-insert-new-line)))
          :name "insert underline"
          )
         ("=" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "=" "=" quick-insert-new-line)))
          :name "insert equals"
          )
         ("a" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "|" "|" quick-insert-new-line)))
          :name "insert bar"
          )
         ("q" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "`" "`" quick-insert-new-line)))
          :name "insert markdown quote"
          )
         ("s" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "*" "*" quick-insert-new-line)))
          :name "insert star"
          )
         ("/" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "/" "/" quick-insert-new-line)))
          :name "insert slash"
          )
         ("4" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "$" "$" quick-insert-new-line)))
          :name "insert dollar"
          )
         ("7" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "&" "&" quick-insert-new-line)))
          :name "insert and"
          )
         ("m" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "<" ">" quick-insert-new-line)))
          :name "insert angle bracket"
          )
         ("<deletechar>" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "\\" "\\" quick-insert-new-line)))
          :name "insert backslash"
          )
         ("RET" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "\\n" "" quick-insert-new-line)))
          :name "insert newline"
          )

         )
       ))
  (eval `(ryo-modal-keys          
          ("<escape>" ,quick-insert)          
          ))
  (eval `(ryo-modal-keys
          ("<escape> n" ,quick-insert
           :first '((lambda () (interactive) (setq quick-insert-new-line t)))
           :then '((lambda () (interactive)
                     (setq quick-insert-new-line nil)
                     (weiss-indent-nearby-lines)
                     (indent-according-to-mode)
                     ))
           )          
          ))
  )
(defun weiss-quick-insert ()
  "Use quick insert ryo keymap in normal mode"
  (interactive)
  (ryo-modal-mode 1)
  (setq quick-insert-if-exit-ryo t)
  ;; simulate escape key
  (setq unread-command-events (listify-key-sequence (kbd "<escape>")))
  )
(global-set-key (kbd "<escape>") 'weiss-quick-insert)
;; quick-insert:1 ends here

;; end

;; [[file:~/.emacs.d/config/emacs-config.org::*end][end:1]]
(provide 'weiss-keybinding)
;; end:1 ends here
