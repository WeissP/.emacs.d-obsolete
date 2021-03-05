(add-hook 'after-init-hook #'ivy-mode)
(add-hook 'ivy-mode-hook #'counsel-mode)

(setq enable-recursive-minibuffers t) ; Allow commands in minibuffers

(setq ivy-use-selectable-prompt t
      ivy-use-virtual-buffers t    ; Enable bookmarks and recentf
      ivy-height 10
      ivy-fixed-height-minibuffer t
      ivy-count-format "(%d/%d) "
      ivy-on-del-error-function nil
      ivy-initial-inputs-alist nil)

(setq swiper-action-recenter t)

(setq counsel-find-file-at-point t
      counsel-yank-pop-separator "\n────────\n")

;; Use the faster search tool: ripgrep (`rg')
(when (executable-find "rg")
  (setq counsel-grep-base-command "rg -S --no-heading --line-number --color never %s %s")
  )

(with-eval-after-load 'counsel
  (with-no-warnings
    ;; Display an arrow with the selected item
    (defun my-ivy-format-function-arrow (cands)
      "Transform CANDS into a string for minibuffer."
      (ivy--format-function-generic
       (lambda (str)
         (concat (if (display-graphic-p)
                     (all-the-icons-octicon "chevron-right" :height 0.8 :v-adjust -0.05)
                   ">")
                 (propertize " " 'display `(space :align-to 2))
                 (ivy--add-face str 'ivy-current-match)))
       (lambda (str)
         (concat (propertize " " 'display `(space :align-to 2)) str))
       cands
       "\n"))
    ;; (setf (alist-get 't ivy-format-functions-alist) #'my-ivy-format-function-arrow)

    ;; Pre-fill search keywords
    ;; @see https://www.reddit.com/r/emacs/comments/b7g1px/withemacs_execute_commands_like_marty_mcfly/
    (defvar my-ivy-fly-commands
      '(query-replace-regexp
        flush-lines keep-lines ivy-read
        swiper swiper-backward swiper-all
        swiper-isearch swiper-isearch-backward
        lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol
        counsel-grep-or-swiper counsel-grep-or-swiper-backward
        counsel-grep counsel-ack counsel-ag counsel-rg counsel-pt))
    (defvar-local my-ivy-fly--travel nil)

    (defun my-ivy-fly-back-to-present ()
      (cond ((and (memq last-command my-ivy-fly-commands)
                  (equal (this-command-keys-vector) (kbd "M-p")))
             ;; repeat one time to get straight to the first history item
             (setq unread-command-events
                   (append unread-command-events
                           (listify-key-sequence (kbd "M-p")))))
            ((or (memq this-command '(self-insert-command
                                      ivy-forward-char end-of-line mwim-end-of-line
                                      mwim-end-of-code-or-line mwim-end-of-line-or-code
                                      yank ivy-yank-word counsel-yank-pop))
                 (equal (this-command-keys-vector) (kbd "M-n")))
             (unless my-ivy-fly--travel
               (delete-region (point) (point-max))
               (when (memq this-command '(ivy-forward-char
                                          end-of-line mwim-end-of-line
                                          mwim-end-of-code-or-line
                                          mwim-end-of-line-or-code ))
                 (insert (ivy-cleanup-string ivy-text)))
               (setq my-ivy-fly--travel t)))))

    (defun my-ivy-fly-time-travel ()
      (when (memq this-command my-ivy-fly-commands)
        (let* ((kbd (kbd "M-n"))
               (cmd (key-binding kbd))
               (future (and cmd
                            (with-temp-buffer
                              (when (ignore-errors
                                      (call-interactively cmd) t)
                                (buffer-string))))))
          (when future
            (save-excursion
              (insert (propertize (replace-regexp-in-string
                                   "\\\\_<" ""
                                   (replace-regexp-in-string
                                    "\\\\_>" ""
                                    future))
                                  'face 'shadow)))
            (add-hook 'pre-command-hook 'my-ivy-fly-back-to-present nil t)))))

    (add-hook 'minibuffer-setup-hook #'my-ivy-fly-time-travel)
    (add-hook 'minibuffer-exit-hook
              (lambda ()
                (remove-hook 'pre-command-hook 'my-ivy-fly-back-to-present t)))

    ;; Improve search experience of `swiper' and `counsel'
    ;; @see https://emacs-china.org/t/swiper-swiper-isearch/9007/12
    (defun my-swiper-toggle-counsel-rg ()
      "Toggle `counsel-rg' and `swiper-isearch' with the current input."
      (interactive)
      (ivy-quit-and-run
        (if (eq (ivy-state-caller ivy-last) 'swiper-isearch)
            (counsel-rg ivy-text default-directory)
          (swiper-isearch ivy-text))))
    (bind-key "<C-return>" #'my-swiper-toggle-counsel-rg swiper-map)
    (bind-key "<C-return>" #'my-swiper-toggle-counsel-rg counsel-ag-map)

    (with-eval-after-load 'rg
      (defun my-swiper-toggle-rg-dwim ()
        "Toggle `rg-dwim' with the current input."
        (interactive)
        (ivy-quit-and-run
          (rg-dwim default-directory)))
      (bind-key "<M-return>" #'my-swiper-toggle-rg-dwim swiper-map)
      (bind-key "<M-return>" #'my-swiper-toggle-rg-dwim counsel-ag-map))

    (defun my-swiper-toggle-swiper-isearch ()
      "Toggle `swiper' and `swiper-isearch' with the current input."
      (interactive)
      (ivy-quit-and-run
        (if (eq (ivy-state-caller ivy-last) 'swiper-isearch)
            (swiper ivy-text)
          (swiper-isearch ivy-text))))
    (bind-key "<S-return>" #'my-swiper-toggle-swiper-isearch swiper-map)

    (defun my-counsel-find-file-toggle-fzf ()
      "Toggle `counsel-fzf' with the current `counsel-find-file' input."
      (interactive)
      (ivy-quit-and-run
        (counsel-fzf (or ivy-text "") default-directory)))
    (bind-key "<C-return>" #'my-counsel-find-file-toggle-fzf counsel-find-file-map)

    ;; Prettify `counsel-imenu'
    (defun my-counsel-imenu-get-candidates-from (alist &optional prefix)
      "Create a list of (key . value) from ALIST.
PREFIX is used to create the key."
      (cl-mapcan
       (lambda (elm)
         (if (imenu--subalist-p elm)
             (counsel-imenu-get-candidates-from
              (cl-loop for (e . v) in (cdr elm) collect
                       (cons e (if (integerp v) (copy-marker v) v)))
              ;; pass the prefix to next recursive call
              (concat prefix (if prefix ".") (car elm)))
           (let ((key (concat
                       (when prefix
                         (if (display-graphic-p)
                             (progn
                               (pcase prefix
                                 ("Packages"
                                  (setq prefix (all-the-icons-faicon "archive" :height 0.9 :v-adjust -0.05 :face 'all-the-icons-silver)))
                                 ((or "Types" "Type")
                                  (setq prefix (all-the-icons-faicon "wrench" :height 0.9 :v-adjust -0.05)))
                                 ((or "Functions" "Function")
                                  (setq prefix (all-the-icons-faicon "cube" :height 0.95 :v-adjust -0.05 :face 'all-the-icons-purple)))
                                 ((or "Variables" "Variable")
                                  (setq prefix (all-the-icons-octicon "tag" :height 0.95 :v-adjust 0 :face 'all-the-icons-lblue)))
                                 ("Class"
                                  (setq prefix (all-the-icons-material "settings_input_component" :height 0.9 :v-adjust -0.15 :face 'all-the-icons-orange))))
                               (concat prefix "\t"))
                           (concat
                            (propertize prefix 'face 'ivy-grep-info)
                            ": ")))
                       (car elm))))
             (list (cons key
                         (cons key (if (overlayp (cdr elm))
                                       (overlay-start (cdr elm))
                                     (cdr elm))))))))
       alist))
    (advice-add #'counsel-imenu-get-candidates-from :override #'my-counsel-imenu-get-candidates-from)

    ;; Integration with `magit'
    (with-eval-after-load 'magit
      (setq magit-completing-read-function 'ivy-completing-read)))
  )

(provide 'weiss_settings<counsel)
