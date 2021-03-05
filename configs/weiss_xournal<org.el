(with-eval-after-load 'org
  (setq
   weiss-org-xournal-note-dir "/home/weiss/Documents/OrgFiles/Bilder/xournal/xopp/"  ;; xopp 笔记存储目录
   weiss-org-xournal-template-dir "/home/weiss/Documents/OrgFiles/Bilder/xournal/" ;; xournal 目标文件存储目录
   weiss-org-xournal-default-template-name "Template.xopp" ;; 默认笔记模版名称，应该位于 org-xournal-template-dir
   weiss-org-xournal-bin "/usr/bin/xournalpp" ;; xournal 执行文件
   weiss-org-xournal-png-path "/home/weiss/Documents/OrgFiles/Bilder/xournal/png/"
   weiss-org-xournal-process-picture-functon #'weiss-org-xournal-process-picture-functon
   )

  (defun org-xournal-save-image (xournal-path png-path)
    "Convert XOURNAL-PATH to PNG and write it to PNG-PATH."
    (call-process-shell-command (format "%s %s -i %s" weiss-org-xournal-bin xournal-path png-path))
    )

  (defun weiss-xournal--refresh-img (path png-path)
    "refresh xournal image"
    (interactive)
    (org-xournal-save-image path png-path)
    (call-process-shell-command (format "convert %s -resize 326x231 -quality 5%%  -trim +repage %s"   png-path png-path)))

  (defun weiss-xournal-refresh-img-manually ()
    "DOCSTRING"
    (interactive)
    (let* ((context (org-element-context))
           (type (org-element-type context))
           (lineage (org-element-lineage context '(link) t))
           (path (org-element-property :path lineage))
           (png-path (concat
                      weiss-org-xournal-png-path
                      (file-name-sans-extension (file-name-nondirectory path)) ".png") )
           )
      ;; (message "path: %s\npng-path: %s" path png-path)
      (weiss-xournal-refresh-img path png-path)
      ))

  (defun weiss-insert-xournal-link ()
    "DOCSTRING"
    (interactive)
    (let* ((name (read-string "xournal name:"))
           (file-name (concat name ".xopp"))
           (path (concat weiss-org-xournal-note-dir file-name))
           (png-path (concat weiss-org-xournal-png-path name ".png"))
           )
      (unless (file-exists-p path)
        (f-copy
         (concat
          weiss-org-xournal-template-dir
          weiss-org-xournal-default-template-name)
         path)
        )
      (insert (format "[[%s][%s]]" path file-name))
      (let ((process-connection-type nil))
        (start-process "" nil "xdg-open" path)
        ) 
      ;; (weiss-xournal-refresh-img path png-path)
      ;; (insert (format "\n[[%s]]" png-path))
      ))
  )

(provide 'weiss_xournal<org)
