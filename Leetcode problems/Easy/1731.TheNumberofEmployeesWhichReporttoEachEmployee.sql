SELECT 
    m.employee_id ,m.name
    ,count(e.reports_to) as reports_count
    ,ROUND(AVG(e.age*1.0),0) as average_age

FROM employees m INNER JOIN employees e ON m.employee_id=e.reports_to
WHERE e.reports_to IS NOT NULL
GROUP BY
    m.employee_id
    ,m.name
ORDER BY m.employee_id;


