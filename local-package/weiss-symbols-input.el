;;; weiss-symbols-input.el --- a minor mode for inputting math and Unicode symbols. -*- coding: utf-8; lexical-binding: t; -*-



;;; Code:
(string-to-number "a")
(defun weiss-latex-tikz-expand ()
  "Format:
node: n[i][a]-%d-r/b%d
edge: e[a][b]-%d-[a][b]-%d"
  (interactive)
  (let ((beginning-point)
        (end-point (point))
        (input-string-list)
        (first-char)
        (output-string ""))
    (search-backward " ")
    (setq beginning-point (1+ (point)))
    (setq first-char (buffer-substring-no-properties (1+ (point)) (+ 2 (point))))
    (setq input-string-list (split-string (delete-and-extract-region beginning-point end-point) "-"))
    (forward-char)
    (cond
     ((string= first-char "n")
      ;; (message "%s" "n")
      (let* ((tikz-node-attribut)
             (tikz-node-id (nth 1 input-string-list))
             (tikz-node-pos "")
             (tikz-node-name (format "{$q_%s$}" tikz-node-id)))
        (setq tikz-node-attribut "state")
        (when (string-match "i" (nth 0 input-string-list)) (setq tikz-node-attribut (concat tikz-node-attribut ",initial")))
        (when (string-match "a" (nth 0 input-string-list)) (setq tikz-node-attribut (concat tikz-node-attribut ",accepting")))
        (unless (nth 2 input-string-list)
          (when (string-match "l" (nth 2 input-string-list)) (setq tikz-node-pos (concat tikz-node-pos "left")))
          (when (string-match "a" (nth 2 input-string-list)) (setq tikz-node-pos (concat tikz-node-pos "above")))
          (when (string-match "r" (nth 2 input-string-list)) (setq tikz-node-pos (concat tikz-node-pos "right")))
          (when (string-match "b" (nth 2 input-string-list)) (setq tikz-node-pos (concat tikz-node-pos "below")))
          (setq tikz-node-pos (format "[%s of = %s]" tikz-node-pos (substring (nth 2 input-string-list) 1 2))))
        (unless (string= tikz-node-pos ""))
        (setq output-string (format "\\node[%s] (%s) %s %s;" tikz-node-attribut tikz-node-id tikz-node-pos tikz-node-name))))
     ;; edge: e[a][b]-%d-[a][b]-text-%d
     ((string= first-char "e")
      (let* ((tikz-edge-loop "")
             (tikz-edge-node-from (nth 1 input-string-list))
             (tikz-edge-text-pos)
             (tikz-edge-text (nth 3 input-string-list))
             (tikz-edge-node-to (nth 4 input-string-list)))
        (when (string-match "a" (nth 0 input-string-list)) (setq tikz-edge-loop "[loop above]"))
        (when (string-match "b" (nth 0 input-string-list)) (setq tikz-edge-loop "[loop below]"))
        (when (string-match "l" (nth 0 input-string-list)) (setq tikz-edge-loop "[bend left]"))
        (when (string-match "r" (nth 0 input-string-list)) (setq tikz-edge-loop "[bend right]"))
        (when (string-match "a" (nth 2 input-string-list)) (setq tikz-edge-text-pos "node[above]"))
        (when (string-match "b" (nth 2 input-string-list)) (setq tikz-edge-text-pos "node[below]"))
        (when (string-match "l" (nth 2 input-string-list)) (setq tikz-edge-text-pos "node[left]"))
        (when (string-match "r" (nth 2 input-string-list)) (setq tikz-edge-text-pos "node[right]"))
        (setq output-string (format "(%s) edge%s %s {%s} (%s)" tikz-edge-node-from tikz-edge-loop tikz-edge-text-pos tikz-edge-text tikz-edge-node-to))))
     ((string= first-char "f")
      (let ((tikz-node-attribut ""))
        (dotimes (i (- (length input-string-list) 1))
          (setq tikz-node-attribut "")
          (when (string-match "a" (nth i input-string-list)) (setq tikz-node-attribut (concat tikz-node-attribut ", accepting")))
          (if (= i 0)
              (progn
                (setq output-string (format "\\node[state, initial%s] (0)  {$q_0$};\n" tikz-node-attribut)))
            (setq output-string (format "%s\\node[state%s] (%d) [right of = %d] {$q_%d$};\n"  output-string tikz-node-attribut i (- i 1) i))))))
     (t nil))
    (insert output-string)
    (indent-region (point-min) (point-max))))



