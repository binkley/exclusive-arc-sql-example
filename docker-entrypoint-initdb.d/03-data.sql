INSERT INTO paragraph_data (id, indentation)
VALUES (9000, 3);

INSERT INTO sentence_data (id, paragraph_id, clauses)
VALUES (800, 9000, 1);
INSERT INTO sentence_data (id, paragraph_id, clauses)
VALUES (900, 9000, 1);

INSERT INTO phrase_data (id, sentence_id, adverbs)
VALUES (60, 800, 2);
INSERT INTO phrase_data (id, sentence_id, adverbs)
VALUES (70, 800, 2);
INSERT INTO phrase_data (id, sentence_id, adverbs)
VALUES (80, 900, 2);
INSERT INTO phrase_data (id, sentence_id, adverbs)
VALUES (90, 900, 2);

INSERT INTO word_data (id, phrase_id, text, length)
VALUES (1, 60, 'apple', 42);
INSERT INTO word_data (id, phrase_id, text, length)
VALUES (2, 60, 'pie', 42);
INSERT INTO word_data (id, phrase_id, text, length)
VALUES (3, 70, 'banana', 42);
INSERT INTO word_data (id, phrase_id, text, length)
VALUES (4, 70, 'split', 42);
INSERT INTO word_data (id, phrase_id, text, length)
VALUES (5, 80, 'carrot', 42);
INSERT INTO word_data (id, phrase_id, text, length)
VALUES (6, 80, 'cake', 42);
INSERT INTO word_data (id, phrase_id, text, length)
VALUES (7, 90, 'date', 42);
INSERT INTO word_data (id, phrase_id, text, length)
VALUES (8, 90, 'roll', 42);

INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('abc', 1, 9000, NULL, NULL, NULL);
INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('def', 2, NULL, 900, NULL, NULL);
INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('ghi', 3, NULL, NULL, 90, NULL);
INSERT INTO quotation_p
(key, value, paragraph_id, sentence_id, phrase_id, word_id)
VALUES ('jkl', 3, NULL, NULL, NULL, 4);
