SELECT id, visit_date, people
FROM (
    SELECT *,
           LAG(id, 1) OVER (ORDER BY id) AS prev_id,
           LAG(id, 2) OVER (ORDER BY id) AS prev2_id,
           LEAD(id, 1) OVER (ORDER BY id) AS next_id,
           LEAD(id, 2) OVER (ORDER BY id) AS next2_id
    FROM Stadium
    WHERE people >= 100
) AS t
WHERE 
      -- Middle of a streak
      (id - prev_id = 1 AND next_id - id = 1)
   OR -- Start of a streak
      (next_id - id = 1 AND next2_id - next_id = 1)
   OR -- End of a streak
      (id - prev_id = 1 AND prev_id - prev2_id = 1)
ORDER BY visit_date;
