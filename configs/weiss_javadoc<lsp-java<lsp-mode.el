(with-eval-after-load 'lsp-java
  (defun weiss-javadoc--get-param (line)
    "get the param in the `line', for `weiss-add-javadoc'"
    (interactive)
    (when (string-match ".*(\\(.+\\)).*" line)
      (setq params (split-string (match-string 1 line) ","))
      (mapcar (lambda (x)
                (setq x (s-trim x))
                (when-let ((i (string-match " " x)))
                  (substring x (1+ i)) 
                  )
                )
              params
              )
      )                
    )

  (defun weiss-add-javadoc ()
    "add java doc using imenu"
    (interactive)
    (let* ((imenu-auto-rescan t)
           (index (imenu--make-index-alist t))
           (l (snails-backend-imenu-build-candidates (delete (assoc "*Rescan*" index) index)))
           )
      (dolist (x l) 
        (let* ((info (split-string (car x) ":"))
               (f (s-trim (car info)))
               (p (cdr x))
               (i (string-match "\(" f))
               (doc)
               )
          (goto-char p)
          (ignore-errors (previous-line))
          (when (string= "" (s-trim (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
            (goto-char p)
            (beginning-of-line)
            (setq doc "/**\n* ")
            (when i
              (setq doc (concat doc (substring f 0 i) "."))
              (when-let
                  ((params (weiss-javadoc--get-param (buffer-substring-no-properties
                                                      (line-beginning-position)
                                                      (line-end-position)))))
                (dolist (x params) 
                  (setq doc (concat doc "\n* @param " x "  "))
                  )
                )
              (when (not (string= (s-trim (cadr info))  "void"))
                (setq doc (concat doc "\n* @return  "))
                )              
              )
            (insert (concat doc "\n*/\n"))
            )
          )
        )
      (indent-region (point-min) (point-max))
      ))
  )

(provide 'weiss_javadoc<lsp-java<lsp-mode)
