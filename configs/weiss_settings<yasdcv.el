(with-eval-after-load 'yasdcv
  (setq yasdcv-sdcv-dicts
        '(
          ("Duden" "Duden" "duden" t)
          ("PONS Universelles Wörterbuch Englisch-Deutsch" "PONS Universelles Wörterbuch Englisch-Deutsch" "PONS-eng-de" t)
          ("PONS Universelles Wörterbuch Deutsch-Englisch" "PONS Universelles Wörterbuch Deutsch-Englisch" "PONS-de-eng" t)
          ;; ("朗氏简明德英英德词典" "朗氏简明德英英德词典" nil t)
          ("新德汉词典" "新德汉词典" "xindehan" t)
          ("牛津现代英汉双解词典" "牛津现代英汉双解词典" nil t)
          ;; ("niujing"    "牛津高阶英汉双解"  "oald" t)
          ;; ("21shiji"    "21世纪英汉汉英双向词典" "21cen" t)
          ;; ("21shjikj"   "21世纪双语科技词典"  nil t)
          )
        )
  (setq yasdcv-wiktionary-lang '("de" "en"))
  )

(provide 'weiss_settings<yasdcv)
