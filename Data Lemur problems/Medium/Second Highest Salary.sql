select salary as second_highest_salary
from (select name, salary, rank() over(order by salary DESC) ranker from employee) t
where ranker = 2;
