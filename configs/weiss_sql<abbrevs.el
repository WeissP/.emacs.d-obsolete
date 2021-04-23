(when (boundp 'sql-mode-abbrev-table)
  (clear-abbrev-table sql-mode-abbrev-table))

(define-abbrev-table 'sql-mode-abbrev-table
  '(
    ("all" "ALL" weiss--ahf)
    ("and" "AND ")
    ("as" "AS ")
    ("from" "FROM ")
    ("at" "ALTER TABLE ▮" weiss--ahf)
    ("av" "AVG(▮)" weiss--ahf)
    ("ct" "COUNT(*▮)" weiss--ahf)
    ("di" "DISTINCT")
    ("dt" "DROP TABLE ▮" weiss--ahf)
    ("ex" "EXISTS (\n▮\n)" weiss--ahf)
    ("gb" "GROUP BY ")
    ("ii" "INSERT INTO ▮" weiss--ahf)
    ("iiv" "INSERT INTO ▮() VALUES\n()" weiss--ahf)
    ("li" "LIMIT 10" weiss--ahf)
    ("ma" "MAX(▮)" weiss--ahf)
    ("mi" "MIN(▮)" weiss--ahf)
    ("nt" "CREATE TABLE ▮ \n(\n\n)" weiss--ahf)
    ("nv" "CREATE VIEW ▮ AS\n(\n\n)" weiss--ahf)
    ("nf" "CREATE OR REPLACE FUNCTION ▮ () RETURNS  AS $$\nDECLARE\nBEGIN\n\nRETURN;\nEND; $$ LANGUAGE plpgsql;\n" weiss--ahf)
    ("ntr" "CREATE TRIGGER ▮ \nBEFORE INSERT ON \nFOR EACH ROW \nEXECUTE PROCEDURE ;" weiss--ahf)
    ("ob" "ORDER BY ")
    ("ov" "OVER (▮) AS" weiss--ahf)
    ("pb" "PARTITION BY ")
    ("sf" "SELECT \nFROM ▮")
    ("sfw" "SELECT \nFROM ▮\nWHERE ")
    ("sl" "SELECT ")
    ("st" "SELECT * FROM ▮ LIMIT 10" weiss--ahf)
    ("un" "UNION ")
    ("ua" "UNION ALL ")
    ("wh" "WHERE ")
    ("rn" "RAISE NOTICE '▮'" weiss--ahf)
    ("lj" "INNER JOIN ")
    ("ljo" "INNER JOIN ▮ ON " weiss--ahf)
    ("llj" "LEFT OUTER JOIN ▮ ON " weiss--ahf)
    ("lrj" "RIGHT OUTER JOIN ▮ ON " weiss--ahf)
    ("sum" "SUM(▮)" weiss--ahf)
    ("max" "MAX(▮)" weiss--ahf)
    ("not" "NOT ")
    ("in" "IN ")    
    ("or" "OR ")
    ("jup" "UPDATE ▮ SET WHERE;" weiss--ahf)
    ("elsif" "ELSIF ▮ THEN" weiss--ahf)
    ("if" "IF ▮ THEN\n\nEND IF;" weiss--ahf)
    ("where" "WHERE ")
    ("with" "WITH ▮ AS (\n\n)" weiss--ahf)
    ("withr" "WITH RECURSIVE ▮ () \nAS (\n\nUnion ALL\n\n)" weiss--ahf)
    )
  )

(provide 'weiss_sql<abbrevs)
