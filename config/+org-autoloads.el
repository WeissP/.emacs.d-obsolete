;;; +org-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "+org" "+org.el" (24091 41430 34135 465000))
;;; Generated autoloads from +org.el

(autoload '+org-get-global-property "+org" "\
Get a document property named NAME (string) from an org FILE (defaults to
current file). Only scans first 2048 bytes of the document.

\(fn NAME &optional FILE BOUND)" nil nil)

(autoload '+org-get-todo-keywords-for "+org" "\
Returns the list of todo keywords that KEYWORD belongs to.

\(fn &optional KEYWORD)" nil nil)

(autoload '+org-pretty-mode "+org" "\
Hides emphasis markers and toggles pretty entities.

\(fn &optional ARG)" t nil)

(autoload '+org/dwim-at-point "+org" "\
Do-what-I-mean at point.

If on a:
- checkbox list item or todo heading: toggle it.
- clock: update its time.
- headline: toggle latex fragments and inline images underneath.
- footnote reference: jump to the footnote's definition
- footnote definition: jump to the first reference of this footnote
- table-row or a TBLFM: recalculate the table's formulas
- table-cell: clear it and go into insert mode. If this is a formula cell,
  recaluclate it instead.
- babel-call: execute the source block
- statistics-cookie: update it.
- latex fragment: toggle it.
- link: follow it
- otherwise, refresh all inline images in current tree.

\(fn)" t nil)

(autoload '+org/insert-item-below "+org" "\
Inserts a new heading, table cell or item below the current one.

\(fn COUNT)" t nil)

(autoload '+org/insert-item-above "+org" "\
Inserts a new heading, table cell or item above the current one.

\(fn COUNT)" t nil)

(autoload '+org/dedent "+org" "\
TODO

\(fn)" t nil)

(autoload '+org/toggle-clock "+org" "\
Toggles clock on the last clocked item.

Clock out if an active clock is running. Clock in otherwise.

If in an org file, clock in on the item at point. Otherwise clock into the last
task you clocked into.

See `org-clock-out', `org-clock-in' and `org-clock-in-last' for details on how
the prefix ARG changes this command's behavior.

\(fn ARG)" t nil)

(defalias #'+org/toggle-fold #'+org-cycle-only-current-subtree-h)

(autoload '+org/open-fold "+org" "\
Open the current fold (not but its children).

\(fn)" t nil)

(defalias #'+org/close-fold #'outline-hide-subtree)

(autoload '+org/show-next-fold-level "+org" "\
Decrease the fold-level of the visible area of the buffer. This unfolds
another level of headings on each invocation.

\(fn)" t nil)

(autoload '+org/hide-next-fold-level "+org" "\
Increase the global fold-level of the visible area of the buffer. This folds
another level of headings on each invocation.

\(fn)" t nil)

(autoload '+org-indent-maybe-h "+org" "\
Indent the current item (header or item), if possible.
Made for `org-tab-first-hook' in evil-mode.

\(fn)" t nil)

(autoload '+org-update-cookies-h "+org" "\
Update counts in headlines (aka \"cookies\").

\(fn)" nil nil)

(autoload '+org-yas-expand-maybe-h "+org" "\
Tries to expand a yasnippet snippet, if one is available. Made for
`org-tab-first-hook'.

\(fn)" nil nil)

(autoload '+org-cycle-only-current-subtree-h "+org" "\
Toggle the local fold at the point (as opposed to cycling through all levels
with `org-cycle').

\(fn &optional ARG)" t nil)

(autoload '+org-clear-babel-results-h "+org" "\
Remove the results block for the org babel block at point.

\(fn)" nil nil)

(autoload '+org-unfold-to-2nd-level-or-point-h "+org" "\
My version of the 'overview' #+STARTUP option: expand first-level headings.
Expands the first level, but no further. If point was left somewhere deeper,
unfold to point on startup.

\(fn)" nil nil)

(autoload '+org-remove-occur-highlights-h "+org" "\
Remove org occur highlights on ESC in normal mode.

\(fn)" nil nil)

(autoload '+org-enable-auto-update-cookies-h "+org" "\
Update statistics cookies when saving or exiting insert mode (`evil-mode').

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "+org" '("+org--")))

;;;***

(provide '+org-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; +org-autoloads.el ends here
