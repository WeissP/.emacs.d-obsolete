  (advice-add 'xah-open-file-at-cursor
              :before
              '(lambda () (interactive)
                 (ignore-errors
                   (when (or (weiss-org-sp--at-property-p)
                             (looking-at weiss-org-sp-sharp-begin))
                     (re-search-forward ":tangle " (line-end-position) t)
                     ))
                 ))

(provide 'weiss_addvices<weiss-org-sp-mode<org)
