(with-eval-after-load 'dired-filter
  (defhydra hydra-dired-filter-actress (:hint none :color pink)
    "
^a-j^                  ^l-q^                  ^s-t^                     ^x-z
^^^^^^^^^-----------------------------------------------------------------------------------------------
_a_: ?q? あやみ旬果    _c_: ?q? 鈴村あいり     _e_: ?q? 三上悠亜      _i_: ?q? 希崎ジェシカ
_b_: ?q? 坂道みる      _l_: ?q? 鈴木心春      _s_: ?q? 山岸逢花      _x_: ?q? 相沢みなみ
_f_: ?q? 楓カレン      _d_: ?q? 明里つむぎ    _h_: ?q? 松永さな      _k_: ?q? 宇都宮しをん
_g_: ?q? 高桥圣子      _m_: ?q? 美竹すず       _t_: ?q? 天使もえ     _y_: ?q? 有坂深雪
_j_: ?q? 岬ななみ      _q_: ?q? 橋本ありな      ^           ^        _o_: ?q? 桜空もも
_n_: ?n? at point    ^                 ^    ^           ^         _z_: ?q? 朱音ゆい 
"
    ("." dired-filter-by-dot-files "")
    ("1" dired-filter-negate "")
    ("2" dired-filter-or "")
    ("3" dired-filter-pop-all "")
    ("4" dired-filter-pop "")
    ("5" dired-filter-by-name "")
    ("a" dired-filter-by-xunguo "")
    ("b" dired-filter-by-bandao "")
    ("c" dired-filter-by-lingcun "")
    ("d" dired-filter-by-mingli "")
    ("e" dired-filter-by-sanshang "")
    ("f" dired-filter-by-feng "")
    ("g" dired-filter-by-gaoqiao "")
    ("h" dired-filter-by-songyong "")
    ("i" dired-filter-by-xiqi "")
    ("j" dired-filter-by-jia "")
    ("k" dired-filter-by-yudugong "")
    ("l" dired-filter-by-lingmu "")
    ("m" dired-filter-by-meizhu "")
    ("n" weiss-filter-video-by-actress-at-point "")
    ("o" dired-filter-by-yingkong "")
    ;; ("p" dired-filter-by-zhuyin "")
    ("q" dired-filter-by-qiaoben "")
    ;; ("r" dired-filter-by-zhuyin "")
    ("s" dired-filter-by-shanan "")
    ("t" dired-filter-by-tianshi "")
    ;; ("u" dired-filter-by- "")
    ;; ("v" dired-filter-by- "")
    ;; ("w" dired-filter-by- "")
    ("x" dired-filter-by-xiangze "")
    ("y" dired-filter-by-youban "")
    ("z" dired-filter-by-zhuyin "")
    ("C-g" nil)
    ("<escape>" nil))

  (defhydra hydra-dired-filter-tag (:hint none :color pink)
    "
^a-g^                  ^g-h^                  ^s-w^       
^^^^^^^^^-----------------------------------------------------------------------------------------------
_a_: ?q? bdsm         _e_: ?q? grinding     _s_: ?q? stocking       
_b_: ?q? blowjob      _m_: ?q? mature       _i_: ?q? swag              
_c_: ?q? cumshot      _f_: ?q? positiv      _u_: ?q? uncensored        
_d_: ?q? bigtits      _p_: ?q? pov          _w_: ?q? wafuku            
_g_: ?q? GruppenSex   _h_: ?q? prostitute         
"
    ("." dired-filter-by-dot-files "")
    ("1" dired-filter-negate "")
    ("2" dired-filter-or "")
    ("3" dired-filter-pop-all "")
    ("4" dired-filter-pop "")
    ("5" dired-filter-by-name "")
    ("a" dired-filter-by-bdsm       "")
    ("b" dired-filter-by-blowjob    "")
    ("c" dired-filter-by-cumshot    "")
    ("d" dired-filter-by-bigtits    "")
    ("e" dired-filter-by-grinding   "")
    ("f" dired-filter-by-positiv    "")
    ("g" dired-filter-by-gruppensex "")
    ("h" dired-filter-by-prostitute "")
    ("i" dired-filter-by-swag       "")
    ;; ("j" dired-filter-by- "")
    ("k" dired-filter-by- "")
    ("m" dired-filter-by-mature     "")
    ;; ("n" dired-filter-by- "")
    ;; ("o" dired-filter-by- "")
    ("p" dired-filter-by-pov        "")
    ("q" dired-filter-by- "")
    ("r" dired-filter-by- "")
    ("s" dired-filter-by-stocking   "")
    ("t" dired-filter-by- "")
    ("u" dired-filter-by-uncensored "")
    ("v" dired-filter-by- "")
    ("w" dired-filter-by-wafuku     "")
    ("x" dired-filter-by- "")
    ("y" dired-filter-by- "")
    ("z" dired-filter-by- "")
    ("C-g" nil)
    ("<escape>" nil))
  )

(provide 'weiss_hydra<dired-filter<dired)
