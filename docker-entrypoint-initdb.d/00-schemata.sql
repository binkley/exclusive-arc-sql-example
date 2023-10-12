CREATE TABLE paragraph
(
    id          INTEGER NOT NULL,
    indentation INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE sentence
(
    id      INTEGER NOT NULL,
    clauses INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE phrase
(
    id      INTEGER NOT NULL,
    adverbs INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE word
(
    id     INTEGER NOT NULL,
    length INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE quotation_p
(
    key          TEXT    NOT NULL,
    value        INTEGER NOT NULL,
    paragraph_id INT     NULL,
    sentence_id  INT     NULL,
    phrase_id    INT     NULL,
    word_id      INT     NULL,
    CONSTRAINT pk_example_p PRIMARY KEY (key),
    CONSTRAINT fk_paragraph FOREIGN KEY (paragraph_id) REFERENCES paragraph (id),
    CONSTRAINT fk_sentence FOREIGN KEY (sentence_id) REFERENCES sentence (id),
    CONSTRAINT fk_phrase FOREIGN KEY (phrase_id) REFERENCES phrase (id),
    CONSTRAINT fk_word FOREIGN KEY (word_id) REFERENCES word (id),
    CONSTRAINT ct_exclusive_arc CHECK (
                CASE WHEN paragraph_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN sentence_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN phrase_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN word_id IS NOT NULL THEN 1 ELSE 0 END
            = 1
        )
);
