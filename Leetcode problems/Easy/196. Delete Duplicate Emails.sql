/* Write your T-SQL query statement below */
Delete p2 FROM Person p1 JOIN Person p2
ON p1.Email = p2.Email AND p1.id < p2.id 
