;; (defvar weiss-right-frame-pos 1690 "the position of left bord of right frame")
(defvar weiss-right-frame-pos 950 "the position of left bord of right frame")
(defvar weiss-is-laptop nil)

(advice-add 'weiss-new-frame :after (lambda (&rest args) (interactive) (weiss-update-top-windows t)))
;; (advice-add 'delete-frame :after (lambda () (interactive) (weiss-update-top-windows t)))
(add-hook 'window-state-change-functions #'(lambda (&rest args) (interactive) (weiss-update-top-windows t)))
(defun weiss-new-frame ()
  "make new frame on the same side of current frame or on the other side with prefix-arg"
  (interactive)
  (if (eq (weiss-is-frame-in-right-pos) (null current-prefix-arg))
      (make-frame initial-frame-alist)
    (make-frame default-frame-alist)
    )
  )

(defun weiss-split-or-delete-window ()
  "DOCSTRING"
  (interactive)
  (if (one-window-p)
      (call-interactively 'split-window-below)
    (weiss-delete-other-window)    
    )
  )

(defun weiss-delete-other-window ()
  "If the current buffer ist org src file, switch between maximize window size(but not delete other windows) and half window size, else delete other windows"
  (interactive)
  (if (string-prefix-p "*Org Src " (buffer-name))
      (if (< (/ (frame-height) (nth 1 (window-edges))) 3)
          (maximize-window)
        (balance-windows)  
        )
    (delete-other-windows)
    )
  )

(defun weiss-switch-laptop-and-desktop ()
  "DOCSTRING"
  (interactive)
  (if weiss-is-laptop
      (setq weiss-right-frame-pos 835
            default-frame-alist weiss-laptop-left-frame-alist
            initial-frame-alist weiss-laptop-right-frame-alist)  
    (setq weiss-right-frame-pos 1690
          default-frame-alist weiss-desktop-left-frame-alist
          initial-frame-alist weiss-desktop-right-frame-alist)  
    )
  (setq weiss-is-laptop (not weiss-is-laptop))
  )

(defun weiss-is-frame-in-right-pos (&optional frame)
  "check if the current is on the right side"
  (interactive)  
  (> (car (frame-edges frame)) weiss-right-frame-pos)
  )

(defun weiss--select-frame-with-check (frame)
  (let ((frames (visible-frame-list)))
    (if (member frame frames)
        (progn
          (select-frame-set-input-focus frame)
          (weiss-update-top-windows t)
          t
          )      
      (weiss-update-top-windows)
      nil
      )  
    )
  )

(defun weiss--find-frame (right &optional exclude-list)
  "DOCSTRING"
  (let ((current-frame (selected-frame))
        (target-frame (selected-frame))
        )
    (setq target-frame (next-frame target-frame))
    (while (not (or
                 (eq current-frame target-frame)
                 (and
                  (frame-live-p target-frame)                  
                  (frame-visible-p target-frame)                  
                  (or (not exclude-list) (not (member target-frame exclude-list))) 
                  (or (and right (weiss-is-frame-in-right-pos target-frame))
                      (and (not right) (not (weiss-is-frame-in-right-pos target-frame)))
                      )
                  )))
      ;; (message "%s" target-frame)
      (setq target-frame (next-frame target-frame)))    
    target-frame
    )
  )

(defun weiss--switch-to-right-or-left-frame (right &optional exclude-list)
  "DOCSTRING"
  (setq target-frame (weiss--find-frame right exclude-list))
  (weiss-update-top-windows t)
  (select-frame-set-input-focus target-frame)
  (weiss-update-top-windows t)
  )

(defun weiss-switch-to-right-frame () (interactive) (weiss--switch-to-right-or-left-frame t))
(defun weiss-switch-to-left-frame () (interactive) (weiss--switch-to-right-or-left-frame nil))


(defun weiss-update-otherside-top-window ()
  "DOCSTRING"
  (interactive)
  (let ((is-right (weiss-is-frame-in-right-pos))
        (target-frame))
    (setq target-frame (weiss--find-frame (not is-right)))    
    (if is-right
        (progn
          (if (weiss-is-frame-in-right-pos target-frame)
              (setq weiss-left-top-window nil)
            (setq weiss-left-top-window target-frame)  
            )
          )
      (if (weiss-is-frame-in-right-pos target-frame)
          (setq weiss-right-top-window target-frame)
        (setq weiss-right-top-window nil)  
        )            
      )
    ))

(defun weiss-update-top-windows (&optional shallow-update)
  "update the top window"
  (interactive)
  (let ((current-frame (selected-frame)))
    (if (weiss-is-frame-in-right-pos)
        (setq weiss-right-top-window current-frame)
      (setq weiss-left-top-window current-frame)      
      )
    (unless shallow-update (weiss-update-otherside-top-window))    
    ))

(defun weiss-switch-to-otherside-top-frame ()
  "DOCSTRING"
  (interactive)
  (let ((current-frame (selected-frame)))
    (cond
     ((and (not (weiss-is-frame-in-right-pos)) (eq current-frame weiss-left-top-window)) (unless (weiss--select-frame-with-check weiss-right-top-window) (weiss--select-frame-with-check weiss-right-top-window)))
     ((and (weiss-is-frame-in-right-pos) (eq current-frame weiss-right-top-window)) (unless (weiss--select-frame-with-check weiss-left-top-window) (weiss--select-frame-with-check weiss-left-top-window)))
     ((weiss-is-frame-in-right-pos)
      (weiss-update-top-windows)
      (weiss--select-frame-with-check weiss-left-top-window))
     (t
      (weiss-update-top-windows)
      (weiss--select-frame-with-check weiss-right-top-window))
     ) 
    )
  )

(defun weiss-switch-to-same-side-frame ()
  "DOCSTRING"
  (interactive)
  (let ((current-frame (selected-frame))) 
    (if (weiss-is-frame-in-right-pos)
        (weiss--switch-to-right-or-left-frame t (list current-frame))
      (weiss--switch-to-right-or-left-frame nil (list current-frame))    
      ))  
  )

(defun weiss-switch-buffer-or-otherside-frame-without-top ()
  "DOCSTRING"
  (interactive)
  (if (one-window-p)
      (progn
        (weiss-switch-to-otherside-top-frame)
        (weiss-switch-to-same-side-frame)  
        )
    (other-window 1)
    )
  )

(defun get-frame-name (&optional frame)
  "Return the string that names FRAME (a frame).  Default is selected frame."
  (unless frame (setq frame (selected-frame)))
  (if (framep frame)
      (cdr (assq 'name (frame-parameters frame)))
    (error "Function `get-frame-name': Argument not a frame: `%s'" frame)))

(defun get-a-frame (frame)
  "Return a frame, if any, named FRAME (a frame or a string).
  If none, return nil.
  If FRAME is a frame, it is returned."
  (cond ((framep frame) frame)
        ((stringp frame)
         (catch 'get-a-frame-found
           (dolist (fr (frame-list))
             (when (string= frame (get-frame-name fr))
               (throw 'get-a-frame-found fr)))
           nil))
        (t (error
            "Function `get-frame-name': Arg neither a string nor a frame: `%s'"
            frame))))

(provide 'weiss_buffer-frame-switching<wks)
