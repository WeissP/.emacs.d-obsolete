;;; snails-backend-eaf-web-search.el --- Search or search in brwoser backend for snails

;; Filename: snails-backend-eaf-web-search.el
;; Author: weiss
;; Description:
;; web serach with keywords
;; Tip: put this into the first backend, because it only occurs when you type correct keywords.

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.


;;; Require
(require 'snails-core)

;;; Code:

(snails-create-sync-backend
 :name
 "EAF-WEB-SEARCH"

 :candidate-filter
 (lambda (input)
   (let (candidates)
     (when (and (ignore-errors (require 'eaf))
                (> (length input) 2))
       (let ((head (substring input 0 3))
             (tail (substring input 3))
             )
         (cond
          ((string= head "bt ") (snails-add-candiate 'candidates (format "Search in BTSOW %s" tail) (concat btsow-adress tail)))
          ((string= head "ec ") (snails-add-candiate 'candidates (format "Search in Emacs China: %s" tail) (concat "https://emacs-china.org/search?q=" tail)))
          ((string= head "yt ") (snails-add-candiate 'candidates (format "Search in YouTube: %s" tail) (concat "https://www.youtube.com/results?search_query=" tail)))            
          )
         ))
     candidates))

 :candidate-do
 (lambda (candidate)
   (eaf-open candidate "browser")
   ))

(provide 'snails-backend-eaf-web-search)

;;; snails-backend-eaf-web-search.el ends here
