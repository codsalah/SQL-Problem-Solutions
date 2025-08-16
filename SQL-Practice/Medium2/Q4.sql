/*
Show the total amount of orders for each year/month.
*/
select 
	year(order_date) order_year,
	month(order_date) order_month,
	count(order_id) no_of_orders
from orders
group by year(order_date), month(order_date);