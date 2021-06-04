(defun weiss-dired-delete-tag ()
  "weiss filter video by actress at point"
  (interactive)
  (let ((tags (split-string (replace-regexp-in-string "^.*】\\(.*\\) .*$" "\\1" (file-name-nondirectory (dired-file-name-at-point))) "|"))
        (cnt 0)
        (prompt "")
        (file (dired-file-name-at-point))
        tag-at-point 
        )
    (setq tag-at-point
          (nth
           (- (string-to-number
               (read-char-picky 
                ;; "dsfsd"
                (dolist (x tags prompt) 
                  (setq cnt (1+ cnt))
                  (setq prompt (format "%s %s:%s" prompt cnt x))
                  )
                (mapconcat 'number-to-string (number-sequence 1 (length tags)) "")
                ))
              1)
           tags))
    (when (y-or-n-p (format "remove tag: %s?" tag-at-point))
      (rename-file
       file
       (replace-regexp-in-string "| *|" " " (replace-regexp-in-string tag-at-point "" file))
       )
      )
    (revert-buffer)
    ))


(defmacro weiss-dired-new-modify-tags (name)
  (let ((fun (intern (concat "weiss-dired-add-tag-" name)))
        )
    `(defun ,fun ()
       (interactive)
       (let ((file  (dired-file-name-at-point))
             )
         (rename-file file
                      (format "%s|%s.%s"
                              (file-name-sans-extension file)
                              ,name
                              (file-name-extension file)))
         (revert-buffer)
         )
       (revert-buffer)
       (message "added new Tag: %s" ,name)
       )    
    )  
  )

(dolist (x '("bdsm" "blowjob" "bigtits" "cumshot" "gruppensex" "mature" "positiv" "prostitute" "grinding" "pov" "stocking" "swag" "uncensored" "wafuku" "asmr")) 
  (eval `(weiss-dired-new-modify-tags ,x))
  )


(with-eval-after-load 'dired-filter
  (defhydra hydra-dired-filter-actress (:hint none :color pink)
    "
^a-j^                  ^l-q^                  ^s-t^                     ^x-z
^^^^^^^^^-----------------------------------------------------------------------------------------------
_a_: ?q? あやみ旬果    _c_: ?q? 鈴村あいり     _e_: ?q? 三上悠亜     _X_: ?q? 希崎ジェシカ
_b_: ?q? 坂道みる      _w_: ?q? 鈴木心春      _s_: ?q? 山岸逢花      _x_: ?q? 相沢みなみ
_f_: ?q? 楓カレン      _d_: ?q? 明里つむぎ     _S_: ?q? 松永さな      _v_: ?q? 宇都宮しをん
_g_: ?q? 高桥圣子      _D_: ?q? 美竹すず      _t_: ?q? 天使もえ    _F_: ?q? 有坂深雪
_G_: ?q? 岬ななみ      _q_: ?q? 橋本ありな      ^           ^  _r_: ?q? 桜空もも
_v_: ?v? at point    ^                 ^    ^           ^ _z_: ?q? 朱音ゆい 
"
    ("!" dired-filter-negate "negate"  :column "general")
    ("@" dired-filter-or "or")
    ("S-<dead-grave>" dired-filter-pop-all "pop-all")
    ("=" dired-filter-pop "pop")
    ("/" dired-filter-by-name "name")
    ("b" dired-filter-by-bandao "" :column "a-j")
    ("f" dired-filter-by-feng "")
    ("g" dired-filter-by-gaoqiao "")
    ("G" dired-filter-by-jia "")
    ("c" dired-filter-by-lingcun ""  :column "l-q")
    ("w" dired-filter-by-lingmu "")
    ("D" dired-filter-by-meizhu "")
    ("d" dired-filter-by-mingli "")
    ("q" dired-filter-by-qiaoben "")
    ("e" dired-filter-by-sanshang ""  :column "s-t")
    ("s" dired-filter-by-shanan "")
    ("S" dired-filter-by-songyong "")
    ("t" dired-filter-by-tianshi "")
    ("x" dired-filter-by-xiangze ""  :column "x-z")
    ("X" dired-filter-by-xiqi "")
    ("a" dired-filter-by-xunguo "")
    ("r" dired-filter-by-yingkong "")
    ("F" dired-filter-by-youban "")
    ("v" dired-filter-by-yudugong "")
    ("z" dired-filter-by-zhuyin "")
    ("V" weiss-filter-video-by-actress-at-point "")
    ("C-g" nil)
    ("<escape>" nil))

  (defhydra hydra-dired-filter-tag (:hint nil :color pink)

    ("!" dired-filter-negate "negate"  :column "general")
    ("@" dired-filter-or "or")
    ("S-<dead-grave>" dired-filter-pop-all "pop-all")
    ("=" dired-filter-pop "pop")
    ("/" dired-filter-by-name "name")
    ("a" dired-filter-by-bdsm       "bdsm" :column "a-z")
    ("b" dired-filter-by-blowjob    "blowjob")
    ("B" dired-filter-by-bigtits    "bigtits")
    ("c" dired-filter-by-cumshot    "cumshot")
    ("g" dired-filter-by-gruppensex "gruppensex")
    ("C" dired-filter-by-mature     "mature" :column "g-h")
    ("f" dired-filter-by-positiv    "positiv")
    ("F" dired-filter-by-prostitute "prostitute")
    ("G" dired-filter-by-grinding   "grinding")
    ("v" dired-filter-by-pov        "pov")
    ("s" dired-filter-by-stocking   "stocking" :column "s-w")
    ("S" dired-filter-by-swag       "swag")
    ("w" dired-filter-by-uncensored "uncensored")
    ("W" dired-filter-by-wafuku     "wafuku")
    ("C-g" nil "quit" :column nil)
    ("<escape>" nil "quit" :column nil))

  (defhydra hydra-dired-add-tag (:hint nil :color pink)

    ("a" weiss-dired-add-tag-asmr       "asmr" :column "a-z")
    ("A" weiss-dired-add-tag-bdsm       "bdsm")
    ("b" weiss-dired-add-tag-blowjob    "blowjob")
    ("B" weiss-dired-add-tag-bigtits    "bigtits")
    ("c" weiss-dired-add-tag-cumshot    "cumshot")
    ("g" weiss-dired-add-tag-gruppensex "gruppensex")
    ("C" weiss-dired-add-tag-mature     "mature" :column "g-h")
    ("f" weiss-dired-add-tag-positiv    "positiv")
    ("F" weiss-dired-add-tag-prostitute "prostitute")
    ("G" weiss-dired-add-tag-grinding   "grinding")
    ("v" weiss-dired-add-tag-pov        "pov")
    ("s" weiss-dired-add-tag-stocking   "stocking" :column "s-w")
    ("S" weiss-dired-add-tag-swag       "swag")
    ("w" weiss-dired-add-tag-uncensored "uncensored")
    ("W" weiss-dired-add-tag-wafuku     "wafuku")
    ("=" weiss-dired-delete-tag "delete tag" :column nil)
    ("C-g" nil "quit" :column nil)
    ("<escape>" nil "quit" :column nil))
  )

(provide 'weiss_hydra<dired-filter<dired)

