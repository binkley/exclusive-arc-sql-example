INSERT INTO paragraph (id, indentation)
VALUES (1, 3);

INSERT INTO sentence (id, clauses)
VALUES (1, 1);

INSERT INTO word (id, length)
VALUES (1, 42);

INSERT INTO quotation_p (key, value, paragraph_id, sentence_id, word_id)
VALUES ('abc', 1, 1, NULL, NULL);
INSERT INTO quotation_p (key, value, paragraph_id, sentence_id, word_id)
VALUES ('def', 2, NULL, 1, NULL);
INSERT INTO quotation_p (key, value, paragraph_id, sentence_id, word_id)
VALUES ('ghi', 3, NULL, NULL, 1);
