/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(LEFT(CITY, 1)) IN ('A', 'E', 'I', 'O', 'U')
  AND UPPER(RIGHT(CITY, 1)) IN ('A', 'E', 'I', 'O', 'U');