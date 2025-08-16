-- Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
select order_date, shipped_date, customer_id, freight from orders
where order_date = '2018-02-26'