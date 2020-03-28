;;; Require
(require 'snails-core)
(require 'bookmark)

;;; Code:

(defun filter--check-if-mode (buf mode)
  "Check if buf is in some mode. mode is a string"
  (interactive)
  (string-match mode (format "%s" (with-current-buffer buf major-mode))))

(snails-create-sync-backend
 :name
 "FILE-BOOKMARK"

 :candidate-filter
 (lambda (input)
   (let (candidates)
     (dolist (bookmark (bookmark-all-names))
       (when (and 
              (> (length input) 1)
              (not (or 
                    (string-match " " bookmark)
                    (and (snails-match-input-p input "org" ) (string-match "\\.org$" bookmark) )
                    ))
              (or
               (string-equal input "")
               (snails-match-input-p input bookmark))
              )
         (snails-add-candiate 'candidates bookmark bookmark)))
     (snails-sort-candidates input candidates 0 0)
     candidates))

 :candidate-icon
 (lambda (candidate)
   (snails-render-file-icon candidate))


 :candidate-do
 (lambda (candidate)
   (find-file (bookmark-get-filename candidate))))

(provide 'snails-backend-file-bookmark)

