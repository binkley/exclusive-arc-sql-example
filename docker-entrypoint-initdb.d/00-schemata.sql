CREATE TABLE apple
(
    id      INTEGER NOT NULL,
    dimples INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE banana
(
    id     INTEGER NOT NULL,
    curves INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE orange
(
    id    INTEGER NOT NULL,
    bumps INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE example_p
(
    key       TEXT    NOT NULL,
    value     INTEGER NOT NULL,
    apple_id  INT     NULL,
    banana_id INT     NULL,
    orange_id INT     NULL,
    CONSTRAINT pk_example_p PRIMARY KEY (key),
    CONSTRAINT fk_apple FOREIGN KEY (apple_id) REFERENCES apple (id),
    CONSTRAINT fk_banana FOREIGN KEY (banana_id) REFERENCES banana (id),
    CONSTRAINT fk_orange FOREIGN KEY (orange_id) REFERENCES orange (id),
    CONSTRAINT ct_exclusive_arc CHECK (
                CASE WHEN apple_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN banana_id IS NOT NULL THEN 1 ELSE 0 END
                + CASE WHEN orange_id IS NOT NULL THEN 1 ELSE 0 END
            = 1
        )
);
