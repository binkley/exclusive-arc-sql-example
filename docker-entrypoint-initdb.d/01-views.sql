CREATE VIEW example
AS
SELECT key                                      AS KEY,
       value                                    AS VALUE,
       COALESCE(
               CASE WHEN apple_id IS NOT NULL THEN 'APPLE' ELSE NULL END,
               CASE WHEN banana_id IS NOT NULL THEN 'BANANA' ELSE NULL END,
               CASE WHEN orange_id IS NOT NULL THEN 'ORANGE' ELSE NULL END
       )                                        AS FRUIT_TYPE,
       COALESCE(apple_id, banana_id, orange_id) AS FRUIT_ID
FROM example_p;
