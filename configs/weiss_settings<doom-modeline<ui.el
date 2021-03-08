(setq doom-modeline-window-width-limit fill-column
      ;; doom-modeline-project-detection
      ;; doom-modeline-buffer-file-name-style 'relative-to-project
      ;; doom-modeline-bar-width 6
      doom-modeline-window-width-limit 110
      )

(with-eval-after-load 'doom-modeline
(defsubst doom-modeline--wks ()
  "The current `wks' state."
  ;; (when (bound-and-true-p xah-fly-keys)
  (if wks-vanilla-mode
      (doom-modeline--modal-icon " <I> "
                                 'doom-modeline-evil-insert-state
                                 (format "wks insert mode"))
    (doom-modeline--modal-icon " <C> "
                               'doom-modeline-evil-normal-state
                               (format "wks command mode")))
  ;; )
  )

(doom-modeline-def-segment modals
  "Displays modal editing states, including `evil', `overwrite', `god', `ryo'
and `xha-fly-kyes', etc."
  (let* ((evil (doom-modeline--evil))
         (ow (doom-modeline--overwrite))
         (god (doom-modeline--god))
         (ryo (doom-modeline--ryo))
         (xf (doom-modeline--xah-fly-keys))
         (boon (doom-modeline--boon))
         (vsep (doom-modeline-vspc))
         (wks (doom-modeline-wks))
         (sep (and (or evil ow god wks ryo xf boon) (doom-modeline-spc))))
    (concat sep
            (and wks (concat wks (and (or ow god ryo xf boon evil) vsep)))
            (and evil (concat evil (and (or ow god ryo xf boon) vsep)))
            (and ow (concat ow (and (or god ryo xf boon) vsep)))
            (and god (concat god (and (or ryo xf boon) vsep)))
            (and ryo (concat ryo (and (or xf boon) vsep)))
            (and xf (concat xf (and boon vsep)))
            boon
            sep)))
)
;; (setq doom-modeline-minor-modes t)
(line-number-mode -1)
(add-hook 'after-init-hook #'doom-modeline-mode)

(provide 'weiss_settings<doom-modeline<ui)
