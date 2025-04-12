select
    round(
        sum(case when order_date = customer_pref_delivery_date 
            then 1 else 0 end) * 100.0 / count(*),
        2
    ) as immediate_percentage
from delivery;

