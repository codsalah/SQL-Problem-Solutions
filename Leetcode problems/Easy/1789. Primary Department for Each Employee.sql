# Write your MySQL query statement below
(select employee_id, department_id FROM Employee WHERE primary_flag = 'Y')
UNION
(select employee_id, department_id FROM Employee GROUP BY employee_id HAVING COUNT(employee_id) = 1 )

/*
select employee_id, department_id from Employee 
where employee_id in (
    select employee_id 
    from Employee 
    group by employee_id 
    having count(distinct department_id) = 1) or primary_flag = "Y";
*/
