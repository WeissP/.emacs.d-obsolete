(with-eval-after-load 'lsp-java
  (defun async-shell-command-no-window (command)
    (interactive)
    (let
        ((display-buffer-alist
          (list
           (cons
            "\\*Async Shell Command\\*.*"
            (cons #'display-buffer-no-window nil)))))
      (async-shell-command
       command)))
  (defun weiss--format-java (dir)
    "DOCSTRING"
    (save-buffer)
    (message "start format file")
    (let ((display-buffer-alist (list (cons "\\*Async Shell Command\\*.*"
                                            (cons #'display-buffer-no-window nil))))
          )
      (async-shell-command-no-window
       (concat
        "/home/weiss/idea/idea-IU-201.6668.121/bin/idea.sh format -s /home/weiss/weiss/Bai-JavaCodeStyle.xml "
        (if dir 
            (concat "-r " default-directory)
          (buffer-file-name)))))
    )

  (defun weiss-format-current-java-file ()
    "format current java file using idea"
    (interactive)
    (weiss--format-java nil))

  (defun weiss-format-current-java-dir ()
    "format current directory using idea"
    (interactive)
    (weiss--format-java t))
  )

(provide 'weiss_format<lsp-java<lsp-mode)
