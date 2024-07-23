/* Write your T-SQL query statement below */
SELECT name, population, area
FROM world
WHERE (area >= 3000000) OR (population >= 25000000)