# Write your MySQL query statement below

SELECT s.user_id,
       ROUND(AVG(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END), 2) AS confirmation_rate
FROM Signups s LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;