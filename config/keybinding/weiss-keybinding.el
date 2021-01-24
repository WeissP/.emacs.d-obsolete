;; -*- lexical-binding: t -*-
;; weiss-variable-mode

;; [[file:../emacs-config.org::*weiss-variable-mode][weiss-variable-mode:1]]
(defvar weiss-variable-mode-map (make-sparse-keymap) "Keybinding for weiss-temp-insert minor mode.")
(defvar weiss-variable-mode-start-point nil)
(defvar weiss-variable-snake-case-list '(python-mode))
(defvar weiss-variable-dash-case-list '(emacs-lisp-mode))

(defun weiss-variable-mode-enable ()
  "enable temp insert mode"
  (interactive)
  (setq weiss-variable-mode-start-point (point))
  )

(defun weiss-variable--process-string (s)
  "DOCSTRING"
  (interactive)
  (let ((l (split-string s " "))
        )
    (cond
     ((member major-mode weiss-variable-snake-case-list)
      (s-join "_" l)
      )     
     ((member major-mode weiss-variable-dash-case-list)
      (s-join "-" l)
      )     
     (t
      (concat (pop l) (mapconcat 'capitalize l "")))
     )
    )
  )

(defun weiss-variable-mode-disable ()
  "disable temp insert mode"
  (when (> (- (point) weiss-variable-mode-start-point) 3)
    (insert (weiss-variable--process-string (delete-and-extract-region weiss-variable-mode-start-point (point))))
    )
  (setq weiss-variable-mode-p nil)
  )

(defun weiss-variable-mode-start ()
  "DOCSTRING"
  (interactive)
  (unless ryo-modal-mode
    (weiss-variable-mode 1)
    (setq-local cursor-type 'hbar)
    )  
  )
(defun weiss-variable-mode-stop ()
  "DOCSTRING"
  (interactive)
  (weiss-variable-mode -1)
  (setq-local cursor-type 'box)
  (ryo-modal-mode)
  )
;; (define-key weiss-variable-mode-map (kbd "RET") 'weiss-temp-insert-exit-and-keep-content)
(define-key weiss-variable-mode-map [remap ryo-modal-mode] 'weiss-variable-mode-stop)
(advice-add 'keyboard-quit :before 'weiss-variable-mode-start)
;;;###autoload
(define-minor-mode weiss-variable-mode
  "Save selected text and activate insert mode, press enter to exit and keep the selected text. When direct go back to Command mode, the selected text will be deleted."
  :lighter " variable" ; set a simple mode name in the minor-mode-alist
  (if weiss-variable-mode
      (weiss-variable-mode-enable)
    (weiss-variable-mode-disable)
    )
  )


(provide 'weiss-variable-mode)
;; weiss-variable-mode:1 ends here

;; general


;; [[file:../emacs-config.org::*general][general:1]]
(define-key prog-mode-map (kbd "<tab>") 'weiss-indent)
(with-eval-after-load 'latex-mode
  (define-key latex-mode-map (kbd "<tab>") 'weiss-indent)
  (define-key LaTeX-mode-map (kbd "<tab>") 'weiss-indent)
  )

(with-eval-after-load 'sgml-mode
  (define-key sgml-mode-map (kbd "<tab>") 'weiss-indent)
  )
(global-set-key (kbd "<backtab>") 'indent-for-tab-command)
(global-set-key (kbd "<S-delete>") (lambda () (interactive) (insert "\\")))
(global-set-key (kbd "<f5>") 'revert-buffer)

(define-key key-translation-map (kbd "<f12>") (kbd "C-g"))

(use-package ryo-modal
  :commands ryo-modal-mode
  :bind ("M-m" . ryo-modal-mode) 
  :init 
  (defvar weiss/disable-ryo-list)
  (setq weiss/disable-ryo-list
        '(magit-mode magit-status-mode magit-revision-mode snails-mode ediff-mode telega-chat-mode telega-root-mode))

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

  (setq ryo-modal-cursor-color weiss/cursor-color)
  :config
  ;; the default cursor face config for cursor is wrong before dump.
  (defconst ryo-modal-default-cursor-color weiss/cursor-color  "Default color of cursor.")
  (defun ryo-modal-restart ()
    "restart ryo modal"
    (interactive)
    (ryo-modal-mode -1)
    (ryo-modal-mode 1)
    )

  (push '((nil . "ryo:.*:") . (nil . "")) which-key-replacement-alist)
  )

(use-package weiss-select-mode)
(use-package weiss-keybinding-functions)
(use-package weiss-temp-insert-mode)
(use-package weiss-overriding-ryo-mode)
(use-package weiss-origin-mode
  :config
  (push '(telega-chat-mode . ("<deletechar>")) weiss-origin-keep-keys)
  (let ((hook-list '(
                     magit-status-mode-hook
                     magit-mode-hook
                     telega-chat-mode-hook
                     telega-root-mode-hook
                     image-mode-hook
                     )))
    (dolist (x hook-list)
      (add-hook x 'weiss-origin-mode))
    )  
  (defun weiss-enable-origin-mode-only-in-fundamental-mode ()
    "only enable weiss-origin-mode when current major mode is plain fundamental-mode"
    (when (and (not weiss-origin-mode) (eq major-mode 'fundamental-mode))
      (weiss-origin-mode 1)
      )
    )
  ;; (add-to-list 'weiss/after-buffer-change-function-list 'weiss-enable-origin-mode-only-in-fundamental-mode)
  )
;; general:1 ends here

;; hydra

;; [[file:../emacs-config.org::*hydra][hydra:1]]
(use-package hydra)

(defhydra hydra-error (global-map "M-g")
  "goto-error"
  ("h" first-error "first")
  ("j" next-error "next")
  ("k" previous-error "prev")
  ("v" recenter-top-bottom "recenter")
  ("q" nil "quit"))

(defhydra hydra-resize-window (global-map "M-w")
  "resize window"
  ("k" shrink-window "height+")
  ("j" enlarge-window "height-")
  ("h" shrink-window-horizontally "width-")
  ("l" enlarge-window-horizontally "width+")
  ("q" nil "quit")
  )
(defhydra hydra-multiple-cursors-weiss (global-map "M-c" :hint nil)
  "
     ^Up^            ^Down^        ^Miscellaneous^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_q_] Quit"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("3" next-line)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("q" nil))

(defun weiss-test ()
  "DOCSTRING"
  (interactive)
  (set-temporary-overlay-map mc/mark-more-like-this-extended-keymap t))

(defhydra hydra-multiple-cursors (:color blue :hint nil)
  "
 Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search
 [Click] Cursor at point       [_q_] Quit"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("s" mc/mark-all-in-region-regexp :exit t)
  ("0" mc/insert-numbers :exit t)
  ("A" mc/insert-letters :exit t)
  ("<mouse-1>" mc/add-cursor-on-click)
  ;; Help with click recognition in this hydra
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore)
  ("q" nil))
;; hydra:1 ends here

;; quick-insert

;; [[file:../emacs-config.org::*quick-insert][quick-insert:1]]
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
         ((or ; cursor is not around "word"
           (not (looking-back "[w_\\-]"))
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
         ("w" ignore
          :then ((lambda () (interactive) (weiss-insert-bracket-pair "`" "'" quick-insert-new-line)))
          :name "insert elisp quote"
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

;; [[file:../emacs-config.org::*end][end:1]]
(provide 'weiss-keybinding)
;; end:1 ends here
