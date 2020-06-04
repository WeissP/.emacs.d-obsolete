;;; snails-backend-eaf-bangou-search.el --- Search or search in brwoser backend for snails

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
 "EAF-BANGOU-SEARCH"

 :candidate-filter
 (lambda (input)
   (let (candidates)
     (when (and (ignore-errors (require 'eaf))
                (string-match "^[[:word:]]\\{2,5\\}-?[[:digit:]]\\{3,5\\}$" input))
       (snails-add-candiate 'candidates (format "Search in FANZA: %s" input) (concat "FAN" input))
       (snails-add-candiate 'candidates (format "Search in BTSOW: %s" input) (concat "BTS" input))
       (snails-add-candiate 'candidates (format "Search in JAVLibrary: %s" input) (concat "JAV" input))
       )

     candidates))

 :candidate-do
 (lambda (candidate)
   (let ((head (substring candidate 0 3))
         (tail (substring candidate 3)))
     (cond
      ((string-equal head "JAV") (eaf-open (concat "http://www.javlibrary.com/cn/vl_searchbyid.php?keyword=" tail) "browser"))
      ((string-equal head "BTS") (eaf-open (concat btsow-adress tail) "browser"))
      ((string-equal head "FAN")
       (if (string-match "-" tail) ; convert ssni447 or ssni-447 to ssni00447
           (eaf-open (concat "https://www.dmm.co.jp/search/=/searchstr=" (replace-regexp-in-string "-" "00" tail)) "browser")        
         (eaf-open (concat "https://www.dmm.co.jp/search/=/searchstr=" (replace-regexp-in-string "\\([[:digit:]]\\{2,4\\}\\)" "00\\1" tail)) "browser"))
       )
      )
     )))

(provide 'snails-backend-eaf-bangou-search)

;;; snails-backend-eaf-bangou-search.el ends here


