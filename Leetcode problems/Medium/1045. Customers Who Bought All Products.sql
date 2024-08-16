SELECT c.customer_id FROM Customer c
GROUP BY c.customer_id
HAVING count(DISTINCT product_key) = (SELECT count(*) FROM Product);