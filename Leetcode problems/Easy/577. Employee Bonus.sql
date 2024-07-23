/* Write your T-SQL query statement below */
SELECT E.name, B.bonus
FROM Employee E
LEFT JOIN Bonus B ON E.empID = B.empID
WHERE B.bonus < 1000 OR B.bonus is Null;
