select employee_id from Employees 
where employee_id not in (select employee_id from Salaries)
Union
select employee_id from Salaries 
where employee_id not in (select employee_id from Employees)
