SELECT 
    p.product_id, 
    COALESCE(lp.new_price, 10) AS price
FROM 
    (SELECT DISTINCT product_id FROM products) p
LEFT JOIN 
    products lp 
ON 
    p.product_id = lp.product_id 
    AND lp.change_date = (
        SELECT MAX(change_date) 
        FROM products 
        WHERE product_id = p.product_id 
          AND change_date <= '2019-08-16'
    )
ORDER BY 
    p.product_id;