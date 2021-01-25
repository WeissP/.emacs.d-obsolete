;; -*- lexical-binding: t -*-
;; org
;; :PROPERTIES:
;; :header-args: :tangle org/weiss-org.el :mkdirp yes :comments both :shebang   ;; -*- lexical-binding: t -*-
;; :END:

;; [[file:../emacs-config.org::*org][org:1]]
(defvar weiss/org-file-path "/home/weiss/Documents/OrgFiles/")
(defvar weiss/org-img-path "/home/weiss/Documents/OrgFiles/Bilder/")
(defun weiss--get-org-file-path (path)
  "get org-file path according to weiss/org-file-path"
  (interactive)
  (concat weiss/org-file-path path)
  )
(use-package org
;; org:1 ends here

;; hooks

;; [[file:../emacs-config.org::*hooks][hooks:1]]
:hook ((org-mode . (lambda ()
                     ;; (company-mode -1)
                     (if (eq major-mode 'org-mode)
                         (weiss-org-sp-mode 1)
                       (weiss-org-sp-mode -1)                           
                       )
                     (make-local-variable 'company-minimum-prefix-length)
                     (setq company-minimum-prefix-length 5)
                     (linum-mode -1)
                     (display-line-numbers-mode nil)
                     (iimage-mode)
                     (diminish 'iimage-mode)
                     (emojify-mode)
                     (make-local-variable 'shiftless-upper-rules)
                     (shiftless-Umlaut)
                     (make-local-variable 'display-line-numbers)
                     (visual-line-mode)
                     (diminish 'visual-line-mode)
                     (setq
                      display-line-numbers 'nil)
                     ;; (let ((current-prefix-arg '(16)))
                     ;;   (call-interactively 'org-latex-preview)
                     ;;   )

                     "Beautify org symbols."

                     ;; (push '("[ ]" . ?☐) prettify-symbols-alist)
                     ;; (push '("[X]" . ?☑) prettify-symbols-alist)
                     ;; (push '("[-]" . ?⛝) prettify-symbols-alist)

                     ;; (push '("#+ARCHIVE:" . ?📦) prettify-symbols-alist)
                     ;; ;; (push '("#+AUTHOR:" . ?👤) prettify-symbols-alist)
                     ;; ;; (push '("#+CREATOR:" . ?💁) prettify-symbols-alist)
                     ;; (push '("#+DATE:" . ?📆) prettify-symbols-alist)
                     ;; (push '("#+DESCRIPTION:" . ?⸙) prettify-symbols-alist)
                     ;; (push '("#+EMAIL:" . ?🖂) prettify-symbols-alist)
                     ;; (push '("#+OPTIONS:" . ?⛭) prettify-symbols-alist)
                     ;; (push '("#+SETUPFILE:" . ?⛮) prettify-symbols-alist)
                     ;; (push '("#+TAGS:" . ?🏷) prettify-symbols-alist)
                     ;; ;; (push '("#+TITLE:" . ?📓) prettify-symbols-alist)

                     ;; (push '("#+BEGIN_SRC" . ?✎) prettify-symbols-alist)
                     ;; (push '("#+begin_src" . ?✎) prettify-symbols-alist)
                     ;; (push '("#+END_SRC" . ?⬝) prettify-symbols-alist)
                     ;; (push '("#+end_src" . ?⬝) prettify-symbols-alist)
                     ;; (push '("#+BEGIN_QUOTE" . ?») prettify-symbols-alist)
                     ;; (push '("#+END_QUOTE" . ?«) prettify-symbols-alist)
                     ;; (push '("#+HEADERS" . ?☰) prettify-symbols-alist)
                     ;; (push '("#+RESULTS:" . ?💻) prettify-symbols-alist)

                     ;; (prettify-symbols-mode 1)
                     ))

       (org-indent-mode . (lambda()
                            (diminish 'org-indent-mode)
                            ;; WORKAROUND: Prevent text moving around while using brackets
                            ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                            (make-variable-buffer-local 'show-paren-mode)
                            (setq show-paren-mode nil))))
;; hooks:1 ends here

;; init

;; [[file:../emacs-config.org::*init][init:1]]
:init
(advice-add 'org-edit-special
            :after
            '(lambda () (interactive)
               (maximize-window)
               (weiss-shrink-window-if-larger-than-buffer nil (/ (frame-height) 3))))
(require 'weiss-org-sp-mode)
(provide 'org-version)
(fset 'org-agenda-done "td")
;; init:1 ends here

;; variables

;; [[file:../emacs-config.org::*variables][variables:1]]
(setq
 org-directory "~/Documents/OrgFiles/"
 ;; org-agenda-files '("/home/weiss/Documents/OrgFiles/calendar.org" "/home/weiss/Documents/OrgFiles/todo.org")
 org-agenda-files '("/home/weiss/Documents/OrgFiles/todo.org" "/home/weiss/Documents/Org-roam/daily/")
 org-agenda-prefix-format "%t %s " ;hide files name
 org-todo-keywords '((sequence "INPROGRESS(i)" "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c@)"))
 ;; (sequence "⚑(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
 org-cycle-max-level 15
 org-agenda-skip-scheduled-if-done t
 org-hide-leading-stars nil
 org-indent-mode-turns-on-hiding-stars nil
 org-list-description-max-indent 4
 org-startup-indented t
 org-startup-folded 'fold
 org-log-done 'time
 org-fast-tag-selection-single-key t
 org-agenda-include-diary t
 org-agenda-window-setup 'current-window
 org-src-window-setup 'split-window-below

  ;;;;; Export

 org-export-preserve-breaks nil
 org-export-with-creator nil
 org-export-with-author t
 org-export-with-section-numbers nil
 org-export-with-toc nil
 org-export-with-latex "imagemagick"
 org-export-with-date nil


 org-refile-targets
 `((,(weiss--get-org-file-path "Kenntnisse.org")   :level . 1)
   (,(weiss--get-org-file-path "todo.org"):maxlevel . 2)                            
   (,(weiss--get-org-file-path "Vorlesungen.org"):maxlevel . 2)
   (,(weiss--get-org-file-path "Einsammlung.org"):maxlevel . 2)
   (,(weiss--get-config-file-path "emacs-config.org"):maxlevel . 2)
   )

 org-refile-use-outline-path nil

 org-agenda-custom-commands
 '(
   ("c" "Custom agenda"
    ((agenda ""))
    (
     ;; (org-agenda-tag-filter-preset '("+dailyagenda"))
     (org-agenda-hide-tags-regexp (concat org-agenda-hide-tags-regexp "\\|dailyagenda"))
     (org-agenda-span 20)))
   ("b" occur-tree "Bookmarks"))
 org-link-frame-setup
 '(
   (vm . vm-visit-folder)
   (vm-imap . vm-visit-imap-folder)
   (gnus . gnus)
   (file . find-file)
   (wl . wl-frame))
 org-tags-column -80
 org-log-done 'time
 org-catch-invisible-edits 'smart
 org-fontify-done-headline t
 org-agenda-compact-blocks t
 org-image-actual-width nil
 org-capture-templates   '(("o" "org-noter" entry (file "~/Documents/OrgFiles/Vorlesungen.org")
                            "* %f \n :PROPERTIES: \n :NOTER_DOCUMENT: %F \n :END: \n [[%F][Filepath]]")
                           ("a" "Abgabe" entry (file "~/Documents/OrgFiles/Vorlesungen.org")
                            "* [[%F][%f]]  \n ")
                           )
 ;; org-ellipsis (if (char-displayable-p ?) "  " nil)
 org-pretty-entities nil
 ;; hide ** //
 org-hide-emphasis-markers nil

  ;;;;; File Assoc
 org-file-apps
 '((auto-mode . emacs)
   ("\\.mm\\'" . default)
   ("\\.x?html?\\'" . default)
   ("\\.pdf\\'" . emacs)
   ("\\.mp4\\'" . "vlc \"%s\"")
   ("\\.txt\\'" . emacs)
   )
 )
;; variables:1 ends here

;; keybinding

;; [[file:../emacs-config.org::*keybinding][keybinding:1]]
:bind
(
 :map org-mode-map
 ("M-i" . org-shiftmetaleft)
 ("M-k" . org-metaup)
 ("M-j" . org-metadown)
 ("M-l" . org-shiftmetaright)
 ("M-o" . org-metaleft)
 ("M-p" . org-metaright)
 )

:ryo
(:mode 'org-mode)
("<shifttab>" org-shifttab)
("5" +org/dwim-at-point)
("6" org-insert-heading-respect-content)
("8" org-export-dispatch)
("C" org-copy-subtree)
("d" weiss-org-cut-line-or-delete-region)
("j" next-line :first '(deactivate-mark))
("k" previous-line :first '(deactivate-mark))
("u" weiss-org-preview-latex-and-image)
("n" weiss-org-search)
("x" weiss-org-sp-switch)
("X" org-refile)
("t" (
      ("a" weiss-org-screenshot)
      ("o" org-noter)
      ("d" weiss-org-download-img)
      ("q" org-set-tags-command)
      ("s" org-noter-sync-current-note)
      ("t" org-todo)
      ("b" org-mark-ring-goto)
      ))
("<escape> o" (
               ("e"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src elisp" "#+end_src" t)))
                :name "elisp babel")
               ("="
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src c++" "#+end_src" t)))
                :name "c++ babel")
               ("p"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src python" "#+end_src" t)))
                :name "python babel")
               ("l"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src latex" "#+end_src" t)))
                :name "latex babel")
               ("j"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src java" "#+end_src" t)))
                :name "java babel")
               ("g"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src go" "#+end_src" t)))
                :name "golang babel")
               ("s"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src sh" "#+end_src" t)))
                :name "sh babel")
               ("h"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src html" "#+end_src" t)))
                :name "html babel")
               ("r"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src R" "#+end_src" t)))
                :name "R babel")
               ("c"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src conf" "#+end_src" t)))
                :name "conf babel")
               ("q"
                ignore
                :then ((lambda () (interactive) (weiss-insert-bracket-pair "#+begin_src sql" "#+end_src" t)))
                :name "sql babel")
               )
 )
(:mode 'org-agenda-mode)
("-" xah-backward-punct)
("=" xah-forward-punct)
;; ("d" org-agenda-done)
;; ("q" org-agenda-exit)
;; ("r" org-agenda-redo)
;; ("t" org-agenda-todo)
;; keybinding:1 ends here

;; config

;; [[file:../emacs-config.org::*config][config:1]]
:config
;; config:1 ends here

;; functions

;; [[file:../emacs-config.org::*functions][functions:1]]
(defun weiss-org-refile (arg)
  "normally only refile current file, refile all files in org-refile-targets with current-prefix-arg"
  (interactive "p")
  (let ((current-prefix-arg))
    (if (eq arg 1)
        (weiss-org-refile-current-file)    
      (call-interactively #'org-refile)
      ) 
    )
  )

(defun weiss-org-refile-current-file ()
  "only refile current file"
  (interactive)
  (let ((org-refile-targets `((,buffer-file-name :maxlevel . 4)))
        (org-refile-use-outline-path nil))
    (message "targets: %s" org-refile-targets)
    (call-interactively #'org-refile)
    )
  )

(defun weiss-org-search ()
  "execute different search commands with universal argument"
  (interactive)
  (let ((arg-v (prefix-numeric-value current-prefix-arg)))
    (setq current-prefix-arg nil)
    (cond
     ((eq arg-v 4) (counsel-org-goto))
     ((> arg-v 4) (counsel-org-goto-all))
     (t (swiper-isearch-thing-at-point))
     )
    )
  )

(defun weiss-shrink-window-if-larger-than-buffer (&optional window min-window-size)
  "Weiss: add optional arg min-window-size
Shrink height of WINDOW if its buffer doesn't need so many lines.
More precisely, shrink WINDOW vertically to be as small as
possible, while still showing the full contents of its buffer.
WINDOW must be a live window and defaults to the selected one.

Do not shrink WINDOW to less than `window-min-height' lines.  Do
nothing if the buffer contains more lines than the present window
height, or if some of the window's contents are scrolled out of
view, or if shrinking this window would also shrink another
window, or if the window is the only window of its frame.

Return non-nil if the window was shrunk, nil otherwise."
  (interactive)
  (setq window (window-normalize-window window t))
  ;; Make sure that WINDOW is vertically combined and `point-min' is
  ;; visible (for whatever reason that's needed).  The remaining issues
  ;; should be taken care of by `fit-window-to-buffer'.
  (when (and (window-combined-p window)
             (pos-visible-in-window-p (point-min) window))
    (fit-window-to-buffer window (window-total-height window) min-window-size)))

(defun weiss-org-cut-line-or-delete-region ()
  "DOCSTRING"
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end) t)
    (progn
      (beginning-of-line)
      (org-kill-line)
      (kill-region (line-beginning-position) (line-beginning-position 2)))))

(defun weiss-delete-backward-bracket-and-mark-bracket-text-org-mode ()
  "DOCSTRING"
  (interactive)
  (cond
   ((member (char-to-string (char-after)) '("<" ">"))  (delete-char -1))
   ((member (char-to-string (char-before)) weiss-org-special-markers)
    (let ((before-point (point))
          (mark-point )
          (special-marker (char-to-string (char-before))))      
      (delete-char -1)
      (when (string-match (regexp-opt (list special-marker)) (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        (if (member (char-to-string (char-before (- (point) 0))) (list " " "\n"))
            (progn (search-forward special-marker)
                   (delete-char -1)
                   (setq mark-point (- before-point 1))
                   )
          (search-backward special-marker)          
          (delete-char 1)
          (setq mark-point (- before-point 2))
          )
        (push-mark mark-point)
        (setq mark-active t)
        (setq deactivate-mark nil)
        (exchange-point-and-mark)
        ))
    )
   (t
    (xah-delete-backward-char-or-bracket-text)
    ;; (message "%s" "123")
    )
   )
  )

(defun weiss-delete-forward-bracket-and-mark-bracket-text-org-mode ()
  "DOCSTRING"
  (interactive)
  (cond
   ((member (char-to-string (char-after)) '("<" ">"))  (delete-char 1))
   ((member (char-to-string (char-after)) weiss-org-special-markers)
    (let ((before-point (point))
          (mark-point )
          (special-marker (char-to-string (char-after))))      
      (delete-char 1)
      (when (string-match (regexp-opt (list special-marker)) (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        (if (member (char-to-string (char-before (- (point) 0))) (list " " "\n"))
            (progn (search-forward special-marker)
                   (delete-char -1)
                   (setq mark-point (- before-point 1))
                   )
          (search-backward special-marker)          
          (delete-char 1)
          (setq mark-point (- before-point 1))
          )
        (push-mark mark-point)
        (setq mark-active t)
        (setq deactivate-mark nil)
        (exchange-point-and-mark)
        ))
    )
   (t (xah-delete-forward-char-or-bracket-text))
   )
  )

(defun weiss-delete-backward-bracket-and-text-org-mode ()
  "DOCSTRING"
  (interactive)
  (weiss-delete-backward-bracket-and-mark-bracket-text-org-mode)
  (when (use-region-p) (kill-region (region-beginning) (region-end)))
  )

(defun weiss-delete-forward-bracket-and-text-org-mode ()
  "DOCSTRING"
  (interactive)
  (weiss-delete-forward-bracket-and-mark-bracket-text-org-mode)
  (when (use-region-p) (kill-region (region-beginning) (region-end)))
  )

(defun weiss-switch-and-bookmarks-search()
  (interactive)
  (find-file "~/Documents/OrgFiles/Einsammlung.org")
  (org-agenda nil "b"))

(defun weiss-org-archive()
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'org-archive-subtree))

(defun weiss-org-preview-latex-and-image()
  (interactive)
  "if current prefix arg, then remove all the inline images and latex preview, else display all of them."
  (if current-prefix-arg
      (let ((current-prefix-arg '(64)))
        (call-interactively 'org-latex-preview) 
        (org-remove-inline-images)
        )
    (let ((current-prefix-arg '(16)))
      (call-interactively 'org-latex-preview)
      (org-display-inline-images))
    )
  )

(defun weiss-org-screenshot ()
  "call flameshot to capture screen shot"
  (interactive)
  (weiss-org-insert-image "flameshot-caputre.png" (concat "flameshot gui -p " weiss/org-img-path))
  )

(defun weiss-org-download-img ()
  "download the img link from clipboard"
  (interactive)
  (weiss-org-insert-image
   "wget-img.png"
   (format "wget -O %swget-img.png %s" weiss/org-img-path (substring-no-properties (gui-get-selection 'CLIPBOARD (or x-select-request-type 'UTF8_STRING))))
   t)    
  )
;; flameshot-caputre.png
(defun weiss-org-insert-image (pic-name command &optional img-attr)
  "insert image to org"
  (interactive)
  (let* ((path weiss/org-img-path)
         (name (format "%s.png" (format-time-string "%Y-%m-%d_%H-%M-%S")))
         (old-name (concat path pic-name))
         (new-name (concat path name))
         )
    (when (file-exists-p old-name)
      (delete-file old-name)
      )
    (shell-command-to-string command)
    (while (not (file-exists-p old-name))
      (sit-for 0.1)
      )
    (rename-file old-name new-name)
    (end-of-line)
    (insert "\n")
    (when img-attr
      (insert "#+ATTR_org: :width 600\n")
      )
    (insert (concat "[[" new-name  "]]"))
    )  
  (org-display-inline-images))

;;https://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it

(defun weiss-custom-daily-agenda()
  (interactive)
  (org-agenda nil "c"))
;; (getenv "PATH")

(defun +org--toggle-inline-images-in-subtree (&optional beg end refresh)
  "Refresh inline image previews in the current heading/tree."
  (let ((beg (or beg
                 (if (org-before-first-heading-p)
                     (line-beginning-position)
                   (save-excursion (org-back-to-heading) (point)))))
        (end (or end
                 (if (org-before-first-heading-p)
                     (line-end-position)
                   (save-excursion (org-end-of-subtree) (point)))))
        (overlays (cl-remove-if-not (lambda (ov) (overlay-get ov 'org-image-overlay))
                                    (ignore-errors (overlays-in beg end)))))
    (dolist (ov overlays nil)
      (delete-overlay ov)
      (setq org-inline-image-overlays (delete ov org-inline-image-overlays)))
    (when (or refresh (not overlays))
      (org-display-inline-images t t beg end)
      t)))

(defun +org/dwim-at-point (&optional arg)
  "Do-what-I-mean at point.
 If on a:
 - checkbox list item or todo heading: toggle it.
 - clock: update its time.
 - headline: cycle ARCHIVE subtrees, toggle latex fragments and inline images in
   subtree; update statistics cookies/checkboxes and ToCs.
 - footnote reference: jump to the footnote's definition
 - footnote definition: jump to the first reference of this footnote
 - table-row or a TBLFM: recalculate the table's formulas
 - table-cell: clear it and go into insert mode. If this is a formula cell,
   recaluclate it instead.
 - babel-call: execute the source block
 - statistics-cookie: update it.
 - latex fragment: toggle it.
 - link: follow it
 - otherwise, refresh all inline images in current tree."
  ;; (interactive "P")
  (interactive "P")
  ;; (interactive)
  (let* ((context (org-element-context))
         (type (org-element-type context)))
    ;; skip over unimportant contexts
    (while (and context (memq type '(verbatim code bold italic underline strike-through subscript superscript)))
      (setq context (org-element-property :parent context)
            type (org-element-type context)))
    (pcase type
      (`headline
       (cond ((memq (bound-and-true-p org-goto-map)
                    (current-active-maps))
              (org-goto-ret))
             ((and (fboundp 'toc-org-insert-toc)
                   (member "TOC" (org-get-tags)))
              (toc-org-insert-toc)
              (message "Updating table of contents"))
             ((string= "ARCHIVE" (car-safe (org-get-tags)))
              (org-force-cycle-archived))
             ((or (org-element-property :todo-type context)
                  (org-element-property :scheduled context))
              (org-todo
               (if (eq (org-element-property :todo-type context) 'done)
                   '"TODO"
                 '"DONE"))))
       ;; Update any metadata or inline previews in this subtree
       (org-update-checkbox-count)
       (org-update-parent-todo-statistics)
       (when (and (fboundp 'toc-org-insert-toc)
                  (member "TOC" (org-get-tags)))
         (toc-org-insert-toc)
         (message "Updating table of contents"))
       (let* ((beg (if (org-before-first-heading-p)
                       (line-beginning-position)
                     (save-excursion (org-back-to-heading) (point))))
              (end (if (org-before-first-heading-p)
                       (line-end-position)
                     (save-excursion (org-end-of-subtree) (point))))
              (overlays (ignore-errors (overlays-in beg end)))
              (latex-overlays
               (cl-find-if (lambda (o) (eq (overlay-get o 'org-overlay-type) 'org-latex-overlay))
                           overlays))
              (image-overlays
               (cl-find-if (lambda (o) (overlay-get o 'org-image-overlay))
                           overlays)))
         (+org--toggle-inline-images-in-subtree beg end)
         (if (or image-overlays latex-overlays)
             (org-clear-latex-preview beg end)
           (org--latex-preview-region beg end))))

      (`clock (org-clock-update-time-maybe))

      (`footnote-reference
       (org-footnote-goto-definition (org-element-property :label context)))

      (`footnote-definition
       (org-footnote-goto-previous-reference (org-element-property :label context)))

      ((or `planning `timestamp)
       (org-follow-timestamp-link))

      ((or `table `table-row)
       (if (org-at-TBLFM-p)
           (org-table-calc-current-TBLFM)
         (ignore-errors
           (save-excursion
             (goto-char (org-element-property :contents-begin context))
             (org-call-with-arg 'org-table-recalculate (or arg t))))))

      (`table-cell
       (org-table-blank-field)
       (org-table-recalculate arg)
       (when (and (string-empty-p (string-trim (org-table-get-field)))
                  (bound-and-true-p evil-local-mode))
         (evil-change-state 'insert)))

      (`babel-call
       (org-babel-lob-execute-maybe))

      (`statistics-cookie
       (save-excursion (org-update-statistics-cookies arg)))

      ((or `src-block `inline-src-block)
       (org-babel-execute-src-block arg))

      ((or `latex-fragment `latex-environment)
       (org-latex-preview arg))

      (`link
       (let* ((lineage (org-element-lineage context '(link) t))
              (path (org-element-property :path lineage)))
         (if (or (equal (org-element-property :type lineage) "img")
                 (and path (image-type-from-file-name path)))
             (+org--toggle-inline-images-in-subtree
              (org-element-property :begin lineage)
              (org-element-property :end lineage))
           (org-open-at-point arg))))

      ((guard (org-element-property :checkbox (org-element-lineage context '(item) t)))
       (let ((match (and (org-at-item-checkbox-p) (match-string 1))))
         (org-toggle-checkbox (if (equal match "[ ]") '(16)))))
      (_
       (if (or (org-in-regexp org-ts-regexp-both nil t)
               (org-in-regexp org-tsr-regexp-both nil  t)
               (org-in-regexp org-link-any-re nil t))
           (call-interactively #'org-open-at-point)
         (+org--toggle-inline-images-in-subtree
          (org-element-property :begin context)
          (org-element-property :end context)))))))
;; functions:1 ends here

;; babel

;; [[file:../emacs-config.org::*babel][babel:1]]
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

(setq load-language-list '((emacs-lisp . t)
                           (perl . t)
                           (python . t)
                           (ruby . t)
                           (js . t)
                           (css . t)
                           (sass . t)
                           (C . t)
                           ;; (C++ . t)
                           (plantuml . t)))

;; ob-sh renamed to ob-shell since 26.1.
(cl-pushnew '(shell . t) load-language-list)

(use-package ob-fsharp
  :init (cl-pushnew '(fsharp . t) load-language-list))

(use-package ob-javascript
  :quelpa (ob-javascript
           :fetcher github
           :repo "zweifisch/ob-javascript"
           )
  :init (cl-pushnew '(javascript . t) load-language-list))

(use-package ob-C
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages '((C . t))))

(use-package ob-go
  :init (cl-pushnew '(go . t) load-language-list))

(use-package ob-rust
  :init (cl-pushnew '(rust . t) load-language-list))

;; (use-package ob-ipython
;; :if (executable-find "jupyter") ; DO NOT remove
;; :init (cl-pushnew '(ipython . t) load-language-list))

(use-package ob-java
  :init (cl-pushnew '(java . t) load-language-list))

(use-package ob-R
  :ensure nil
  :load-path "/home/weiss/.emacs.d/local-package"
  :init (cl-pushnew '(R . t) load-language-list))

(use-package ob-sql-mode
  :init (cl-pushnew '(sql . t) load-language-list))

(org-babel-do-load-languages 'org-babel-load-languages
                             load-language-list)
;; babel:1 ends here

;; export

;; [[file:../emacs-config.org::*export][export:1]]
;; Enable markdown backend
(add-to-list 'org-export-backends 'md)
;; export:1 ends here

;; org-roam

;; [[file:../emacs-config.org::*org-roam][org-roam:1]]
(use-package org-roam
  :init
  (add-hook 'after-init-hook 'org-roam-mode)
  (setq
   org-roam-directory "~/Documents/Org-roam")
  :ryo
  (:mode 'org-mode)
  ("t i" org-roam-insert)
  ("t r" org-roam)
  ("t j"
   (
    ("t" org-roam-tag-add)
    ("n" org-roam-capture)
    ("s" weiss-org-roam-copy-heading-link)    
    ))

  :config
  (defun weiss-org-roam--title-to-slug (title)
    "add Umlaut convert"
    (let ((l '(
               ("ä" . "ae")
               ("ö" . "oe")
               ("ü" . "ue")
               ("ß" . "ss")
               )
             )
          )
      (dolist (x l title) 
        (setq title (replace-regexp-in-string (car x) (cdr x) title))
        )      
      )
    (org-roam--title-to-slug title)
    )
  (setq org-roam-title-to-slug-function 'weiss-org-roam--title-to-slug)
  (defun weiss-org-roam-copy-heading-link ()
    "copy the current heading link in roam format"
    (interactive)
    (let ((id (org-id-get-create))
          (title (read-string "Description: " (substring-no-properties (org-get-heading t t t t)) ))
          )
      (kill-new (format " [[id:%s][%s]]" id title))
      )
    )

  ;; open link from roam direkt in browser
  (with-no-warnings
    (defun weiss-org-link-open-as-file (path arg)
      "Pretend PATH is a file name and open it.

According to \"file\"-link syntax, PATH may include additional
search options, separated from the file name with \"::\".

This function is meant to be used as a possible tool for
`:follow' property in `org-link-parameters'."
      (let* ((option (and (string-match "::\\(.*\\)\\'" path)
                          (match-string 1 path)))
             (file-name (if (not option) path
                          (substring path 0 (match-beginning 0)))))
        (if (string-match "[*?{]" (file-name-nondirectory file-name))
            (dired file-name)
          (if (string-prefix-p "Ʀlink:" (file-name-nondirectory file-name))
              (with-temp-buffer
                (insert-file-contents file-name)
                (goto-line 3)
                (browse-url (buffer-substring-no-properties (+ (line-beginning-position) 12) (line-end-position)))
                )
            (apply #'org-open-file
                   file-name
                   arg
                   (cond ((not option) nil)
                         ((string-match-p "\\`[0-9]+\\'" option)
                          (list (string-to-number option)))
                         (t (list nil option))))
            )
          )))

    (advice-add 'org-link-open-as-file :override 'weiss-org-link-open-as-file)
    )


  (add-to-list 'ivy-initial-inputs-alist '(org-roam-find-file . "^"))
  (add-to-list 'ivy-initial-inputs-alist '(org-roam-insert . "^"))
  (defun weiss-org-roam--prepend-tag-string (str tags)
    "Prepend TAGS to STR."
    (concat
     str
     (when tags
       (propertize (format "(%s) " (s-join org-roam-tag-separator tags))
                   'face 'org-roam-tag))
     ))
  (advice-add 'org-roam--prepend-tag-string :override 'weiss-org-roam--prepend-tag-string)

  (defun weiss-roam-find-file (filename &optional wildcards)
    "DOCSTRING"
    (interactive
     (find-file-read-args "Find file: "
                          (confirm-nonexistent-file-or-buffer)))
    (if (string-prefix-p "Ʀlink:" (file-name-nondirectory filename))
        (with-temp-buffer
          (insert-file-contents filename)
          (goto-line 3)
          (browse-url (buffer-substring-no-properties (+ (line-beginning-position) 12) (line-end-position)))
          )
      (find-file filename wildcards)
      )
    )

  (setq
   org-roam-db-update-idle-seconds 0
   org-roam-db-update-method 'immediate
   org-roam-find-file-function 'weiss-roam-find-file
   )
  (setq org-roam-capture-templates
        '(
          ("d" "default" plain (function org-roam-capture--get-point)
           "* ${title}\n** %?"
           :file-name "Ʀ${slug}_%<%Y%m%d%H>"
           :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags:\n")
          ("p" "project" plain (function org-roam-capture--get-point)
           "* ${title}\n** link:\n*** \n** %?"
           :file-name "ƦProjecct-${slug}_%<%Y%m%d%H>"
           :head "#+title: Project-${title}\n#+roam_alias: p-${slug}\n#+roam_tags: project \n")
          ("n" "note" plain (function org-roam-capture--get-point)
           "* ${title}\n %?"
           :file-name "ƦNote-${slug}_%<%Y%m%d%H>"
           :head "#+title: note-${title}\n#+roam_alias: n-${slug}\n#+roam_tags: note \n")
          ("t" "tutorial" plain (function org-roam-capture--get-point)
           "* [[file:ƦUseful-commands-${title}_%<%Y%m%d%H>.org][useful commands]]\n* link\n** \n%?"
           :file-name "ƦTutorial-${slug}_%<%Y%m%d%H>"
           :head "#+title: Tutorial-${title}\n#+roam_alias: t-${slug}\n#+roam_tags: tutorial f-${slug}\n")
          ("c" "useful commands" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "ƦUseful-commands-${slug}_%<%Y%m%d%H>"
           :head "#+title: Useful-commands-${title}\n#+roam_alias: uc-${slug}\n#+roam_tags: useful-commands f-${slug}\n")

          ("l" "link" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "Ʀlink:${slug}"
           :head "#+title: ${title}\n#+roam_alias: l-${slug}\n#+roam_key: %c\n"
           )
          )
        )
  (setq org-roam-dailies-capture-templates
        '(
          ("t" "Todo" entry #'org-roam-capture--get-point
           "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (current-time))"
           :file-name "daily/d-%<%Y-%m-%d>"
           :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
           :olp ("Todo")
           )
          ("f" "Fleeting notes" entry #'org-roam-capture--get-point
           "* TODO %?"
           :file-name "daily/d-%<%Y-%m-%d>"
           :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
           :olp ("Fleeting notes")
           )
          ("Journey" "Journey" entry #'org-roam-capture--get-point
           "* %?"
           :file-name "daily/d-%<%Y-%m-%d>"
           :head "#+title: Daily-%<%Y-%m-%d>\n#+roam_tags: Daily\n"
           :olp ("Journey")
           )
          ))

  (use-package org-roam-server
    :config
    (setq org-roam-server-host "127.0.0.1"
          org-roam-server-port 9090
          org-roam-server-export-inline-images t
          org-roam-server-authenticate nil
          org-roam-server-network-label-truncate t
          org-roam-server-network-label-truncate-length 60
          org-roam-server-network-label-wrap-length 20))
  (use-package org-transclusion
    ;; :quelpa (org-transclusion 
    ;;          :fetcher github 
    ;;          :repo nobiot/org-transclusion)
    :ensure nil
    )
  )
;; org-roam:1 ends here

;; misc packages

;; [[file:../emacs-config.org::*misc packages][misc packages:1]]
(use-package org-agenda)
(use-package org-fancy-priorities
  :diminish
  :after org
  :hook (org-mode . org-fancy-priorities-mode)
  :config

  (setq org-fancy-priorities-list '("⚡⚡" "⚡" "❄")
        org-priority-faces '((65 :foreground "#de3d2f" :weight bold)
                             (66 :foreground "#da8548" :weight bold)
                             (67 :foreground "#0098dd"))))

(use-package org-bullets
  :disabled
  :diminish
  :after org
  :hook (org-mode . org-bullets-mode)
  :config
  (setq  org-bullets-bullet-list '("◉" "◆" "●" "◇" "○" "→" "·" ))
  ;; “♰” “☥” “✞” “✟” “✝” “†” “✠” “✚” “✜” “✛” “✢” “✣” “✤” “✥” “♱” "✙”  "◉"  "○" "✸" "✿" ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
  )

;; Rich text clipboard
(use-package org-rich-yank
  :diminish
  :bind (:map org-mode-map
              ("C-v" . org-rich-yank)))

(use-package org-tempo ; for <s expand in org-babel
  ;; :disabled
  :diminish
  :after org
  :ensure nil
  :config
  (add-to-list 'org-structure-template-alist '("le" . "src elisp"))
  (add-to-list 'org-structure-template-alist '("lcp" . "src c++"))
  (add-to-list 'org-structure-template-alist '("lp" . "src python"))
  (add-to-list 'org-structure-template-alist '("ll" . "src latex"))
  (add-to-list 'org-structure-template-alist '("lj" . "src java"))
  (add-to-list 'org-structure-template-alist '("ls" . "src sh"))
  (add-to-list 'org-structure-template-alist '("lh" . "src html"))
  (add-to-list 'org-structure-template-alist '("lr" . "src R"))
  (add-to-list 'org-structure-template-alist '("lc" . "src conf"))
  (add-to-list 'org-structure-template-alist '("lq" . "src sql"))
  )
;; misc packages:1 ends here

;; end

;; [[file:../emacs-config.org::*end][end:1]]
)
(provide 'weiss-org)
;; end:1 ends here
