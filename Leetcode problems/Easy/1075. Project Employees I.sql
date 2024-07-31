select  p.project_id, 
round(avg(cast(e.experience_years as decimal(10,2))),2)
 average_years
from Project p inner join Employee e 
on p.employee_id=e.employee_id
group by p.project_id