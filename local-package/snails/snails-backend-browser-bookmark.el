;;; Require
(require 'snails-core)
(require 'bookmark)

;;; Code:

(snails-create-sync-backend
 :name
 "BROWSER-BOOKMARK"

 :candidate-filter
 (lambda (input)
   (let (candidates)
     (dolist (bookmark (bookmark-all-names))
       (when (and (string-match " " bookmark) (or
                                                 (string-equal input "")
                                                 (snails-match-input-p input bookmark))
                  )
         (snails-add-candiate 'candidates bookmark bookmark)))
     (snails-sort-candidates input candidates 0 0)
     candidates))

 :candidate-do
 (lambda (candidate)
   (bookmark-jump candidate)))

(provide 'snails-backend-browser-bookmark)


