WITH together AS (
SELECT 
id,
value as letter
FROM letters_a
UNION ALL
SELECT 
id,
value as letter
FROM letters_b
)

SELECT
regexp_replace((STRING_AGG(chr(letter),' ')),'[^a-zA-Z !"''\(\),\-.:;?]', '', 'g') as sentence
FROM together

