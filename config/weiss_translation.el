(use-package youdao-dictionary
  :disabled
  :config
  ;; Enable Cache
  (setq url-automatic-caching t)
  )

(use-package chinese-yasdcv
  :config
  (setq yasdcv-sdcv-dicts
        '(
        ("Duden" "Duden" nil t)
        ("新德汉词典" "新德汉词典" nil t)
        ("牛津现代英汉双解词典" "牛津现代英汉双解词典" nil t)
         )
        )
  )

(provide 'weiss_translation)
