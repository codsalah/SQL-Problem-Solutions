with max_transaction as (
    select day, max(amount) as max_amount
    from Transactions 
    group by day
)

select t.transaction_id
from Transactions t 
join max_transaction m 
on t.day = m.day and t.amount = m.max_amount 
order by t.transaction_id;