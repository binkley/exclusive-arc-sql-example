INSERT INTO paragraph (id, indentation)
VALUES (99, 3);

INSERT INTO sentence (id, clauses)
VALUES (12, 1);

INSERT INTO word (id, length)
VALUES (1, 42);

INSERT INTO quotation_p (key, value, paragraph_id, sentence_id, word_id)
VALUES ('abc', 1, 99, NULL, NULL);
INSERT INTO quotation_p (key, value, paragraph_id, sentence_id, word_id)
VALUES ('def', 2, NULL, 12, NULL);
INSERT INTO quotation_p (key, value, paragraph_id, sentence_id, word_id)
VALUES ('ghi', 3, NULL, NULL, 1);
