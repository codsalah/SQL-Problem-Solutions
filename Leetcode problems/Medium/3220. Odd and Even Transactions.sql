# Write your MySQL query statement below
select transaction_date, 
    SUM(CASE WHEN amount % 2 <> 0 THEN amount ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN amount % 2 = 0 THEN amount ELSE 0 END) AS even_sum
from transactions
group by transaction_date
order by transaction_date;


----
SELECT
    transaction_date,
    SUM(IF(amount%2=1,amount,0)) as odd_sum,
    SUM(IF(amount%2=0,amount,0)) as even_sum
from transactions
group by 1
ORDER by 1 asc


