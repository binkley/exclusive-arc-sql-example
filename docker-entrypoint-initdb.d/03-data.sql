INSERT INTO paragraph_data (id, indentation)
VALUES (99, 3);

INSERT INTO sentence_data (id, paragraph_id, clauses)
VALUES (12, 99, 1);

INSERT INTO phrase_data (id, sentence_id, adverbs)
VALUES (7, 12, 2);

INSERT INTO word_data (id, phrase_id, text, length)
VALUES (1, 7, 'apple', 42);

INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('abc', 1, 99, NULL, NULL, NULL);
INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('def', 2, NULL, 12, NULL, NULL);
INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('ghi', 3, NULL, NULL, 7, NULL);
INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('jkl', 3, NULL, NULL, NULL, 1);
