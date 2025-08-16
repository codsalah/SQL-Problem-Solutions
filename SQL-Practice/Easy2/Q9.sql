/*
Show the average unit price rounded to 2 decimal places, 
the total units in stock, total discontinued products from the products table.
*/
SELECT 
	round(avg(Unit_Price), 2) AS average_price,
	SUM(units_in_stock) AS total_stock,
	SUM(discontinued) as total_discontinued
FROM products;