(defvar weiss-symbols-input-abrvs nil "A abbreviation hash table that maps a string to unicode char.")
(setq weiss-symbols-input-abrvs (make-hash-table :test 'equal))

(defun weiss-symbols-input--add-to-hash (@pairs)
  "Add @pairs to the hash table `weiss-symbols-input-abrvs'.
@pairs is a sequence of pairs. Each element is a sequence of 2 items, [key, value]."
  (mapc
   (lambda (x) (puthash (elt x 0) (elt x 1) weiss-symbols-input-abrvs))
   @pairs))

(weiss-symbols-input--add-to-hash
 ;; xml entities http://xahlee.info/js/html_xml_entities.html
 [
;;;;; Greek alphabet
  ["ga" "\\alpha"]
  ["gA" "\\Alpha"]

  ["gb" "\\beta"]
  ["gB" "\\Beta"]

  ["gd" "\\delta"]
  ["gD" "\\Delta"]

  ["ge" "\\epsilon"]
  ["gE" "\\Epsilon"]

  ["gf" "\\phi"]
  ["gF" "\\Phi"]

  ["gg" "\\gamma"]
  ["gG" "\\Gamma"]

  ["get" "\\eta"]
  ["gEt" "\\Eta"]

  ["gk" "\\kappa"]
  ["gK" "\\Kappa"]

  ["gl" "\\lambda"]
  ["gL" "\\Lambda"]

  ["gm" "\\mu"]
  ["gM" "\\Mu"]

  ["gn" "\\nu"]
  ["gN" "\\Nu"]

  ["go" "\\omega"]
  ["gO" "\\Omega"]

  ["gp" "\\pi"]
  ["gP" "\\Pi"]

  ["gq" "\\theta"]
  ["gQ" "\\Theta"]

  ["gr" "\\rho"]
  ["gR" "\\Rho"]

  ["gs" "\\sigma"]
  ["gS" "\\Sigma"]

  ["gt" "\\tau"]
  ["gT" "\\Tau"]

  ["gu" "\\upsilon"]
  ["gU" "\\Upsilon"]

  ["gv" "\\varepsilon"]
  ["gV" "\\Varepsilon"]

  ["gw" "\\xi"]
  ["gX" "\\Xi"]

  ["gx" "\\chi"]
  ["gX" "\\Chi"]

  ["gy" "\\psi"]
  ["gY" "\\Psi"]

  ["gz" "\\zeta"]
  ["gZ" "\\Zeta"]

;;;;; Logic
  ["la" "\\wedge "]
  ["lb" "\\bot "]
  ["lca" "\\cap "]
  ["lcu" "\\cup "]
  ["le" "\\exists "]
  ["lf" "\\forall "]
  ["lfj" "{\\tiny \\textifsym{d|><|d}}"]  
  ["li" "\\in "]
  ["lj" "\\bowtie "]
  ["llj" "{\\tiny \\textifsym{d|><|}}"]  
  ["ln" "\\neg "]
  ["lni" "\\notin "]
  ["lo" "\\vee "]
  ["lrj" "{\\tiny \\textifsym{|><|d}}"]  
  ["lsb" "\\subset "]
  ["lsbe" "\\subseteq "]
  ["lslj" "\\ltimes "]  
  ["lsp" "\\supset "]
  ["lspe" "\\supseteq "]
  ["lsrj" "\\rtimes "]  
  ["lt" "\\top "]
  ["lv" "\\vdash "]
  ["lvd" "\\vDash "]
  
;;;;; equal symbols
  ["es" "\\stackrel{IV}{=} "]
  ["el" "\\leq "]
  ["eg" "\\ge "]
  ["en" "\\neq "]
  ["ea" "\\approx "]
  ["ep" "\\prec "]

;;;;; operation symbols
  ["op" "\\cdot "]
  ["ox" "\\times "]
  ["od" "\\div "]
  ["opm" "\\pm "]
  ["os" "\\sqrt"]
  ["of" "\\frac"]
  ["oc" "\\circ "]
  ["och" "\\choose "]

;;;;; Arrays
  ["ar" "\\Rightarrow "]
  ["asr" "\\rightarrow "]
  ["al" "\\Leftarrow "]
  ["asl" "\\leftarrow "]
  ["alr" "\\Leftrightarrow "]
  ["aslr" "\\leftrightarrow "]
  ["at" "\\to "]
  ["atr" "\\twoheadrightarrow"]
  ["atl" "\\twoheadleftarrow"]

;;;;; Symbols
  ["sc" "\\textcircled"]
  ["si" "\\infty"]
  ["sq" "\\square"]
  ["ss" "\\#"]
  ["se" "\\emptyset"]
  ["sd" "\\dots "]
  ["sb" "\\  \\ \\text{\\faBolt}"]
  ["sbs" "\\verb|\\|"]
  ["sqed" "$\\hfill\\blacksquare$"]
  ["sl" "\\lim_{n \\to \\infty}"]
  ["sm" "\\mid "]

;;;;; Fast input
  ["frp" "\\mathbb{R}^+"]
  ["fr" "\\mathbb{R}"]
  ["fzp" "\\mathbb{Z}^+"]
  ["fz" "\\mathbb{Z}"]
  ["fnz" "\\mathbb{N}_0"]
  ["fn" "\\mathbb{N}"]

;;;;; escape
  ["b" "\\"]
  ["bb" "\\\\"]
  ["b-" "\\_ "]

;;;;; Misc
  ["ml" "\\left"]
  ["mr" "\\right"]
  ["mh" "\\hfill"]
  ["mn" "\\not"]
  ["mp" "\\path"]
  ["mb" "\\big"]
  ["mbb" "\\Big"]
  ["mbbb" "\\bigg"]
  ["mbbbb" "\\Bigg"]
  ["mnp" "\n\n\\newpage"]
  ]
 )

;; 2010-12-10. char to add
;; soft hyphen ­
;; ↥ ↧ ⇤ ⇥ ⤒ ⤓ ↨

(defun weiss-symbols-input--add-cycle (cycleList)
  "DOCSTRING"
  (let (
        (ll (- (length cycleList) 1) )
        (ii 0)
        )
    (while (< ii ll)
      (let (
            (charThis (elt cycleList ii ))
            (charNext (elt cycleList (+ ii 1) ))
            )
        (puthash charThis charNext weiss-symbols-input-abrvs)
        (setq ii (1+ ii) ) ) )
    (puthash (elt cycleList ll) (elt cycleList 0) weiss-symbols-input-abrvs)
    ))

;; cycle brackets
(weiss-symbols-input--add-cycle ["〘〙" "〔〕"])
(weiss-symbols-input--add-cycle ["〈〉" "《》"])
(weiss-symbols-input--add-cycle ["‹›" "«»"])
(weiss-symbols-input--add-cycle ["【】" "〖〗"])
(weiss-symbols-input--add-cycle ["「」" "『』"])

;; cycle arrows
(weiss-symbols-input--add-cycle ["←" "⇐"])
(weiss-symbols-input--add-cycle ["↑" "⇑"])
(weiss-symbols-input--add-cycle ["→" "⇒"])
(weiss-symbols-input--add-cycle ["↓" "⇓"])
(weiss-symbols-input--add-cycle ["↔" "⇔"])
(weiss-symbols-input--add-cycle ["⇐" "←"])
(weiss-symbols-input--add-cycle ["⇑" "↑"])
(weiss-symbols-input--add-cycle ["⇒" "→"])
(weiss-symbols-input--add-cycle ["⇓" "↓"])
(weiss-symbols-input--add-cycle ["⇔" "↔"])

;; equal, equivalence, congruence, similarity, identity
(weiss-symbols-input--add-cycle ["~" "∼" "〜" "≈" "≅"])
(weiss-symbols-input--add-cycle ["=" "≈" "≡" "≅"])

(weiss-symbols-input--add-cycle ["⊢" "⊣"])

;; dash, hyphen, minus sign
(weiss-symbols-input--add-cycle ["-" "–" "−" ])
(weiss-symbols-input--add-cycle [ "-" "‐" "‑"  "–"  "‒"])
(weiss-symbols-input--add-cycle ["—"  "―" ])

(weiss-symbols-input--add-cycle ["#" "♯" "№"])

(weiss-symbols-input--add-cycle ["θ" "ϑ"])

;; cycle black white chars
(weiss-symbols-input--add-cycle ["■" "□"])
(weiss-symbols-input--add-cycle ["●" "○"])
(weiss-symbols-input--add-cycle ["◆" "◇"])
(weiss-symbols-input--add-cycle ["▲" "△"])
(weiss-symbols-input--add-cycle ["◀" "◁"])
(weiss-symbols-input--add-cycle ["▶" "▷"])
(weiss-symbols-input--add-cycle ["▼" "▽"])
(weiss-symbols-input--add-cycle ["★" "☆"])
(weiss-symbols-input--add-cycle ["♠" "♤"])
(weiss-symbols-input--add-cycle ["♣" "♧"])
(weiss-symbols-input--add-cycle ["♥" "♡"])
(weiss-symbols-input--add-cycle ["♦" "♢"])

(weiss-symbols-input--add-cycle ["✂" "✄"])              ;scissor
(weiss-symbols-input--add-cycle ["↹" "⇥" "⇤"])          ; tab
(weiss-symbols-input--add-cycle ["⏎" "↩" "↵" "⌤" "⎆"])     ; return/enter

(weiss-symbols-input--add-cycle ["∇" "⌫" "⌦"])     ; del delete
(weiss-symbols-input--add-cycle ["↶" "⎌"])     ; undo
(weiss-symbols-input--add-cycle ["✲" "⎈" "‸"])     ; control

(weiss-symbols-input--add-cycle ["*" "•" "×"]) ; bullet, multiply, times

(weiss-symbols-input--add-cycle ["," "，"])
(weiss-symbols-input--add-cycle ["·" "。"])      ; MIDDLE DOT, IDEOGRAPHIC FULL STOP
(weiss-symbols-input--add-cycle [":" "："])    ; FULLWIDTH COLON
(weiss-symbols-input--add-cycle [";" "；"])
(weiss-symbols-input--add-cycle ["!" "❗" "❕" "！"])
(weiss-symbols-input--add-cycle ["♩" "♪" "♫" "♬"])
(weiss-symbols-input--add-cycle ["🎶" "🎵" "🎼"])

(weiss-symbols-input--add-cycle ["&" "＆" "﹠"])
(weiss-symbols-input--add-cycle ["?" "？" "�" "¿" "❓" "❔"])

(weiss-symbols-input--add-cycle [" " " " "　"])         ; space, NO-BREAK SPACE, IDEOGRAPHIC SPACE

(defun weiss-symbols-input--hash-to-list (hashtable)
  "Return a list that represent the HASHTABLE."
  (let (mylist)
    (maphash (lambda (kk vv) (setq mylist (cons (list vv kk) mylist))) hashtable)
    mylist
    ))

(defun weiss-symbols-input-list-math-symbols ()
  "Print a list of math symbols and their input abbreviations.
See `weiss-symbols-input-mode'."
  (interactive)
  (with-output-to-temp-buffer "*weiss-symbols-input output*"
    (mapc (lambda (tt)
            (princ (concat (car tt) " " (car (cdr tt)) "\n")))
          (sort
           (weiss-symbols-input--hash-to-list weiss-symbols-input-abrvs)
           (lambda
             (a b)
             (string< (car a) (car b)))))))

(defvar weiss-symbols-input-keymap nil "Keymap for weiss-symbols-input mode.")

(progn
  (setq weiss-symbols-input-keymap (make-sparse-keymap))
  (define-key weiss-symbols-input-keymap (kbd "S-SPC") 'weiss-symbols-input-change-to-symbol))

(defun weiss-symbols-input--abbr-to-symbol (@inputStr)
  "Returns a char corresponding to @inputStr.
If none found, return nil.
Version 2018-02-16"
  (let ($resultChar $charByNameResult)
    (setq $resultChar (gethash @inputStr weiss-symbols-input-abrvs))
    ;; (cond
    ;;  ($resultChar $resultChar)
    ;;  ;; begin with u+
    ;;  ((string-match "\\`u\\+\\([0-9a-fA-F]+\\)\\'" @inputStr) (char-to-string (string-to-number (match-string 1 @inputStr) 16)))
    ;;  ;; decimal. 「945」 or 「#945」
    ;;  ((string-match "\\`#?\\([0-9]+\\)\\'" @inputStr) (char-to-string (string-to-number (match-string 1 @inputStr))))
    ;;  ;; e.g. decimal with html entity markup. 「&#945;」
    ;;  ((string-match "\\`&#\\([0-9]+\\);\\'" @inputStr) (char-to-string (string-to-number (match-string 1 @inputStr))))
    ;;  ;; hex number. e.g. 「x3b1」 or 「#x3b1」
    ;;  ((string-match "\\`#?x\\([0-9a-fA-F]+\\)\\'" @inputStr) (char-to-string (string-to-number (match-string 1 @inputStr) 16)))
    ;;  ;; html entity hex number. e.g. 「&#x3b1;」
    ;;  ((string-match "\\`&#x\\([0-9a-fA-F]+\\);\\'" @inputStr) (char-to-string (string-to-number (match-string 1 @inputStr) 16)))
    ;;  ;; unicode full name. e.g. 「GREEK SMALL LETTER ALPHA」
    ;;  ((and (string-match "\\`\\([- a-zA-Z0-9]+\\)\\'" @inputStr)
    ;;        (setq $charByNameResult (weiss-symbols-input--name-to-codepoint @inputStr)))
    ;;   (char-to-string $charByNameResult))
    ;;  (t nil))
    ))

