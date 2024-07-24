SELECT u.product_id, 
    ROUND(SUM(p.price * u.units) / SUM(u.units), 2) AS average_price
FROM UnitsSold u
INNER JOIN Prices p ON u.product_id = p.product_id
GROUP BY u.product_id;