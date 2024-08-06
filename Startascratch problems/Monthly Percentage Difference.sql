WITH monthly_value AS (
    SELECT 
        TO_CHAR(created_at, 'YYYY-MM') AS year_month, 
        SUM(value) AS value
    FROM sf_transactions
    GROUP BY TO_CHAR(created_at, 'YYYY-MM')
    ORDER BY year_month
)

SELECT 
    year_month, 
    ((value - LAG(value) OVER (ORDER BY year_month)) / LAG(value) OVER (ORDER BY year_month)) * 100 AS percentage_change
FROM monthly_value;