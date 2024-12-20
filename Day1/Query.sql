
SELECT
 DISTINCT c.name,
 wl.wishes->>'first_choice' AS primary_wish,       -- JSON operator ->> to extract value from JSON object to STRING
 wl.wishes ->>'second_choice' AS backup_wish,
 wl.wishes->'colors'->>0 AS favorite_color,        -- JSON operator -> to extract value from JSON object to JSON
 json_array_length(wl.wishes->'colors') AS color_count,
 CASE 
  WHEN tc.difficulty_to_make >= 3 THEN 'Complex Gift'
  WHEN tc.difficulty_to_make = 2 THEN 'Moderate Gift'
  WHEN tc.difficulty_to_make = 1 THEN 'Simple Gift'
 END AS gift_complexity,
  CASE 
  WHEN tc.category = 'outdoor' THEN 'Outside Workshop'
  WHEN tc.category = 'educational' THEN 'Learning Workshop'
  ELSE 'General Workshop'
 END AS workshop_assignment
FROM children c
JOIN wish_lists wl 
ON c.child_id = wl.child_id
JOIN toy_catalogue tc 
ON wl.wishes ->> 'first_choice' = tc.toy_name
ORDER BY c.name
LIMIT 5                

 