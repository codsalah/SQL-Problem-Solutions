WITH joined_data AS (
    SELECT 
        DATE(t.request_at) AS Day,
        t.status
    FROM Trips t
    JOIN Users uc ON t.client_id = uc.users_id AND uc.banned = 'No'
    JOIN Users ud ON t.driver_id = ud.users_id AND ud.banned = 'No'
)
SELECT
    Day,
    ROUND(
      SUM(CASE WHEN status <> 'completed' THEN 1 ELSE 0 END) / COUNT(*),
      2
    ) AS `Cancellation Rate`
FROM joined_data
WHERE Day BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Day;