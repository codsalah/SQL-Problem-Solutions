-- Identify Managers with 5 or More Direct Reports
WITH managers AS (
    SELECT managerId
    FROM Employee WHERE managerId IS NOT NULL
    GROUP BY managerId HAVING COUNT(*) >= 5
)
-- Select only Manager Names
SELECT name FROM Employee
WHERE id IN (SELECT managerId FROM managers);