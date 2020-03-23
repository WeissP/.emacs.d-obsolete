(defun weiss-offcloud-download (url)
  "send url to offcloud to download"
  (interactive)
  (request
    "https://offcloud.com/api/cloud?key=wAEj06Qj4wLR7XJ3XYq0HV59wPhafolb"
    :type "POST"
    :data '(("url" . url))
    :parser 'json-read
    :success (cl-function
              (lambda (&key data &allow-other-keys)
                (message "I sent: %S" (assoc-default 'json data))))
    :error
    (cl-function (lambda (&rest args &key error-thrown &allow-other-keys)
                   (message "Got error: %S" error-thrown)))
    ))


;; (require 'xml)
;; (setq parse-tree (xml-parse-file "test.xml"))    
;; (setq trials-node (assq 'trials parse-tree))
;; (setq trial-node (car (xml-get-children trials-node 'trial)))
;; (setq main-node (car (xml-get-children trial-node 'main)))
;; (setq trial_id-node (car (xml-get-children main-node 'trial_id)))
;; (car (xml-node-children trial_id-node))
;; (setq scientific_title-node (car (xml-get-children main-node 'scientific_title)))
;; (car (xml-node-children scientific_title-node))
