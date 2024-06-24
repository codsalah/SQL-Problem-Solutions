select 
    product_id,
    (select price from Products where product_id = p.product_id and store = 'store1') as store1,
    (select price from Products where product_id = p.product_id and store = 'store2') as store2,
    (select price from Products where product_id = p.product_id and store = 'store3') as store3
from 
    (SELECT DISTINCT product_id from Products) p;