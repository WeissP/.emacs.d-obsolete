(setq flyspell-issue-message-flag nil
      ispell-program-name "hunspell"
      ispell-extra-args '("--sug-mode=ultra" "--run-together"))
(setq ispell-dictionary "de_DE,en_US")

(with-eval-after-load 'flyspell
  ;; ispell-set-spellchecker-params has to be called
  ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "de_DE,en_US")

  (defun weiss-flyspell-save-word ()
    "From https://stackoverflow.com/questions/22107182/in-emacs-flyspell-mode-how-to-add-new-word-to-dictionary"
    (interactive)
    (let ((current-location (point))
          (word (flyspell-get-word)))
      (when (consp word)    
        (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))
  )

(provide 'weiss_settings<flyspell)
