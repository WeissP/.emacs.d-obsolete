;;; snails-backend-filter-buffer.el --- Buffer switch backend for snails

;; Filename: snails-backend-filter-buffer.el
;; Description: Buffer switch backend for snails
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2019, Andy Stewart, all rights reserved.
;; Created: 2019-07-23 16:43:17
;; Version: 0.1
;; Last-Updated: 2019-07-23 16:43:17
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/snails-backend-filter-buffer.el
;; Keywords:
;; Compatibility: GNU Emacs 26.2
;;
;; Features that might be required by this library:
;;
;;
;;

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

;;; Commentary:
;;
;; Buffer switch backend for snails
;;

;;; Installation:
;;
;; Put snails-backend-filter-buffer.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'snails-backend-filter-buffer)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET snails-backend-filter-buffer RET
;;

;;; Change log:
;;
;; 2019/07/23
;;      * First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require
(require 'snails-core)

;;; Code:

(setq snails-backend-filter-buffer-blacklist
      (list
       snails-input-buffer
       snails-content-buffer
       " *code-conversion-work*"
       " *Echo Area "
       " *Minibuf-"
       " *Custom-Work*"
       " *pyim-page-tooltip-posframe-buffer*"
       " *load"
       " *server"
       " *snails tips*"
       "*eaf*"
       " *company-box-"
       " *emacsql"
       " *org-src-fontification:"
       " *which-key"
       " *counsel"
       " *temp file*"
       "*dashboard*"
       "*straight-process*"
       " *telega-server*"
       "*tramp/"
       " *Org todo*"
       " *popwin dummy*"
       ))

(setq snails-backend-filter-buffer-whitelist
      (list
       "*scratch*"
       "*Messages*"
       "backup_"
       ;; "*eaf*"
       "*Telega Root*"
       ))

(setq snails-backend-filter-buffer-blacklist-RegEx 
      (list
       ;; "\*....\-....\-....\-....\-....\-....\-...."
       "\*.*" 
       ;; ".*"
       )
      )

(defun snails-backend-filter-buffer-whitelist-buffer (buf)
  (let ((r nil))
    (dolist (whitelist-buf snails-backend-filter-buffer-whitelist r)
      (when (string-prefix-p whitelist-buf (buffer-name buf))
        (setq r t)))
    )
  )

(defun snails-backend-filter-buffer-not-blacklist-buffer (buf)
  (catch 'failed
    (dolist (backlist-buf snails-backend-filter-buffer-blacklist)
      (when (string-prefix-p backlist-buf (buffer-name buf))
        (throw 'failed nil)))
    t))

(defun snails-backend-filter-buffer-not-blacklist-buffer-RegEx (buf)
  (catch 'failed
    (dolist (backlist-buf snails-backend-filter-buffer-blacklist-RegEx)
      (when (string-match backlist-buf (buffer-name buf))
        (throw 'failed nil)))
    t))

(defun weiss-buffer-name-limit (str limit-number)
  "DOCSTRING"
  (interactive)
  (if (> (length str) limit-number)
      (substring str 0 limit-number)
    str
    )
  )

(defun filter--check-if-mode (buf mode)
  "Check if buf is in some mode. mode is a string"
  (interactive)
  (string-match mode (format "%s" (with-current-buffer buf major-mode))))




(snails-create-sync-backend
 :name
 "FILTER-BUFFER"

 :candidate-filter
 (lambda (input)
   (let (candidates)
     ;; (let ((rest-buffer-list (cdr (buffer-list))))
     ;; (dolist (buf rest-buffer-list)
     (dolist (buf (buffer-list))
       (when (and (not  (or 
                         (string= current-buf-name (buffer-name buf))
                         (and (filter--check-if-mode buf "org") (snails-match-input-p input "org"))
                         ))
                  (or (and (snails-backend-filter-buffer-whitelist-buffer buf)
                           (snails-match-input-p input (buffer-name buf)))
                      (and
                       ;; (snails-backend-filter-buffer-not-blacklist-buffer buf)
                       (snails-backend-filter-buffer-not-blacklist-buffer-RegEx buf)
                       (or
                        (string-equal input "")
                        (snails-match-input-p input (buffer-name buf))
                        (and (filter--check-if-mode buf "eaf") (snails-match-input-p input (concat "eaf " (buffer-name buf))))
                        (and (filter--check-if-mode buf "dired") (snails-match-input-p input (concat "di " (buffer-name buf))))
                        ))))
         (snails-add-candiate 'candidates (buffer-name buf) (buffer-name buf))
         ))
     (snails-sort-candidates input candidates 1 1)
     candidates))

 :candidate-icon
 (lambda (candidate)
   (snails-render-buffer-icon candidate))
 
 :candidate-do
 (lambda (candidate)
   (switch-to-buffer candidate)))

(provide 'snails-backend-filter-buffer)



;;; snails-backend-filter-buffer.el ends here

