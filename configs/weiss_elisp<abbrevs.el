(when (boundp 'emacs-lisp-mode-abbrev-table)
  (clear-abbrev-table emacs-lisp-mode-abbrev-table))

(define-abbrev-table 'emacs-lisp-mode-abbrev-table
  '(
    ("c" "concat" weiss--ahf)
    ("d" "defun" weiss--ahf)
    ("f" "format" weiss--ahf)
    ("u" "unless" weiss--ahf)
    ("i" "insert" weiss--ahf)
    ("l" "let" weiss--ahf)
    ("m" "message" weiss--ahf)
    ("o" "&optional " weiss--ahf)
    ("p" "point" weiss--ahf)
    ("s" "setq" weiss--ahf)
    ("w" "when" weiss--ahf)

    ("aa" "advice-add" weiss--ahf)
    ("ah" "add-hook" weiss--ahf)
    ("al" "add-to-list" weiss--ahf)
    ("bc" "backward-char" weiss--ahf)
    ("bs" "buffer-substring" weiss--ahf)
    ("bw" "backward-word" weiss--ahf)
    ("ca" "char-after" weiss--ahf)
    ("cb" "current-buffer" weiss--ahf)
    ("cc" "condition-case" weiss--ahf)
    ("cd" "copy-directory" weiss--ahf)
    ("cf" "copy-file" weiss--ahf)
    ("ci" "call-interactively" weiss--ahf)
    ("cw" "current-word" weiss--ahf)
    ("dc" "delete-char" weiss--ahf)
    ("dd" "delete-directory" weiss--ahf)
    ("dl" "dolist" weiss--ahf)
    ("dm" "(deactivate-mark)" weiss--ahf)
    ("df" "delete-file" weiss--ahf)
    ("dk" "define-key" weiss--ahf)
    ("dt" "dotimes" weiss--ahf)
    ("dr" "delete-region" weiss--ahf)
    ("dv" "defvar" weiss--ahf)
    ("do" "delete-overlay" weiss--ahf)
    ("eb" "erase-buffer" weiss--ahf)
    ("fa" "fillarray" weiss--ahf)
    ("fc" "forward-char" weiss--ahf)
    ("ff" "find-file" weiss--ahf)
    ("fl" "forward-line" weiss--ahf)
    ("fw" "forward-word" weiss--ahf)
    ("up" "(use-package ▮)" weiss--ahf)    
    ("gb" "get-buffer" weiss--ahf)
    ("gc" "goto-char" weiss--ahf)
    ("ie" "ignore-errors" weiss--ahf)
    ("in" "interactive" weiss--ahf)
    ("kb" "kill-buffer" weiss--ahf)
    ("kr" "kill-region" weiss--ahf)
    ("kn" "(kill-new ▮)" weiss--ahf)
    ("la" "looking-at" weiss--ahf)
    ("lb" "looking-back" weiss--ahf)
    ("lc" "left-char" weiss--ahf)
    ("ld" ":load-path \"▮\"" weiss--ahf)
    ("mb" "match-beginning" weiss--ahf)
    ("mc" "mapcar" weiss--ahf)
    ("md" "make-directory" weiss--ahf)
    ("me" "match-end" weiss--ahf)
    ("ml" "make-list" weiss--ahf)
    ("mo" "make-overlay" weiss--ahf)
    ("ms" "match-string" weiss--ahf)
    ("nl" "(next-line)" weiss--ahf)
    ("mv" "make-vector" weiss--ahf)
    ("ns" "number-sequence" weiss--ahf)
    ("op" "overlay-put" weiss--ahf)
    ("os" "overlay-start" weiss--ahf)
    ("oe" "overlay-end" weiss--ahf)
    ("pm" "point-min" weiss--ahf)
    ("pn" "progn" weiss--ahf)
    ("px" "point-max" weiss--ahf)
    ("pr" "(provide '▮)" weiss--ahf)
    ("qu" ":quelpa" weiss--ahf)
    ("rb" "region-beginning" weiss--ahf)
    ("rc" "right-char" weiss--ahf)
    ("re" "region-end" weiss--ahf)
    ("rf" "rename-file" weiss--ahf)
    ("rm" "replace-match" weiss--ahf)
    ("rn" "read-number" weiss--ahf)
    ("ro" "regexp-opt" weiss--ahf)
    ("rq" "regexp-quote" weiss--ahf)
    ("rr" "replace-regexp" weiss--ahf)
    ("rs" "read-string" weiss--ahf)
    ("sb" "search-backward" weiss--ahf)
    ("sc" "shell-command" weiss--ahf)
    ("se" "save-excursion" weiss--ahf)
    ("sf" "search-forward" weiss--ahf)
    ("sm" "string-match" weiss--ahf)
    ("sr" "save-restriction" weiss--ahf)
    ("ss" "split-string" weiss--ahf)
    ("spp" "string-prefix-p" weiss--ahf)
    ("vc" "vconcat" weiss--ahf)
    ("wg" "widget-get" weiss--ahf)
    ("wr" "write-region" weiss--ahf)
    ("wt" "(defun weiss-test ()\n  \"DOCSTRING\"\n  (interactive)\n  ▮)" weiss--ahf-indent)
    ("wl" "when-let" weiss--ahf)

    ("bfn" "buffer-file-name" weiss--ahf)
    ("bmp" "buffer-modified-p" weiss--ahf)

    ("atf" "append-to-file" weiss--ahf)
    ("bol" "beginning-of-line" weiss--ahf)
    ("cdr" "cdr" weiss--ahf)
    ("cpa" "current-prefix-arg" weiss--ahf)
    ("dfr" "directory-files-recursively" weiss--ahf)
    ("efn" "expand-file-name" weiss--ahf)
    ("eol" "end-of-line" weiss--ahf)
    ("fep" "file-exists-p" weiss--ahf)
    ("fnd" "file-name-directory" weiss--ahf)
    ("fne" "file-name-extension" weiss--ahf)
    ("fnn" "file-name-nondirectory" weiss--ahf)
    ("frn" "file-relative-name" weiss--ahf)
    ("gbc" "get-buffer-create" weiss--ahf)
    ("gnb" "generate-new-buffer" weiss--ahf)
    ("gsk" "global-set-key" weiss--ahf)
    ("ifc" "insert-file-contents" weiss--ahf)
    ("lam" "lambda" weiss--ahf)
    ("lbp" "(line-beginning-position)" weiss--ahf)
    ("len" "length" weiss--ahf)
    ("lep" "(line-end-position)" weiss--ahf)
    ("mlv" "make-local-variable" weiss--ahf)
    ("msk" "make-sparse-keymap" weiss--ahf)
    ("ntr" "narrow-to-region" weiss--ahf)
    ("nts" "number-to-string" weiss--ahf)
    ("pmi" "point-min" weiss--ahf)
    ("pma" "push-mark" weiss--ahf)
    ("rap" "region-active-p" weiss--ahf)
    ("rdn" "read-directory-name" weiss--ahf)
    ("req" "require" weiss--ahf)
    ("rfn" "read-file-name" weiss--ahf)
    ("rsb" "re-search-backward" weiss--ahf)
    ("rsf" "re-search-forward" weiss--ahf)
    ("sbr" "search-backward-regexp" weiss--ahf)
    ("scb" "skip-chars-backward" weiss--ahf)
    ("scf" "skip-chars-forward" weiss--ahf)
    ("sfa" "set-face-attribute" weiss--ahf)
    ("sff" "select-frame-set-input-focus" weiss--ahf)
    ("sfm" "set-file-modes" weiss--ahf)
    ("sfr" "search-forward-regexp" weiss--ahf)
    ("sqa" "shell-quote-argument" weiss--ahf)
    ("stb" "switch-to-buffer" weiss--ahf)
    ("ste" "(string-equal ▮)" weiss--ahf)
    ("stm" "set-transient-map" weiss--ahf)
    ("stn" "string-to-number" weiss--ahf)
    ("tap" "thing-at-point" weiss--ahf)
    ("urp" "use-region-p" weiss--ahf)
    ("wcb" "with-current-buffer" weiss--ahf)
    ("wtb" "with-temp-buffer" weiss--ahf)
    ("wtf" "with-temp-file" weiss--ahf)
    ("wlp" "weiss-load-packages" weiss--ahf)

    ("weal" "with-eval-after-load" weiss--ahf)

    ("botap" "bounds-of-thing-at-point" weiss--ahf)
    ("bsnp" "(buffer-substring-no-properties ▮)" weiss--ahf)
    ("daer" "delete-and-extract-region" weiss--ahf)
    ("epam" "(exchange-point-and-mark)" weiss--ahf)
    ("fnse" "file-name-sans-extension" weiss--ahf)
    ("rris" "replace-regexp-in-string" weiss--ahf)
    ("yonp" "yes-or-no-p" weiss--ahf)

    ("advice-add" "(advice-add '▮ : #')" weiss--ahf)
    ("abbreviate-file-name" "(abbreviate-file-name ▮)" weiss--ahf)
    ("add-hook" "(add-hook '▮ #')" weiss--ahf)
    ("add-text-properties" "(add-text-properties ▮)" weiss--ahf)
    ("add-to-list" "(add-to-list ▮)" weiss--ahf)
    ("alist-get" "(alist-get ▮)" weiss--ahf)
    ("and" "(and ▮)" weiss--ahf )
    ("append" "(append ▮)" weiss--ahf)
    ("append-to-file" "(append-to-file ▮)" weiss--ahf)
    ("apply" "(apply ▮)" weiss--ahf)
    ("aref" "(aref ▮)" weiss--ahf)
    ("aset" "(aset ▮)" weiss--ahf)
    ("ask-user-about-supersession-threat" "(ask-user-about-supersession-threat ▮)" weiss--ahf)
    ("assoc" "(assoc ▮)" weiss--ahf)
    ("assoc-default" "(assoc-default ▮)" weiss--ahf)
    ("assoc-string" "(assoc-string ▮)" weiss--ahf)
    ("assq" "(assq ▮)" weiss--ahf)
    ("assq-delete-all" "(assq-delete-all ▮)" weiss--ahf)
    ("autoload" "(autoload ▮)" weiss--ahf)
    ("backward-char" "(backward-char ▮)" weiss--ahf)
    ("backward-up-list" "(backward-up-list ▮)" weiss--ahf)
    ("backward-word" "(backward-word ▮)" weiss--ahf)
    ("barf-if-buffer-read-only" "(barf-if-buffer-read-only)" weiss--ahf)
    ("beginning-of-line" "(beginning-of-line)" weiss--ahf)
    ("boundp" "(boundp '▮)" weiss--ahf)
    ("bounds-of-thing-at-point" "(bounds-of-thing-at-point '▮)" weiss--ahf)
    ("buffer-base-buffer" "(buffer-base-buffer ▮)" weiss--ahf)
    ("buffer-chars-modified-tick" "(buffer-chars-modified-tick ▮)" weiss--ahf)
    ("buffer-file-name" "(buffer-file-name)" weiss--ahf)
    ("buffer-list" "(buffer-list ▮)" weiss--ahf)
    ("buffer-live-p" "(buffer-live-p ▮)" weiss--ahf)
    ("buffer-modified-p" "(buffer-modified-p ▮)" weiss--ahf)
    ("buffer-modified-tick" "(buffer-modified-tick ▮)" weiss--ahf)
    ("buffer-name" "(buffer-name ▮)" weiss--ahf)
    ("buffer-substring" "(buffer-substring ▮)" weiss--ahf)
    ("buffer-substring-no-properties" "(buffer-substring-no-properties ▮)" weiss--ahf)
    ("buffer-swap-text" "(buffer-swap-text ▮)" weiss--ahf)
    ("bufferp" "(bufferp ▮)" weiss--ahf)
    ("bury-buffer" "(bury-buffer ▮)" weiss--ahf)
    ("call-interactively" "(call-interactively '▮)" weiss--ahf)
    ("called-interactively-p" "(called-interactively-p '▮)" weiss--ahf)
    ("car" "(car ▮)" weiss--ahf)
    ("cadr" "(cadr ▮)" weiss--ahf)
    ("catch" "(catch '▮)" weiss--ahf)
    ("cdr" "(cdr ▮)" weiss--ahf)
    ("char-after" "(char-after ▮)" weiss--ahf)
    ("char-before" "(char-before ▮)" weiss--ahf)
    ("char-equal" "(char-equal ▮)" weiss--ahf)
    ("char-to-string" "(char-to-string ▮) " weiss--ahf)
    ("clear-image-cache" "(clear-image-cache ▮)" weiss--ahf)
    ("clear-visited-file-modtime" "(clear-visited-file-modtime)" weiss--ahf)
    ("clone-indirect-buffer" "(clone-indirect-buffer ▮)" weiss--ahf)
    ("clrhash" "(clrhash ▮)" weiss--ahf)
    ("compare-strings" "(compare-strings ▮)" weiss--ahf)
    ("concat" "(concat ▮)" weiss--ahf)
    ("cond" "(cond\n(▮ )\n\n)" weiss--ahf-indent)
    ("condition-case" "(condition-case \n▮\n)" weiss--ahf-indent)
    ("cons" "(cons ▮)" weiss--ahf)
    ("consp" "(consp ▮)" weiss--ahf)
    ("constrain-to-field" "(constrain-to-field ▮)" weiss--ahf)
    ("copy-alist" "(copy-alist ▮)" weiss--ahf)
    ("copy-directory" "(copy-directory ▮)" weiss--ahf)
    ("copy-file" "(copy-file ▮)" weiss--ahf)
    ("create-image" "(create-image ▮)" weiss--ahf)
    ("cts" "(char-to-string ▮) " weiss--ahf)
    ("current-buffer" "(current-buffer)" weiss--ahf)
    ("current-word" "(current-word)" weiss--ahf)
    ("custom-autoload" "(custom-autoload ▮)" weiss--ahf)
    ("defalias" "(defalias '▮)" weiss--ahf)
    ("defconst" "(defconst ▮)" weiss--ahf)
    ("defcustom" "(defcustom ▮)" weiss--ahf)
    ("defface" "(defface ▮)" weiss--ahf)
    ("defimage" "(defimage ▮)" weiss--ahf)
    ("define-key" "(define-key ▮ (kbd \"\") #')" weiss--ahf)
    ("define-minor-mode" "(define-minor-mode ▮)" weiss--ahf)
    ("defsubst" "(defsubst ▮)" weiss--ahf)
    ("defun" "(defun ▮ ()\n  \"DOCSTRING\"\n  (interactive)\n  (let (())\n\n ))" weiss--ahf-indent)
    ("defvar" "(defvar ▮)" weiss--ahf)
    ("delete" "(delete ▮)" weiss--ahf)
    ("delete-and-extract-region" "(delete-and-extract-region ▮)" weiss--ahf)
    ("delete-char" "(delete-char 1▮)" weiss--ahf)
    ("delete-directory" "(delete-directory ▮)" weiss--ahf)
    ("delete-dups" "(delete-dups ▮)" weiss--ahf)
    ("delete-field" "(delete-field ▮)" weiss--ahf)
    ("delete-file" "(delete-file ▮)" weiss--ahf)
    ("delete-region" "(delete-region ▮)" weiss--ahf)
    ("delete-overlay" "(delete-overlay '▮)" weiss--ahf)
    ("delq" "(delq ▮)" weiss--ahf)
    ("directory-file-name" "(directory-file-name ▮)" weiss--ahf)
    ("directory-files" "(directory-files ▮)" weiss--ahf)
    ("directory-files-recursively" "(directory-files-recursively ▮)" weiss--ahf)
    ("directory-name-p" "(directory-name-p ▮)" weiss--ahf)
    ("dolist" "(dolist (x ▮) \n\n)" weiss--ahf-indent)
    ("dotimes" "(dotimes (i ▮) \n)" weiss--ahf-indent)
    ("elt" "(elt ▮)" weiss--ahf)
    ("end-of-line" "(end-of-line ▮)" weiss--ahf)
    ("eq" "(eq ▮)" weiss--ahf)
    ("equal" "(equal ▮)" weiss--ahf)
    ("erase-buffer" "(erase-buffer)" weiss--ahf)
    ("error" "(error \"%s\" ▮)" weiss--ahf)
    ("expand-file-name" "(expand-file-name ▮)" weiss--ahf)
    ("fboundp" "(fboundp '▮)" weiss--ahf)
    ("featurep" "(featurep 'FEATURE▮)" weiss--ahf)
    ("field-beginning" "(field-beginning ▮)" weiss--ahf)
    ("field-end" "(field-end &optional ▮)" weiss--ahf)
    ("field-string" "(field-string ▮)" weiss--ahf)
    ("field-string-no-properties" "(field-string-no-properties ▮)" weiss--ahf)
    ("file-directory-p" "(file-directory-p ▮)" weiss--ahf)
    ("file-exists-p" "(file-exists-p ▮)" weiss--ahf)
    ("file-name-absolute-p" "(file-name-absolute-p ▮)" weiss--ahf)
    ("file-name-as-directory" "(file-name-as-directory ▮)" weiss--ahf)
    ("file-name-directory" "(file-name-directory ▮)" weiss--ahf)
    ("file-name-extension" "(file-name-extension ▮)" weiss--ahf)
    ("file-name-nondirectory" "(file-name-nondirectory ▮)" weiss--ahf)
    ("file-name-sans-extension" "(file-name-sans-extension ▮)" weiss--ahf)
    ("file-regular-p" "(file-regular-p ▮)" weiss--ahf)
    ("file-relative-name" "(file-relative-name ▮)" weiss--ahf)
    ("find-buffer-visiting" "(find-buffer-visiting ▮)" weiss--ahf)
    ("find-file" "(find-file ▮)" weiss--ahf)
    ("find-image" "(find-image ▮)" weiss--ahf)
    ("font-lock-add-keywords" "(font-lock-add-keywords ▮)" weiss--ahf)
    ("font-lock-fontify-buffer" "(font-lock-fontify-buffer ▮)" weiss--ahf)
    ("format" "(format \":%s\" ▮)" weiss--ahf)
    ;; ("format" "(format \"▮\" &optional OBJECTS)" weiss--ahf)
    ("forward-char" "(forward-char ▮)" weiss--ahf)
    ("forward-line" "(forward-line ▮)" weiss--ahf)
    ("forward-word" "(forward-word ▮)" weiss--ahf)
    ("funcall" "(funcall '▮)" weiss--ahf)
    ("function" "(function ▮)" weiss--ahf)
    ("gap-position" "(gap-position)" weiss--ahf)
    ("gap-size" "(gap-size)" weiss--ahf)
    ("generate-new-buffer" "(generate-new-buffer ▮)" weiss--ahf)
    ("generate-new-buffer" "(generate-new-buffer ▮)" weiss--ahf)
    ("generate-new-buffer-name" "(generate-new-buffer-name ▮)" weiss--ahf)
    ("get" "(get ▮ ')" weiss--ahf)
    ("get-buffer" "(get-buffer ▮)" weiss--ahf)
    ("get-buffer-create" "(get-buffer-create ▮)" weiss--ahf)
    ("get-char-code-property" "(get-char-code-property ▮)" weiss--ahf)
    ("get-char-property" "(get-char-property ▮)" weiss--ahf)
    ("get-char-property-and-overlay" "(get-char-property-and-overlay ▮)" weiss--ahf)
    ("get-file-buffer" "(get-file-buffer ▮)" weiss--ahf)
    ("get-pos-property" "(get-pos-property ▮)" weiss--ahf)
    ("get-text-property" "(get-text-property ▮)" weiss--ahf)
    ("gethash" "(gethash ▮)" weiss--ahf)
    ("global-set-key" "(global-set-key (kbd \"C-▮\") )" weiss--ahf)
    ("goto-char" "(goto-char ▮)" weiss--ahf)
    ("if" "(if ▮\n    \n )" weiss--ahf-indent)
    ("image-flush" "(image-flush ▮)" weiss--ahf)
    ("image-load-path-for-library" "(image-load-path-for-library ▮)" weiss--ahf)
    ("image-size" "(image-size ▮)" weiss--ahf)
    ("insert" "(insert ▮)" weiss--ahf)
    ("insert-and-inherit" "(insert-and-inherit ▮)" weiss--ahf)
    ("insert-before-markers-and-inherit" "(insert-before-markers-and-inherit ▮)" weiss--ahf)
    ("insert-char" "(insert-char ▮)" weiss--ahf)
    ("insert-file-contents" "(insert-file-contents ▮)" weiss--ahf)
    ("insert-image" "(insert-image ▮)" weiss--ahf)
    ("insert-sliced-image" "(insert-sliced-image ▮)" weiss--ahf)
    ("interactive" "(interactive)" weiss--ahf)
    ("ignore-errors" "(ignore-errors ▮)" weiss--ahf)
    ("kbd" "(kbd \"▮\")" weiss--ahf)
    ("kill-append" "(kill-append ▮)" weiss--ahf)
    ("kill-buffer" "(kill-buffer ▮)" weiss--ahf)
    ("kill-region" "(kill-region ▮)" weiss--ahf)
    ("lambda" "(lambda () ▮)" weiss--ahf)
    ("last-buffer" "(last-buffer ▮)" weiss--ahf)
    ("left-char" "(left-char ▮)" weiss--ahf)
    ("length" "(length ▮)" weiss--ahf)
    ("let" "(let ((▮)\n)\n \n)" weiss--ahf-indent)
    ("let*" "(let* ((▮)\n)\n \n)" weiss--ahf-indent)
    ("line-beginning-position" "(line-beginning-position)" weiss--ahf)
    ("line-end-position" "(line-end-position)" weiss--ahf)
    ("list" "(list ▮)" weiss--ahf)
    ("load" "(load ▮)" weiss--ahf)
    ("load-file" "(load-file ▮)" weiss--ahf)
    ("looking-at" "(looking-at \"▮\")" weiss--ahf)
    ("looking-back" "(looking-back \"▮\")" weiss--ahf)
    ("make-directory" "(make-directory ▮)" weiss--ahf)
    ("make-hash-table" "(make-hash-table :test '▮)" weiss--ahf)
    ("make-indirect-buffer" "(make-indirect-buffer ▮)" weiss--ahf)
    ("make-list" "(make-list ▮)" weiss--ahf)
    ("make-sparse-keymap" "(make-sparse-keymap)" weiss--ahf)
    ("make-local-variable" "(make-local-variable ▮)" weiss--ahf)
    ("make-string" "(make-string count character)" weiss--ahf)
    ("make-overlay" "(make-overlay ▮)" weiss--ahf)
    ("mapc" "(mapc '▮)" weiss--ahf)
    ("mapcar" "(mapcar '▮)" weiss--ahf)
    ("mapconcat" "(mapconcat ▮)" weiss--ahf)
    ("maphash" "(maphash ▮)" weiss--ahf)
    ("match-beginning" "(match-beginning ▮)" weiss--ahf)
    ("match-data" "(match-data ▮)" weiss--ahf)
    ("match-end" "(match-end ▮)" weiss--ahf)
    ("match-string" "(match-string ▮)" weiss--ahf)
    ("member" "(member ▮)" weiss--ahf)
    ("member" "(member ▮)" weiss--ahf)
    ("member-ignore-case" "(member-ignore-case ▮)" weiss--ahf)
    ("memq" "(memq ▮)" weiss--ahf)
    ("memql" "(memql ▮)" weiss--ahf)
    ("message" "(message \": %s\" ▮)" weiss--ahf)
    ("narrow-to-region" "(narrow-to-region ▮)" weiss--ahf)
    ("next-char-property-change" "(next-char-property-change ▮)" weiss--ahf)
    ("next-property-change" "(next-property-change ▮)" weiss--ahf)
    ("next-single-char-property-change" "(next-single-char-property-change ▮)" weiss--ahf)
    ("next-single-property-change" "(next-single-property-change ▮)" weiss--ahf)
    ("not" "(not ▮)" weiss--ahf)
    ("not-modified" "(not-modified ▮)" weiss--ahf)
    ("nth" "(nth ▮)" weiss--ahf)
    ("null" "(null ▮)" weiss--ahf)
    ("number-sequence" "(number-sequence ▮)" weiss--ahf)
    ("number-to-string" "(number-to-string ▮)" weiss--ahf)
    ("or" "(or ▮)" weiss--ahf)
    ("other-buffer" "(other-buffer ▮)" weiss--ahf)
    ("overlay-put" "(overlay-put ov '▮)" weiss--ahf)
    ("overlay-start" "(overlay-start ▮)" weiss--ahf)
    ("overlay-end" "(overlay-end ▮)" weiss--ahf)
    ("point" "(point)" weiss--ahf)
    ("point-max" "(point-max)" weiss--ahf)
    ("point-min" "(point-min)" weiss--ahf)
    ("pop" "(pop ▮)" weiss--ahf)
    ("previous-char-property-change" "(previous-char-property-change ▮)" weiss--ahf)
    ("previous-property-change" "(previous-property-change ▮)" weiss--ahf)
    ("previous-single-char-property-change" "(previous-single-char-property-change ▮)" weiss--ahf)
    ("previous-single-property-change" "(previous-single-property-change ▮)" weiss--ahf)
    ("prin1" "(prin1 ▮)" weiss--ahf)
    ("prin1-to-string" "(prin1-to-string ▮)" weiss--ahf)
    ("princ" "(princ ▮)" weiss--ahf)
    ("print" "(print ▮)" weiss--ahf)
    ("prog1" "(prog1\n▮)" weiss--ahf-indent)
    ("prog2" "(prog2\n▮)" weiss--ahf-indent)
    ("progn" "(progn\n▮\n)" weiss--ahf-indent)
    ("propertize" "(propertize ▮)" weiss--ahf)
    ("push" "(push ▮)" weiss--ahf)
    ("push-mark" "(push-mark ▮)" weiss--ahf)
    ("put" "(put '▮)" weiss--ahf)
    ("put-image" "(put-image ▮)" weiss--ahf)
    ("put-text-property" "(put-text-property ▮)" weiss--ahf)
    ("puthash" "(puthash ▮)" weiss--ahf)
    (":quelpa" ":quelpa (▮ \n :fetcher github \n :repo )" weiss--ahf-indent)
    ("random" "(random ▮)" weiss--ahf)
    ("rassoc" "(rassoc ▮)" weiss--ahf)
    ("rassoc" "(rassoc ▮)" weiss--ahf)
    ("rassq" "(rassq ▮)" weiss--ahf)
    ("rassq-delete-all" "(rassq-delete-all ▮)" weiss--ahf)
    ("re-search-backward" "(re-search-backward \"▮\")" weiss--ahf)
    ("re-search-forward" "(re-search-forward \"▮\")" weiss--ahf)
    ("read-directory-name" "(read-directory-name \"▮:\")" weiss--ahf)
    ("read-file-name" "(read-file-name \"▮\")" weiss--ahf)
    ("read-regexp" "(read-regexp \"Type regex▮:\")" weiss--ahf)
    ("read-string" "(read-string \"What▮:\")" weiss--ahf)
    ("read-number" "(read-number \"▮:\")" weiss--ahf)
    ("regexp-opt" "(regexp-opt ▮)" weiss--ahf)
    ("regexp-quote" "(regexp-quote ▮)" weiss--ahf)
    ("region-active-p" "(region-active-p)" weiss--ahf)
    ("region-beginning" "(region-beginning)" weiss--ahf)
    ("region-end" "(region-end)" weiss--ahf)
    ("remhash" "(remhash ▮)" weiss--ahf)
    ("remove" "(remove ▮)" weiss--ahf)
    ("remove-images" "(remove-images ▮)" weiss--ahf)
    ("remove-list-of-text-properties" "(remove-list-of-text-properties ▮)" weiss--ahf)
    ("remove-text-properties" "(remove-text-properties ▮)" weiss--ahf)
    ("remq" "(remq ▮)" weiss--ahf)
    ("rename-buffer" "(rename-buffer ▮)" weiss--ahf)
    ("rename-file" "(rename-file ▮)" weiss--ahf)
    ("repeat" "(repeat ▮)" weiss--ahf)
    ("replace-match" "(replace-match ▮)" weiss--ahf)
    ("replace-regexp" "(replace-regexp \"▮\")" weiss--ahf)
    ("replace-regexp-in-string" "(replace-regexp-in-string \"▮\")" weiss--ahf)
    ("require" "(require '▮)" weiss--ahf)
    ("restore-buffer-modified-p" "(restore-buffer-modified-p ▮)" weiss--ahf)
    ("reverse" "(reverse ▮)" weiss--ahf)
    ("right-char" "(right-char ▮)" weiss--ahf)
    ("run-with-timer" "(run-with-timer ▮)" weiss--ahf)
    ("save-buffer" "(save-buffer ▮)" weiss--ahf)
    ("save-current-buffer" "(save-current-buffer ▮)" weiss--ahf)
    ("save-excursion" "(save-excursion ▮)" weiss--ahf)
    ("save-restriction" "(save-restriction ▮)" weiss--ahf)
    ("search-backward" "(search-backward \"▮\")" weiss--ahf)
    ("search-backward-regexp" "(search-backward-regexp \"▮\")" weiss--ahf)
    ("search-forward" "(search-forward \"▮\")" weiss--ahf)
    ("search-forward-regexp" "(search-forward-regexp \"▮\")" weiss--ahf)
    ("select-frame-set-input-focus" "(select-frame-set-input-focus ▮)" weiss--ahf)
    ("set-buffer" "(set-buffer ▮)" weiss--ahf)
    ("set-buffer-modified-p" "(set-buffer-modified-p ▮)" weiss--ahf)
    ("set-file-modes" "(set-file-modes ▮)" weiss--ahf)
    ("set-face-attribute" "(set-face-attribute '▮ nil :)" weiss--ahf)
    ("set-mark" "(set-mark ▮)" weiss--ahf)
    ("set-syntax-table" "(set-syntax-table ▮)" weiss--ahf)
    ("set-text-properties" "(set-text-properties ▮)" weiss--ahf)
    ("set-visited-file-modtime" "(set-visited-file-modtime ▮)" weiss--ahf)
    ("set-visited-file-name" "(set-visited-file-name ▮)" weiss--ahf)
    ("set-transient-map" "(set-transient-map\n(let ((map (make-sparse-keymap))\n)\n(define-key map (kbd \"▮\") #')\nmap)\nt)" weiss--ahf-indent)
    ("setq" "(setq ▮)" weiss--ahf)
    ("setf" "(setf ▮)" weiss--ahf)
    ("max" "(max ▮)" weiss--ahf)
    ("shell-command" "(shell-command ▮)" weiss--ahf)
    ("shell-quote-argument" "(shell-quote-argument ▮)" weiss--ahf)
    ("skip-chars-backward" "(skip-chars-backward \"▮\")" weiss--ahf)
    ("skip-chars-forward" "(skip-chars-forward \"▮\")" weiss--ahf)
    ("split-string" "(split-string ▮)" weiss--ahf)
    ("stc" "(string-to-char \"▮\")" weiss--ahf)
    ("string-collate-equalp" "(string-collate-equalp ▮)" weiss--ahf)
    ("string-collate-lessp" "(string-collate-lessp ▮)" weiss--ahf)
    ("string-equal" "(string-equal ▮)" weiss--ahf)
    ("string-greaterp" "(string-greaterp ▮)" weiss--ahf)
    ("string-lessp" "(string-lessp ▮)" weiss--ahf)
    ("string-match" "(string-match \"▮\")" weiss--ahf)
    ("string-match-p" "(string-match-p \"▮\")" weiss--ahf)
    ("string-prefix-p" "(string-prefix-p ▮)" weiss--ahf)
    ("string-suffix-p" "(string-suffix-p ▮)" weiss--ahf)
    ("string-suffix-p" "(string-suffix-p ▮)" weiss--ahf)
    ("string-to-char" "(string-to-char \"▮\")" weiss--ahf)
    ("string-to-number" "(string-to-number \"▮\")" weiss--ahf)
    ("string=" "(string-equal ▮)" weiss--ahf)
    ("stringp" "(stringp ▮)" weiss--ahf)
    ("substring" "(substring ▮)" weiss--ahf)
    ("substring-no-properties" "(substring-no-properties ▮)" weiss--ahf)
    ("switch-to-buffer" "(switch-to-buffer ▮)" weiss--ahf)
    ("terpri" "(terpri ▮)" weiss--ahf)
    ("text-properties-at" "(text-properties-at ▮)" weiss--ahf)
    ("text-property-any" "(text-property-any ▮)" weiss--ahf)
    ("text-property-not-all" "(text-property-not-all ▮)" weiss--ahf)
    ("thing-at-point" "(thing-at-point ▮)" weiss--ahf)
    ("throw" "(throw '▮)" weiss--ahf)
    ("toggle-read-only" "(toggle-read-only ▮)" weiss--ahf)
    ("unbury-buffer" "(unbury-buffer)" weiss--ahf)
    ("unless" "(unless ▮\n)" weiss--ahf-indent)
    ("use-region-p" "(use-region-p)" weiss--ahf)
    ("user-error" "(user-error \"%s▮\")" weiss--ahf)
    ("vector" "(vector ▮)" weiss--ahf)
    ("verify-visited-file-modtime" "(verify-visited-file-modtime ▮)" weiss--ahf)
    ("version<" "(version< \"24.4\" emacs-version)" weiss--ahf )
    ("version<=" "(version<= \"24.4\" emacs-version)" weiss--ahf )
    ("visited-file-modtime" "(visited-file-modtime)" weiss--ahf)
    ("when" "(when ▮)" weiss--ahf)
    ("when-let" "(when-let ((▮))\n\n)" weiss--ahf-indent)
    ("while" "(while (▮)\n  (setq ))" weiss--ahf-indent)
    ("widen" "(widen)" weiss--ahf)
    ("widget-get" "(widget-get ▮)" weiss--ahf)
    ("with-current-buffer" "(with-current-buffer\n▮\n)" weiss--ahf-indent)
    ("with-output-to-string" "(with-output-to-string\n▮\n)" weiss--ahf-indent)
    ("with-output-to-temp-buffer" "(with-output-to-temp-buffer\n▮\n)" weiss--ahf-indent)
    ("with-temp-buffer" "(with-temp-buffer\n▮\n)" weiss--ahf-indent)
    ("with-temp-file" "(with-temp-file\n▮\n)" weiss--ahf-indent)
    ("with-eval-after-load" "(with-eval-after-load '▮\n\n)" weiss--ahf-indent)
    ("write-char" "(write-char ▮)" weiss--ahf)
    ("write-file" "(write-file ▮)" weiss--ahf)
    ("write-region" "(write-region (point-min) (point-max) ▮)" weiss--ahf)
    ("weiss-load-packages" "(weiss-load-packages\n '(\n▮\n))" weiss--ahf-indent)
    ("y-or-n-p" "(y-or-n-p \"▮ \")" weiss--ahf)
    ("yes-or-no-p" "(yes-or-no-p \"▮ \")" weiss--ahf)

    ("make-vector" "(make-vector 5▮ 0)" weiss--ahf)
    ("vconcat" "(vconcat ▮)" weiss--ahf)
    ("fillarray" "(fillarray ▮ 0)" weiss--ahf)

    ;;
    )

  "Abbrev table for `elisp-mode'"
  )

(provide 'weiss_elisp<abbrevs)
