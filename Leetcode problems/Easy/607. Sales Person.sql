WITH CTE AS (
    -- All people who ordered from RED company
    SELECT sales_id
    FROM Orders o 
    LEFT JOIN Company c
    ON o.com_id = c.com_id
    WHERE c.name LIKE 'RED'
)

-- Select names of salespeople who did not order from RED company
SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (SELECT DISTINCT sales_id FROM CTE);