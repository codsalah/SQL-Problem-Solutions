SELECT count(DISTINCT customer_id),
       avg(amount)
FROM postmates_orders