INSERT INTO apple (id, dimples)
VALUES (1, 3);

INSERT INTO banana (id, curves)
VALUES (1, 1);

INSERT INTO orange (id, bumps)
VALUES (1, 42);

INSERT INTO example_p (key, value, apple_id, banana_id, orange_id)
VALUES ('abc', 1, 1, NULL, NULL);
INSERT INTO example_p (key, value, apple_id, banana_id, orange_id)
VALUES ('def', 2, NULL, 1, NULL);
INSERT INTO example_p (key, value, apple_id, banana_id, orange_id)
VALUES ('ghi', 3, NULL, NULL, 1);
