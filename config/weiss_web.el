(require 'request)

(defun weiss-offcloud-download (url)
  (message "%s" (request
                 "https://offcloud.com/api/cloud?key=mUSoUdEN8cJzca6ur9G7awsUGPdh6CIV"
                 :type "POST"
                 :data `(("url" . ,url))
                 :parser 'json-read
                 ;; :success (cl-function
                 ;; (lambda (&key data &allow-other-keys)
                 ;; (message "I sent: %S" (request-response-status-code response) )))
                 ;; :error
                 ;; (cl-function (lambda (&rest args &key error-thrown &allow-other-keys)
                 ;; (message "Got error: %S" error-thrown)))
                 )))

(defun weiss-test ()
  "DOCSTRING"
  (interactive)
  (message "123%s" (eaf-call "call_function" eaf--buffer-id "weiss_get_html")))

(defun weiss-get-jav-bangou ()
  "auto find and search bangou in JavLibrary by parse html"
  (interactive)
  (let ((html (eaf-call "call_function" eaf--buffer-id "weiss_get_html")))
    (with-temp-buffer
      (insert html)
      (let ((bangou
             (replace-regexp-in-string
              ".*[[:space:]]\\([[:word:]]\\{2,5\\}-?[[:digit:]]\\{3,5\\}\\)[[:space:]].*" "\\1"
              (format "%s" (assq 'title (assq 'head
                                              (libxml-parse-html-region (point-min) (point-max)))))))
            (input-char (read-char-picky "(F)ANZA (B)TSOW: " "fb")))
        (kill-new bangou)
        (cond
         ((string= input-char "b") (eaf-open (concat "https://btsow.club/search/" bangou) "browser"))
         ((string= input-char "f") (eaf-open (concat "https://www.dmm.co.jp/search/=/searchstr=" (replace-regexp-in-string "\\([[:digit:]]\\{2,4\\}\\)" "00\\1" bangou)) "browser"))
         (t nil))))))

(defun weiss-get-btsow-link ()
  "Auto get link in BTSOW and remote download in OffCloud"
  (interactive)
  (let ((magnet-link (replace-regexp-in-string ".*?<textarea id=\"magnetLink\".*?\\(magnet:.*?&\\)amp;\\(.*?\\)</textarea>.*" "\\1\\2" (format "%s" (split-string (eaf-call "call_function" eaf--buffer-id "weiss_get_html"))))))
    (kill-new magnet-link)
    (weiss-offcloud-download magnet-link)
    )
  )

(defun weiss-list-to-string-with-index (the-list)
  "list to string with index"
  (interactive)
  (let ((r ""))
    (dotimes (i (length the-list)  r) 
      (setq r (format "%s\n%s:%s" r i (nth i the-list)))
      )
    )
  )

(defun weiss-get-fanza-bangou ()
  "get fanza bangou and auto search it in btsow"
  (interactive)
  (let ((html (eaf-call "call_function" eaf--buffer-id "weiss_get_html")))
    (with-temp-buffer
      (insert html)
      (let ((bangou-with-zero (nth 2 (nth 4 (nth 13 (assq 'tbody (assq 'table (assq 'td (assq 'tr (assq 'tbody (assq 'table (assq 'div (nth 4 (assq 'tr (assq 'tbody (assq 'table (assq 'body (libxml-parse-html-region (point-min) (point-max)))))))))))))))))))
        (eaf-open (concat "https://btsow.club/search/" (replace-regexp-in-string "\\([a-zA-Z]+\\)00\\([0-9]+\\)" "\\1\\2" bangou-with-zero)) "browser")))))

(provide 'weiss_web)
