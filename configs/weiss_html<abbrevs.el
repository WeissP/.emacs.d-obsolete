(setq weiss-html-mode-abbrev-table
      '(
        ("b" "<b> ▮ </b>")
        ("i" "<i> ▮ </i>")
        ("p" "<p> ▮ </p>")
        ("a" "<a href=\"▮\"> </a>" weiss--ahf)

        ("h1" "<h1> ▮ </h1>")
        ("h2" "<h2> ▮ </h2>")
        ("h3" "<h3> ▮ </h3>")
        ("h4" "<h4> ▮ </h4>")
        ("li" "<li> ▮ </li>")
        ("ol" "<ol start=1 type=a> \n▮ \n </ol>" weiss--ahf-indent)
        ("ul" "<ul> \n▮ \n </ul>" weiss--ahf-indent)
        ("hd" "<head>\n<meta charset=\"utf-8\">\n<title>▮</title>\n</head>" weiss--ahf-indent)
        ("th" "<th>▮</th>" weiss--ahf)
        ("br" "<br>" weiss--ahf)
        ("tr" "<tr>\n▮\n</tr>" weiss--ahf-indent)
        ("td" "<td>▮</td>" weiss--ahf)
        ("sp" "<span>▮</span>" weiss--ahf)
        ("sb" "<span class=\"block\">▮</span>" weiss--ahf)    
        ("ag" "Aufgabe" weiss--ahf)

        ("el" "&lt;" weiss--ahf)
        ("eg" "&gt;" weiss--ahf)
        ("elg" "&lt;▮&gt;" weiss--ahf)
        ("ea" "&amp" weiss--ahf)
        ("eq" "&quot;" weiss--ahf)

        ("pre" "<pre>\n▮\n</pre>" weiss--ahf-indent)    
        ("php" "<?php\n▮\n?>" weiss--ahf)
        ("div" "<div> ▮ </div>")

        ("code" "<pre>\n<code>\n▮\n</code>\n</pre>" weiss--ahf-indent)
        ("style" "<style>\n▮\n</style>" weiss--ahf-indent)
        ("temp" "<!doctype html>\n<html lang=\"de\">\n\n<head>\n<meta charset=\"utf-8\">\n<title>▮</title>\n</head>\n\n<body>\n\n</body>" weiss--ahf-indent)

        ))

(when (boundp 'html-mode-abbrev-table)
  (clear-abbrev-table html-mode-abbrev-table))

(define-abbrev-table 'html-mode-abbrev-table weiss-html-mode-abbrev-table)

(provide 'weiss_html<abbrevs)
