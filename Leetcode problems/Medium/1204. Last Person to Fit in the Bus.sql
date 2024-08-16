-- Write your MySQL query statement below
with cte as (
    select person_id, person_name, 
            SUM(weight) over (order by turn) as added_weight
    FROM Queue
)
select person_name from cte where added_weight <= 1000 
order by added_weight desc limit 1;