;;; Require
(require 'snails-core)
(require 'bookmark)

;;; Code:

(snails-create-sync-backend
 :name
 "FILE-BOOKMARK"

 :candidate-filter
 (lambda (input)
   (let (candidates)
     (dolist (bookmark (bookmark-all-names))
       (when (and 
              (> (length input) 2)
              (not (string-match " " bookmark))
              (not (string-match "snails tips" bookmark))
              (or
               (string-equal input "")
               (snails-match-input-p input bookmark))
              )
         (snails-add-candiate 'candidates (snails-wrap-file-icon bookmark) bookmark)))
     (snails-sort-candidates input candidates 0 0)
     candidates))

 :candiate-do
 (lambda (candidate)
   (find-file (bookmark-get-filename candidate))))

(provide 'snails-backend-file-bookmark)

