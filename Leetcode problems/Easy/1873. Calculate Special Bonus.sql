-- MySQL
select employee_id, 
    (if(employee_id % 2 != 0 and name not like 'M%', salary, 0)) as bonus
    from Employees
    order by employee_id;


-- MSSQL
SELECT employee_id, 
    (CASE
        WHEN employee_id % 2 <> 0 
            and 
        name not like 'M%' THEN salary  
    ELSE 0
    END) as bonus
from Employees
order by employee_id;

