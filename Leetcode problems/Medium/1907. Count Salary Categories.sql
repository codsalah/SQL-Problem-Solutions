-- Write your PostgreSQL query statement below
with cte as (
    select account_id,
        case 
            when income < 20000 then 'Low Salary'
            when income between 20000 and 50000 then 'Average Salary'
            when income > 50000 then 'High Salary'
        end as category 
    from accounts
)
select 
    ic.category,
    coalesce(count(c.account_id), 0) as accounts_count 
from 
    (values ('Low Salary'), ('Average Salary'), ('High Salary')) as ic(category)
left join 
    cte c on ic.category = c.category
group by 
    ic.category;