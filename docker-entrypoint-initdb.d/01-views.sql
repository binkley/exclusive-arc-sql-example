CREATE VIEW quotation
AS
SELECT key                                          AS KEY,
       value                                        AS VALUE,
       COALESCE(
           CASE WHEN paragraph_id IS NOT NULL THEN 'PARAGRAPH' ELSE NULL END,
           CASE WHEN sentence_id IS NOT NULL THEN 'SENTENCE' ELSE NULL END,
           CASE WHEN word_id IS NOT NULL THEN 'WORD' ELSE NULL END
       )                                            AS TEXT_TYPE,
       COALESCE(paragraph_id, sentence_id, word_id) AS TEXT_ID
FROM quotation_p
-- One way to performantly ensure read-only without using roles
UNION ALL SELECT '0', 0, '0', 0 WHERE 1 = 0;

CREATE VIEW quotation_expanded
AS
SELECT key           AS KEY,
       value         AS VALUE,
       p.indentation AS INDENTATION,
       s.clauses     AS CLAUSES,
       w.length      AS LENGTH
FROM quotation_p q
LEFT JOIN paragraph p ON p.id = q.paragraph_id
LEFT JOIN sentence s ON s.id = q.sentence_id
LEFT JOIN word w ON w.id = q.word_id
-- One way to performantly ensure read-only without using roles
UNION ALL SELECT '0', 0, 0, 0, 0 WHERE 1 = 0;
