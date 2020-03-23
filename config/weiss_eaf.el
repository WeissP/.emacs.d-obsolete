(use-package eaf
  :straight nil
  ;; :defer nil
  :load-path "/home/weiss/.emacs.d/emacs-application-framework"
  :custom
  (eaf-find-alternate-file-in-dired t)
  :bind
  (
   :map eaf-mode-map
        ("M-c" . eaf-get-path-or-url)
        )
  :config

  (setq browse-url-browser-function 'eaf-open-browser)
  (defalias 'browse-web #'eaf-open-browser)

  (defun weiss-eaf-insert-multi-lines ()
    (interactive)
    (eaf-proxy-edit_focus_text)
    (make-local-variable 'shiftless-upper-rules)
    (shiftless-Umlaut)
    )

  (defun weiss-eaf-edit-buffer-confirm ()
    (interactive)
    (eaf-edit-buffer-confirm)
    ;; (sleep-for 0.5)
    (eaf-call "send_key" eaf--buffer-id "TAB")
    )

  (defun weiss-eaf-insert-single-line ()
    "insert single line with paste"
    (interactive)
    (kill-new (read-string "Input: "))
    (eaf-proxy-yank_text)
    ;; (eaf-call "send_key" eaf--buffer-id "RET")
    )
  
  (defun enter-key ()
    "DOCSTRING"
    (interactive)
    (eaf-call "send_key" eaf--buffer-id "RET")  
    )

  (defun show-key ()
    "DOCSTRING"
    (interactive)
    (message  (key-description (this-command-keys-vector)))
    )

  
  (defun weiss-eaf-bookmark-set ()
    (interactive)
    (bookmark-set (read-string "Set EAF Bookmark: " (concat " " (buffer-name)))) )

  (eaf-bind-key xah-fly-leader-key-map "SPC" eaf-browser-keybinding)
  (eaf-bind-key weiss-eaf-insert-multi-lines "I" eaf-browser-keybinding)
  (eaf-bind-key weiss-eaf-insert-single-line "i" eaf-browser-keybinding)
  (eaf-bind-key xah-next-window-or-frame "0" eaf-browser-keybinding)
  (eaf-bind-key insert_or_scroll_down_page "1" eaf-browser-keybinding)
  (eaf-bind-key insert_or_scroll_up_page "2" eaf-browser-keybinding)
  (eaf-bind-key delete-other-windows "3" eaf-browser-keybinding)
  (eaf-bind-key split-window-below "4" eaf-browser-keybinding)
  (eaf-bind-key open_link_new_buffer "a" eaf-browser-keybinding)
  (eaf-bind-key snails-normal-backends "s" eaf-browser-keybinding)
  (eaf-bind-key open_link "f" eaf-browser-keybinding)
  (eaf-bind-key open_link_background_buffer "F" eaf-browser-keybinding)
  (eaf-bind-key copy_text "c" eaf-browser-keybinding)
  (eaf-bind-key yank_text "C-v" eaf-browser-keybinding)
  (eaf-bind-key weiss-eaf-bookmark-set "m" eaf-browser-keybinding)
  (eaf-bind-key insert_or_scroll_down_page "e" eaf-browser-keybinding)
  (eaf-bind-key snails-eaf-backends "t" eaf-browser-keybinding)
  (eaf-bind-key request_close_buffer "x" eaf-browser-keybinding)
  ;; (eaf-bind-key eaf-send-key-sequence "C-<return>" eaf-browser-keybinding)
  ;; (eaf-bind-key enter-key "<return>" eaf-browser-keybinding)


  (eaf-bind-key toggle-input-method "C-f" eaf-browser-keybinding)

  (eaf-bind-key xah-next-window-or-frame "0" eaf-js-video-player-keybinding)
  (eaf-bind-key xah-fly-leader-key-map "SPC" eaf-js-video-player-keybinding)
  
  (define-key eaf-edit-mode-map (kbd "C-j") 'weiss-eaf-edit-buffer-confirm)
  )

