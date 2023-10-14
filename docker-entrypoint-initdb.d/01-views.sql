CREATE VIEW word
AS
SELECT W.id, W.text
FROM word_data W;

CREATE VIEW phrase
AS
SELECT H.id AS id, string_agg(W.text, ' ' ORDER BY W.id) AS text
FROM phrase_data H
         JOIN word_data W ON H.id = W.phrase_id
GROUP BY H.id;

CREATE VIEW sentence
AS
SELECT S.id AS id, string_agg(HH.text, ', ' ORDER BY HH.id) AS text
FROM sentence_data S
         JOIN phrase_data H ON S.id = H.sentence_id
         JOIN phrase HH ON H.id = HH.id
GROUP BY S.id;

CREATE VIEW paragraph
AS
SELECT P.id AS id, string_agg(SS.text, '. ' ORDER BY SS.id) AS text
FROM paragraph_data P
         JOIN sentence_data S ON P.id = S.paragraph_id
         JOIN sentence SS ON S.id = SS.id
GROUP BY P.id;

CREATE VIEW quotation_expanded
AS
SELECT Q.key         AS KEY,
       Q.value       AS VALUE,
       COALESCE(
           CASE WHEN Q.paragraph_id IS NOT NULL THEN 'PARAGRAPH' ELSE NULL END,
           CASE WHEN Q.sentence_id IS NOT NULL THEN 'SENTENCE' ELSE NULL END,
           CASE WHEN Q.phrase_id IS NOT NULL THEN 'PHRASE' ELSE NULL END,
           CASE WHEN Q.word_id IS NOT NULL THEN 'WORD' ELSE NULL END
       )             AS TEXT_TYPE,
       COALESCE(
           Q.paragraph_id,
           Q.sentence_id,
           Q.phrase_id,
           Q.word_id
       )             AS TEXT_ID,
       P.indentation AS INDENTATION,
       S.clauses     AS CLAUSES,
       H.adverbs     AS ADVERBS,
       W.length      AS LENGTH
FROM quotation_p Q
         LEFT JOIN paragraph_data P ON P.id = Q.paragraph_id
         LEFT JOIN sentence_data S ON S.id = Q.sentence_id
         LEFT JOIN phrase_data H ON H.id = Q.phrase_id
         LEFT JOIN word_data W ON W.id = Q.word_id
-- One way to performantly ensure read-only without using roles
UNION ALL
SELECT '0', 0, '0', 0, 0, 0, 0, 0
WHERE 1 = 0;

CREATE VIEW quotation
AS
SELECT KEY, VALUE, TEXT_TYPE, TEXT_ID
FROM quotation_expanded;
