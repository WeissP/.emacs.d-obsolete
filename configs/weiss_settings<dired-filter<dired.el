(with-eval-after-load 'dired-filter
  (dired-filter-define swag
      "swag"
    (:description "swag")
    (let ((case-fold-search t))
      (string-match-p "swag" file-name)))
  (dired-filter-define gruppensex
      "GruppenSex"
    (:description "GruppenSex")
    (let ((case-fold-search t))
      (string-match-p "GruppenSex" file-name)))
  (dired-filter-define cumshot
      "发射"
    (:description "发射")
    (let ((case-fold-search t))
      (or (string-match-p "发射" file-name)
          (string-match-p "cumshot" file-name))
      ))
  (dired-filter-define bdsm
      "bdsm"
    (:description "bdsm")
    (let ((case-fold-search t))
      (or
       (string-match-p "bdsm" file-name)
       (string-match-p "sm" file-name)
       (string-match-p "拘束" file-name)
       (string-match-p "凌辱" file-name)
       (string-match-p "调教" file-name)
       (string-match-p "捆绑" file-name)
       (string-match-p "紧缚" file-name))))
  (dired-filter-define uncensored
      "uncensored"
    (:description "uncensored")
    (let ((case-fold-search t))
      (or  (string-match-p "uncensored" file-name)
           (string-match-p "unsen" file-name)
           (string-match-p "无码" file-name)
           (string-match-p "carib" file-name)
           (string-match-p "swag" file-name)
           (string-match-p "fc2" file-name)
           (string-match-p "-ph" file-name)
           (not (string-match-p "[[:word:]]\\{2,5\\}-?[[:digit:]]\\{3,5\\}" file-name)))))
  (dired-filter-define stocking
      "stocking"
    (:description "stocking")
    (let ((case-fold-search t))
      (or  (string-match-p "连裤袜" file-name)
           (string-match-p "stocking" file-name)
           (string-match-p "恋腿癖" file-name))))
  (dired-filter-define positiv
      "positiv"
    (:description "positiv")
    (let ((case-fold-search t))
      (or  (string-match-p "主动" file-name)
           (string-match-p "positiv" file-name)
           (string-match-p "淫乱" file-name)
           (string-match-p "荡妇" file-name))))
  (dired-filter-define bigtits
      "bigtits"
    (:description "bigtits")
    (let ((case-fold-search t))
      (or  (string-match-p "巨乳" file-name)
           (string-match-p "乳交" file-name)
           (string-match-p "bigtits" file-name)
           (string-match-p "恋乳癖" file-name)
           (string-match-p "乳房" file-name))))
  (dired-filter-define prostitute
      "妓女"
    (:description "妓女")
    (let ((case-fold-search t))
      (or  (string-match-p "prostitute" file-name)
           (string-match-p "妓女" file-name))))
  (dired-filter-define blowjob
      "口交"
    (:description "口交")
    (let ((case-fold-search t))
      (or
       (string-match-p "blowjob" file-name)
       (string-match-p "口交" file-name)
       (string-match-p "深喉" file-name))))
  (dired-filter-define pov
      "pov"
    (:description "pov")
    (let ((case-fold-search t))
      (or
       (string-match-p "pov" file-name)
       (string-match-p "主观视角" file-name)
       (string-match-p "第一人称摄影" file-name))))
  (dired-filter-define grinding
      "grinding"
    (:description "grinding")
    (let ((case-fold-search t))
      (or  (string-match-p "女上位" file-name)
           (string-match-p "grinding" file-name)
           (string-match-p "颜面骑乘" file-name))))
  (dired-filter-define mature
      "mature"
    (:description "mature")
    (let ((case-fold-search t))
      (or  (string-match-p "成熟的女人" file-name)
           (string-match-p "mature" file-name)
           (string-match-p "已婚妇女" file-name))))
  (dired-filter-define wafuku
      "和服"
    (:description "wafuku")
    (let ((case-fold-search t))
      (or
       (string-match-p "wafuku" file-name)
       (string-match-p "和服" file-name))
      ))


  (dired-filter-define qiaoben
      "橋本ありな"
    (:description "橋本ありな")
    (let ((case-fold-search t))
      (string-match-p "橋本ありな" file-name)))
  (dired-filter-define lingcun
      "鈴村あいり"
    (:description "鈴村あいり")
    (let ((case-fold-search t))
      (string-match-p "鈴村あいり" file-name)))
  (dired-filter-define youban
      "有坂深雪"
    (:description "有坂深雪")
    (let ((case-fold-search t))
      (string-match-p "有坂深雪" file-name)))
  (dired-filter-define meizhu
      "美竹すず"
    (:description "美竹すず")
    (let ((case-fold-search t))
      (string-match-p "美竹すず" file-name)))
  (dired-filter-define yudugong
      "宇都宮しをん"
    (:description "宇都宮しをん")
    (let ((case-fold-search t))
      (string-match-p "宇都宮しをん" file-name)))
  (dired-filter-define xiangze
      "相沢みなみ"
    (:description "相沢みなみ")
    (let ((case-fold-search t))
      (string-match-p "相沢みなみ" file-name)))
  (dired-filter-define tianshi
      "天使もえ"
    (:description "天使もえ")
    (let ((case-fold-search t))
      (string-match-p "天使もえ" file-name)))
  (dired-filter-define bandao
      "坂道みる"
    (:description "坂道みる")
    (let ((case-fold-search t))
      (string-match-p "坂道みる" file-name)))
  (dired-filter-define mingli
      "明里つむぎ"
    (:description "明里つむぎ")
    (let ((case-fold-search t))
      (string-match-p "明里つむぎ" file-name)))
  (dired-filter-define sanshang
      "三上悠亜"
    (:description "三上悠亜")
    (let ((case-fold-search t))
      (string-match-p "三上悠亜" file-name)))
  (dired-filter-define xiqi
      "希崎ジェシカ"
    (:description "希崎ジェシカ")
    (let ((case-fold-search t))
      (string-match-p "希崎ジェシカ" file-name)))
  (dired-filter-define lingmu
      "鈴木心春"
    (:description "鈴木心春")
    (let ((case-fold-search t))
      (string-match-p "鈴木心春" file-name)))
  (dired-filter-define gaoqiao
      "高桥圣子"
    (:description "高桥圣子")
    (let ((case-fold-search t))
      (string-match-p "高桥圣子" file-name)))
  (dired-filter-define shanan
      "山岸逢花"
    (:description "山岸逢花")
    (let ((case-fold-search t))
      (string-match-p "山岸逢花" file-name)))

  (dired-filter-define jia
      "岬ななみ"
    (:description "岬ななみ")
    (let ((case-fold-search t))
      (string-match-p "岬ななみ" file-name)))
  (dired-filter-define xunguo
      "あやみ旬果"
    (:description "あやみ旬果")
    (let ((case-fold-search t))
      (string-match-p "あやみ旬果" file-name)))
  (dired-filter-define songyong
      "松永さな"
    (:description "松永さな")
    (let ((case-fold-search t))
      (string-match-p "松永さな" file-name)))
  (dired-filter-define zhuyin
      "朱音ゆい"
    (:description "朱音ゆい")
    (let ((case-fold-search t))
      (string-match-p "朱音ゆい" file-name)))
  (dired-filter-define yingkong
      "桜空もも"
    (:description "桜空もも")
    (let ((case-fold-search t))
      (string-match-p "桜空もも" file-name)))

  (dired-filter-define feng
      "楓カレン"
    (:description "楓カレン")
    (let ((case-fold-search t))
      (string-match-p "楓カレン" file-name)))

  (setq av-actress-list 
        '(
          ("あやみ旬果"    "xunguo")  
          ("鈴村あいり"    "lingcun")
          ("三上悠亜"      "sanshang")
          ("希崎ジェシカ"  "xiqi")  
          ("坂道みる"      "bandao")
          ("鈴木心春"      "lingmu")
          ("山岸逢花"      "shanan")
          ("相沢みなみ"    "xiangze")
          ("楓カレン"      "feng")
          ("明里つむぎ"    "mingli")
          ("松永さな"      "songyong")
          ("宇都宮しをん"  "yudugong")  
          ("高桥圣子"      "gaoqiao")
          ("美竹すず"      "meizhu")
          ("天使もえ"      "tianshi")
          ("有坂深雪"      "youban")
          ("岬ななみ"      "jia")
          ("橋本ありな"    "qiaoben")
          ("桜空もも"      "yingkong")
          ("朱音ゆい"      "zhuyin") 
          )
        )

  (defun weiss-filter-video-by-actress-at-point ()
    "weiss filter video by actress at point"
    (interactive)
    (let ((actress-name (replace-regexp-in-string "^【\\(.*\\)】.*$" "\\1" (file-name-nondirectory (dired-file-name-at-point)))))
      (setq actress-name-at-point (if (string-match-p "、" actress-name)
                                      (let ((actress-name-at-point-list (split-string actress-name "、"))
                                            (ra "") ; otherwise would prompt display "nil 1. ..."
                                            (rb "")
                                            )
                                        (nth (- (string-to-number (read-char-picky 
                                                                   (dotimes (i (length actress-name-at-point-list) ra) (setq ra (format "%s %s:%s" ra (1+ i) (nth i actress-name-at-point-list))))
                                                                   (dotimes (i (length actress-name-at-point-list) rb) (setq rb (format "%s%s" rb (1+ i))))
                                                                   ))
                                                1) actress-name-at-point-list)
                                        )
                                    actress-name
                                    ))
      (dired-filter-define actress-name-at-point
          "actress-name-at-point"
        (:description actress-name-at-point)
        (let ((case-fold-search t))
          (string-match-p actress-name-at-point file-name)))        
      (dired-filter-by-actress-name-at-point)))
  )

(provide 'weiss_settings<dired-filter<dired)
