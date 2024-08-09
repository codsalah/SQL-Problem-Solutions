# Write your MySQL query statement below
WITH CTE as(
    SELECT 
    stock_name,
     SUM(CASE WHEN operation = 'Buy' THEN price ELSE 0 END) as Sumbuy,
     SUM(CASE WHEN operation = 'Buy' THEN price ELSE 0 END) as Sumsell
    FROM Stocks
    GROUP BY stock_name
)
SELECT stock_name, COALESCE(Sumsell, 0) - COALESCE(Sumbuy, 0) as capital_gain_loss FROM CTE