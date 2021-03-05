(when (boundp 'telega-chat-mode-abbrev-table)
  (clear-abbrev-table telega-chat-mode-abbrev-table))

(define-abbrev-table 'telega-chat-mode-abbrev-table
  '(
    ("zj" ":joy:")
    ("algo" "Algorithmus" weiss--ahf)
    ("zad" "außerdem" weiss--ahf)
    ("zag" "Aufgabe" weiss--ahf)
    ("zas" "Ausgabe" weiss--ahf)
    ("zbh" "Behauptung" weiss--ahf)
    ("zbdi" "Beweis durch Induktion" weiss--ahf)
    ("zbj" "bis jetzt")
    ("zbp" "Beispiel" weiss--ahf)
    ("zdef" "Definition" weiss--ahf)
    ("zdw" "deswegen")
    ("zeb" "ein bisschen")
    ("zef" "einfach" weiss--ahf)
    ("zen" "entweder")
    ("zfm" "Familie" weiss--ahf)
    ("zft" "fertig" weiss--ahf)
    ("zfun" "Funktion" weiss--ahf)
    ("zgb" "Gegenbeispiel" weiss--ahf)
    ("zgz" "gleichzeitig" weiss--ahf)
    ("zhs" "höchstens")
    ("zig" "insgesamt")
    ("zin" "Information" weiss--ahf)
    ("zit" "Interesse" weiss--ahf)
    ("zer" "erfüllt" weiss--ahf)
    ("zka" "keine Ahnung")
    ("zkf" "kontextfrei" weiss--ahf)
    ("zls" "Lösung" weiss--ahf)
    ("zma" "Material" weiss--ahf)
    ("zmg" "Möglichkeit" weiss--ahf)
    ("zmi" "zumindest" weiss--ahf)
    ("zn" "nicht")
    ("znl" "natürlich" weiss--ahf)
    ("znm" "nochmal")
    ("znot" "Notation" weiss--ahf)
    ("znx" "nächst" weiss--ahf)
    ("zpb" "Problem" weiss--ahf)
    ("zpg" "Programmier" weiss--ahf)
    ("zpj" "Project" weiss--ahf)
    ("zrt" "Richtung" weiss--ahf)
    ("zsl" "schlecht")
    ("zse" "Semester")
    ("zst" "Schritt" weiss--ahf)
    ("zub" "Übung" weiss--ahf)
    ("zul" "unterschiedlich" weiss--ahf)
    ("zus" "Unterschied" weiss--ahf)
    ("zvl" "Vorlesung" weiss--ahf)
    ("zwr" "während" weiss--ahf)
    ("zzm" "zusammen" weiss--ahf)
    ("zzf" "Zusammenfassung" weiss--ahf)
    )
  )

(provide 'weiss_telega<abbrevs)