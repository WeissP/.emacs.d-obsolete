(with-eval-after-load 'snails
    (setq weiss-reduce-file-path-alist
          '(
            ("🅲🅻🅿" . "Compiler-and-Language-Processing-Tools")
            ("🆂🅲" . "scientififc computing")
            ("🆅" . "Documents/Vorlesungen")
            ("🅥" . "Nutstore Files/Vorlesungen")
            ("🅹" . "src/main/java")
            ("🅙🅣" . "src/test/java")
            ("~" . "/home/weiss")
            ))

  (defun weiss-reduce-file-path (filename &optional r)
    "replace long file paths with symbol, if `r' is non-nil, then replace symbol with path"
    (interactive)
    (let ((search-str)
          (replace-str))
      (dolist (x weiss-reduce-file-path-alist)
        (if r
            (setq search-str (car x) 
                  replace-str (cdr x))
          (setq search-str (cdr x) 
                replace-str (car x)))      
        (setq filename (replace-regexp-in-string search-str replace-str filename t))
        )
      )  
    (let ((limit 90)
          )
      (when (> (length filename) limit)
        (setq filename (substring filename (- limit))))      
      )    
    filename
    )


  )

(provide 'weiss_reduce-path<snails)
