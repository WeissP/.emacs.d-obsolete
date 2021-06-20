(defmacro +measure-time-1 (&rest body)
  "Measure the time it takes to evaluate BODY."
  `(let ((time (current-time)))
     ,@body
     (message "%.03fms"
              (* 1000 (float-time (time-since time))))))

(defmacro +measure-time (&rest body)
  "Measure the time it takes to evalutae BODY, repeat 10 times."
  `(let ((time (current-time))
         (n 10))
     (dotimes (_ n),@body)
     (message "%.03fms"
              (/ (* (float-time (time-since time)) 1000) n))))

;; (+measure-time (format-mode-line mode-line-format))


(defun weiss-line-empty-p ()
  "https://emacs.stackexchange.com/questions/16792/easiest-way-to-check-if-current-line-is-empty-ignoring-whitespace"
  (interactive)
  (ignore-errors (string-match-p "\\`\\s-*$" (thing-at-point 'line)))  
  )

(defun weiss-simulate-c-g ()
  "DOCSTRING"
  (interactive)
  (setq unread-command-events (listify-key-sequence "\C-g")))

(defun weiss-is-today ()
  "return `t' if now is before 4AM"
  (< (string-to-number (format-time-string "%H")) 4)
  )

;; comes from https://stackoverflow.com/questions/14489848/emacs-name-of-current-local-keymap
(defun keymap-symbol (keymap)
  "Return the symbol to which KEYMAP is bound, or nil if no such symbol exists."
  (catch 'gotit
    (mapatoms (lambda (sym)
                (and (boundp sym)
                     (eq (symbol-value sym) keymap)
                     (not (eq sym 'keymap))
                     (throw 'gotit sym))))))

;; undo-collapse comes from
;; https://emacs.stackexchange.com/questions/7558/how-to-collapse-undo-history
(defun undo-collapse-begin ()
  "push a mark that do nothing to the undo list"
  (push (list 'apply 'identity nil) buffer-undo-list))

(defun undo-collapse-end ()
  "Collapse undo history until a matching marker."
  (let ((marker (list 'apply 'identity nil)))
    (cond
     ((equal (car buffer-undo-list) marker)
      (setq buffer-undo-list (cdr buffer-undo-list))
      ;; (message "success, car")
      )   
     (t
      (let ((l buffer-undo-list)
            (limit 0))
        (while (and (not (equal (cadr l) marker))
                    )
          (setq limit (1+ limit))
          (cond
           ((null (cdr l))
            (error "undo-collapse-end with no matching marker"))
           ((null (cadr l))
            (setf (cdr l) (cddr l)))
           (t (setq l (cdr l)))))
        (setf (cdr l) (cddr l))
        ))) 
    ))


(defmacro with-undo-collapse (&rest body)
  "Execute body, then collapse any resulting undo boundaries."
  (declare (indent 0))
  (let ((buffer-var (make-symbol "buffer")))
    `(let ((,buffer-var (current-buffer)))
       (unwind-protect
           (progn
             (undo-collapse-begin)
             ,@body)
         (with-current-buffer ,buffer-var
           (undo-collapse-end))))))


(defun read-char-picky (prompt chars &optional inherit-input-method seconds)
  "Read characters like in `read-char-exclusive', but if input is
  not one of CHARS, return nil.  CHARS may be a list of characters,
  single-character strings, or a string of characters."
  (let ((chars (mapcar (lambda (x)
                         (if (characterp x) x (string-to-char x)))
                       (append chars nil)))
        (char  (read-char-exclusive prompt inherit-input-method seconds)))
    (when (memq char chars)
      (char-to-string char))))

(defun weiss-read-char-picky-from-list (picky-list)
  "Get the inputed number and return the nth element of list"
  (interactive)
  (let ((ra "")
        (rb ""))
    (nth (- (string-to-number (read-char-picky
                               (dotimes (i (length picky-list) ra) (setq ra (format "%s %s:%s" ra (1+ i) (nth i picky-list))))
                               (dotimes (i (length picky-list) rb) (setq rb (format "%s%s" rb (1+ i)))))) 1) picky-list)))

(defun weiss-eval-last-sexp-this-line()
  "eval last sexp this line"
  (interactive)
  (end-of-line)
  (eval-last-sexp()))

(defun weiss-universal-argument ()
  "Simulate C-u"
  (interactive)
  (if current-prefix-arg
      (call-interactively 'universal-argument-more)
    (universal-argument)  
    )
  )

(defun weiss-show-all-major-mode ()
  "Show all major mode and it's parent mode"
  (interactive)
  (let ((mode major-mode)
        parents)
    (while mode
      (setq parents (cons mode parents)
            mode (get mode 'derived-mode-parent)))
    (message "%s" (reverse parents)))
  )

(defun xah-show-kill-ring ()
  "Insert all `kill-ring' content in a new buffer named *copy history*.

URL `http://ergoemacs.org/emacs/emacs_show_kill_ring.html'
Version 2019-12-02"
  (interactive)
  (let (($buf (generate-new-buffer "*copy history*")))
    (progn
      (switch-to-buffer $buf)
      (funcall 'fundamental-mode)
      (dolist (x kill-ring )
        (insert x "\n\nhh=============================================================================\n\n"))
      (goto-char (point-min)))))

(defun weiss-refresh ()
  "let flycheck refresh"
  (interactive)
  (save-buffer)
  (when flycheck-mode (flycheck-buffer))
  )

(defun weiss-call-kmacro-multi-times ()
  "DOCSTRING"
  (interactive)
  (let ((times (string-to-number (read-string (format "Repeat Times: ") nil nil nil))))
    (dotimes (i times)
      (next-line)
      (call-last-kbd-macro)
      )
    ))


(defun weiss-execute-buffer ()
  "If the current buffer is elisp mode, then eval-buffer, else quickrun"
  (interactive)
  (save-buffer)
  (cond
   ((or (eq major-mode 'xah-elisp-mode) (eq major-mode 'emacs-lisp-mode)) (eval-buffer))
   ((string= (file-name-directory (buffer-file-name)) "/home/weiss/KaRat/datenbank/")
    (message "compile: %s" (shell-command-to-string "javac -Werror -cp '.:commons-io-2.8.0.jar' QuizzesSearch.java"))
    (message "output: %s" (shell-command-to-string "java -cp postgresql-42.2.18.jar:commons-io-2.8.0.jar:. QuizzesSearch"))
    )
   ((string-prefix-p "/home/weiss/KaRat/datenbank/KaRat-Quizzes/" (file-name-directory (buffer-file-name)))
    ;; (message ": %s" 123)
    (message "%s" (shell-command-to-string "go run /home/weiss/KaRat/datenbank/KaRat-Quizzes/main.go -tomlPath=/home/weiss/KaRat/datenbank/KaRat-Quizzes/input.toml"))
    )
   ((and (eq major-mode 'go-mode)
         (not (string= weiss-mode-line-projectile-root-dir "nil")))
    (let ((compilation-read-command)
              )
          (call-interactively 'projectile-run-project)
          )
    )
   (t (quickrun))
   )
  )


(defun weiss--execute-kbd-macro (kbd-macro)
  "Execute KBD-MACRO."
  (when-let ((cmd (key-binding (read-kbd-macro kbd-macro))))
    (call-interactively cmd)))

(provide 'weiss_misc-function<wks)
