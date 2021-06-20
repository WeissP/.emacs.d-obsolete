(when (boundp 'java-mode-abbrev-table)
  (clear-abbrev-table java-mode-abbrev-table))

(define-abbrev-table 'java-mode-abbrev-table
  '(
    ("rt" "return ▮;" weiss--ahf)
    ("pr" "System.out.println(▮);" weiss--ahf)
    ("sf" "String.format(\"%s\", ▮)" weiss--ahf)
    ("fa" "for (▮:)  {\n\n}" weiss--ahf-indent)
    ("for" "for (int i = 0; i < ▮; i++) {\n\n}" weiss--ahf-indent)
    ("forj" "for (int j = 0; j < ▮; j++) {\n\n}" weiss--ahf-indent)
    ("if" "if (▮) {\n\n}" weiss--ahf-indent)
    ("try" "try {\n▮\n} catch () {\n\n}" weiss--ahf-indent)
    ("else" "else {\n▮\n}" weiss--ahf-indent)
    ("pb" "public " weiss--ahf)
    ("pri" "private " weiss--ahf)
    ("wh" "while (▮) {\n\n}" weiss--ahf-indent)
;;;;; for clp
    ("tv" "TemporaryVar ▮ = TemporaryVar(\"\");" weiss--ahf)
    ("ai" "addInstruction(▮)" weiss--ahf)
    ("vr" "VarRef(▮)" weiss--ahf)
    ("ci" "ConstInt(▮)" weiss--ahf)
    ("pt" "System.out.println(String.format(\"//// ▮: %s\", ));" weiss--ahf)
    ))

(provide 'weiss_java<abbrevs)
