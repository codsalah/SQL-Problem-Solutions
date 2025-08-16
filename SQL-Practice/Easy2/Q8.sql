-- Show the first_name, last_name. hire_date of the most recently hired employee.

select first_name, last_name, hire_date from employees
order by hire_date desc limit 1 ;