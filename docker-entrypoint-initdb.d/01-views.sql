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
FROM quotation_p;
