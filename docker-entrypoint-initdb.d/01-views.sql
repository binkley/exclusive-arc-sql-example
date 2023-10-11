CREATE VIEW quotation_expanded
AS
SELECT Q.key           AS KEY,
       Q.value         AS VALUE,
       COALESCE(
           CASE WHEN Q.paragraph_id IS NOT NULL THEN 'PARAGRAPH' ELSE NULL END,
           CASE WHEN Q.sentence_id IS NOT NULL THEN 'SENTENCE' ELSE NULL END,
           CASE WHEN Q.word_id IS NOT NULL THEN 'WORD' ELSE NULL END
       )             AS TEXT_TYPE,
       COALESCE(Q.paragraph_id, Q.sentence_id, Q.word_id) AS TEXT_ID,
       P.indentation AS INDENTATION,
       S.clauses     AS CLAUSES,
       W.length      AS LENGTH
FROM quotation_p Q
LEFT JOIN paragraph P ON P.id = Q.paragraph_id
LEFT JOIN sentence S ON S.id = Q.sentence_id
LEFT JOIN word W ON W.id = Q.word_id
-- One way to performantly ensure read-only without using roles
UNION ALL SELECT '0', 0, '0', 0, 0, 0, 0 WHERE 1 = 0;

CREATE VIEW quotation
AS
SELECT KEY, VALUE, TEXT_TYPE, TEXT_ID
FROM quotation_expanded;
