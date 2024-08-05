SELECT p.product_id, p.product_name 
FROM product p
JOIN sales s
    ON s.product_id = p.product_id
GROUP BY s.product_id 
HAVING MIN(s.sale_date) >= "2019-01-01" 
    AND MAX(s.sale_date) <= "2019-03-31"