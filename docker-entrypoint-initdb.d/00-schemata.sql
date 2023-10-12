CREATE TABLE paragraph_data
(
    id          INTEGER NOT NULL,
    indentation INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE sentence_data
(
    id                INTEGER NOT NULL,
    paragraph_id INTEGER NOT NULL,
    clauses           INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (paragraph_id) REFERENCES paragraph_data (id)
);

CREATE TABLE phrase_data
(
    id               INTEGER NOT NULL,
    sentence_id INTEGER NOT NULL,
    adverbs          INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (sentence_id) REFERENCES sentence_data (id)
);

CREATE TABLE word_data
(
    id             INTEGER NOT NULL,
    phrase_id INTEGER NOT NULL,
    text           TEXT    NOT NULL,
    length         INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (phrase_id) REFERENCES phrase_data (id)
);

CREATE TABLE quotation_p
(
    key               TEXT    NOT NULL,
    value             INTEGER NOT NULL,
    paragraph_id INT     NULL,
    sentence_id  INT     NULL,
    phrase_id    INT     NULL,
    word_id      INT     NULL,
    CONSTRAINT pk_example_p PRIMARY KEY (key),
    CONSTRAINT fk_paragraph FOREIGN KEY (paragraph_id) REFERENCES paragraph_data (id),
    CONSTRAINT fk_sentence FOREIGN KEY (sentence_id) REFERENCES sentence_data (id),
    CONSTRAINT fk_phrase FOREIGN KEY (phrase_id) REFERENCES phrase_data (id),
    CONSTRAINT fk_word FOREIGN KEY (word_id) REFERENCES word_data (id),
    CONSTRAINT ct_exclusive_arc CHECK (
                CASE WHEN paragraph_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN sentence_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN phrase_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN word_id IS NOT NULL THEN 1 ELSE 0 END
            = 1
        )
);
