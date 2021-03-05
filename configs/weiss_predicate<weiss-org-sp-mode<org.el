(defvar weiss-org-sp-sharp "^\\(?:#\\+\\(?:\\(?:begin\\|end\\)_src\\)\\)"
  "Shortcut for the org's #+ regex.")

(defvar weiss-org-sp-sharp-begin "^#\\+begin_src"
  "Shortcut for the org's #+ regex.")

(defvar weiss-org-sp-sharp-end "^#\\+end_src"
  "Shortcut for the org's #+ regex.")

(defvar weiss-org-sp-regex "^\\(?:\\*\\)"
  "Shortcut for weiss-org-sp's special regex.")
(setq weiss-org-sp-regex "^\\(?:#\\+\\(?:\\(?:begin\\|end\\)_src\\)\\|\\*\\)" )


(defvar weiss-org-sp-regex-full "^\\(?:\\*+ \\|:\\)"
  "Shortcut for weiss-org-sp's special regex.")

(defun weiss-org-sp--special-p ()
  "Return t if point is special.
When point is special, alphanumeric keys call commands instead of
calling `self-insert-command'."
  (and (bolp)
       (or
        (looking-at weiss-org-sp-regex)
        (looking-at weiss-org-sp-sharp)
        (weiss-org-sp--at-property-p)
        (looking-back "^\\*+" (line-beginning-position))
        (looking-at "CLOCK:"))))

(defun weiss-org-sp--ensure-visible ()
  "Remove overlays hiding point."
  (let ((overlays (overlays-at (point)))
        ov expose)
    (while (setq ov (pop overlays))
      (if (and (invisible-p (overlay-get ov 'invisible))
               (setq expose (overlay-get ov 'isearch-open-invisible)))
          (funcall expose ov)))))

(defun weiss-org-sp--at-property-p ()
  "Return t if point is at property."
  (looking-at "^:"))

(defun weiss-org-sp--invisible-p ()
  "Test if point is hidden by an `org-block' overlay."
  (cl-some (lambda (ov) (memq (overlay-get ov 'invisible)
                              '(org-hide-block outline)))
           (overlays-at (point))))

(provide 'weiss_predicate<weiss-org-sp-mode<org)