(defun weiss-symbols-input--name-to-codepoint (@name)
  "Returns integer that's the codepoint of Unicode char named @name (string).
Version 2018-07-09"
  (interactive)
  (if (version<= "26" emacs-version)
      (gethash @name (ucs-names))
    (assoc-string @name (ucs-names) t)))

(defun weiss-symbols-input-change-to-symbol (&optional print-message-when-no-match)
  "Change text selection or word to the left of cursor into a Unicode character.

A valid input can be any abbreviation listed by the command `weiss-symbols-input-list-math-symbols', or, any of the following form:

 945     ← decimal
 #945    ← decimal with prefix #
 &#945;  ← XML entity syntax

 x3b1    ← hexadimal with prefix x
 U+3B1   ← hexadimal with prefix U+ (lower case ok.)
 #x3b1   ← hexadimal with prefix #x
 &#x3b1; ← XML entity syntax

Full Unicode name can also be used, e.g. 「greek small letter alpha」.

If preceded by `universal-argument', print error message when no valid abbrev found.

See also: `weiss-symbols-input-mode'.
Version 2018-07-09"
  (interactive "P")
  (let ($p1 $p2 $inputStr $resultChar)
    (if (region-active-p)
        (progn
          (setq $p1 (region-beginning))
          (setq $p2 (region-end))
          (setq $inputStr (buffer-substring-no-properties $p1 $p2))
          (setq $resultChar (weiss-symbols-input--abbr-to-symbol $inputStr))
          (when $resultChar (progn (delete-region $p1 $p2) (insert $resultChar))))
      ;; if there's no text selection, grab all chars to the left of cursor point up to whitespace, try each string until there a valid abbrev found or none char left.
      (progn
        (setq $p2 (point))
        (skip-chars-backward "^ \t\n" -8)
        (setq $p1 (point))
        (while (and (not $resultChar) (>= (- $p2 $p1) 1))
          (setq $inputStr (buffer-substring-no-properties $p1 $p2))
          (setq $resultChar (weiss-symbols-input--abbr-to-symbol $inputStr))
          (when $resultChar (progn (goto-char $p2) (delete-region $p1 $p2) (insert $resultChar)))
          (setq $p1 (1+ $p1)))))
    (when (not $resultChar)
      (when print-message-when-no-match
        (weiss-symbols-input-list-math-symbols)
        (user-error "「%s」 no match found for that abbrev/input. M-x `weiss-symbols-input-list-math-symbols' for a list. Or use a decimal e.g. 「945」 or hexadecimal e.g. 「x3b1」, or full Unicode name e.g. 「greek small letter alpha」."  $inputStr)))))

;;;###autoload
(define-globalized-minor-mode global-weiss-symbols-input-mode weiss-symbols-input-mode weiss-symbols-input-mode-on)

;;;###autoload
(defun weiss-symbols-input-mode-on ()
  "Turn on `weiss-symbols-input-mode' in current buffer."
  (interactive)
  (weiss-symbols-input-mode 1))

;;;###autoload
(defun weiss-symbols-input-mode-off ()
  "Turn off `weiss-symbols-input-mode' in current buffer."
  (interactive)
  (weiss-symbols-input-mode 0))

(defun weiss-latex-expand-dwim ()
  "DOCSTRING"
  (interactive)
  (cond
   ((looking-back "1")
    (delete-char -1)
    (insert "."))
   ((looking-back "2")
    (delete-char -1)
    (weiss-latex-tikz-expand))
   (t (weiss-symbols-input-change-to-symbol))
   )
  )

;;;###autoload
(define-minor-mode weiss-symbols-input-mode
  "Toggle weiss-symbols-input minor mode.

A mode for inputting a math and Unicode symbols.

Type “inf”, then press \\[weiss-symbols-input-change-to-symbol] (or M-x `weiss-symbols-input-change-to-symbol'), then it becomes “∞”.

Other examples:
 a → α
 p → π
 /= → ≠ or ne
 >= → ≥ or ge
 -> → → or rarr
 and → ∧
etc.

If you have a text selection, then selected word will be taken as input. For example, type 「extraterrestrial alien」, select the phrase, then press \\[weiss-symbols-input-change-to-symbol], then it becomse 👽.

For the complete list of abbrevs, call `weiss-symbols-input-list-math-symbols'.

Decimal and hexadecimal can also be used. Example:

 945     ← decimal
 #945    ← decimal with prefix #
 &#945;  ← XML entity syntax

 x3b1    ← hexadimal with prefix x
 #x3b1   ← hexadimal with prefix #x
 &#x3b1; ← XML entity syntax

Full Unicode name can also be used, e.g. 「greek small letter alpha」.

If you wish to enter a symbor by full unicode name but do not know the full name, M-x `insert'. Asterisk “*” can be used as a wildcard to find the char. For example, M-x `insert' , then type 「*arrow」 then Tab, then emacs will list all unicode char names that has “arrow” in it. (this feature is part of Emacs 23)

Home page at: URL `http://ergoemacs.org/emacs/weiss-symbols-input-math-symbols-input.html'"
  nil
  :global nil
  :lighter " ∑α"
  :keymap weiss-symbols-input-keymap
  )

(provide 'weiss-symbols-input)

;;; weiss-symbols-input.el ends here
