SELECT 
    sell_date,
    COUNT(product) AS num_sold,
    STRING_AGG(product, ',') AS products
FROM (
    SELECT DISTINCT sell_date, product
    FROM Activities
) AS distinct_products
GROUP BY sell_date
ORDER BY sell_date;