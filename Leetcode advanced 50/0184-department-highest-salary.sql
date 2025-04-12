select Department.Name as Department, Employee.Name as Employee, Salary
from Employee join Department on Employee.DepartmentId = Department.Id
where (DepartmentId, Salary) in (
    select DepartmentId, max(Salary)
    from Employee
    group by DepartmentId
)