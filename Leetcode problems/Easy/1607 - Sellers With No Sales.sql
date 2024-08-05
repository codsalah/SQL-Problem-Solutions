SELECT s.seller_name as name
FROM Seller s
LEFT JOIN Orders o ON o.seller_id = s.seller_id
WHERE YEAR(sale_data) != 2020 

------

SELECT seller_name
FROM Seller
WHERE seller_id NOT IN (
    SELECT seller_id
    FROM Orders
    WHERE YEAR(sale_date) = 2020
);