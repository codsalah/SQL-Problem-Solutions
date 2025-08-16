/*
Show the category_name and the average product unit price for each category rounded to 2 decimal places.
*/

select 
	c.category_name, 
	round(avg(unit_price), 2) as average_unit_price
from products p
join categories c on c.category_id = p.category_id
group by category_name;