(with-eval-after-load 'weiss_after-dump-misc
  (defun font-installed-p (font-name)
    "Check if font with FONT-NAME is available."
    (find-font (font-spec :name font-name)))

  (when (display-graphic-p)
    ;; Set default font
    (cl-loop for font in '("JetBrainsMono" "Fira Code" "DejaVu Sans Mono" "M+1m" "SF Mono" "iosevka" "Hack" "Source Code Pro" 
                           "Menlo" "Monaco" "Consolas")
             when (font-installed-p font)
             return (set-face-attribute 'default nil
                                        :font font
                                        :height 110))

    ;; Specify font for all unicode characters
    (cl-loop for font in '("Symbola" "Apple Symbols" "Symbol" "icons-in-terminal")
             when (font-installed-p font)
             return (set-fontset-font t 'unicode font nil 'prepend))

    ;; Specify font for Chinese characters
    (cl-loop for font in '("FZPingXianYaSongS-R-GB" "WenQuanYi Micro Hei" "Microsoft Yahei" "LXGW WenKai")
             when (font-installed-p font)
             return (set-fontset-font t '(#x4e00 . #x9fff) font)))

  ;; (setq face-font-rescale-alist '(("LXGW WenKai" . 1.2) ("WenQuanYi Zen Hei" . 1.2)))  
)

(provide 'weiss_font<ui)
