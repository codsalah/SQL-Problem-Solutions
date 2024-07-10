
[SQL Window Function | How to write SQL Query using Frame Clause, CUME_DIST | SQL Queries Tutorial (youtube.com)](https://www.youtube.com/watch?v=zAmJPdZu8Rg&list=PLavw5C92dz9GbmgiW4TWVnxhjMFOIf0Q7&index=2)

[SQL Window Function | How to write SQL Query using RANK, DENSE RANK, LEAD/LAG | SQL Queries Tutorial (youtube.com)](https://www.youtube.com/watch?v=Ww71knvhQ-s&t=196s)


-----
#  Window Functions
- like grouping but for complex functions, it is like open window on part of the table then another part of the table and so on 
- **`window_function`**: The aggregate or analytic function you want to apply (e.g., `SUM`, `AVG`, `ROW_NUMBER`, `RANK`, etc.).
- you can call a window function using `over`

A _window function_ performs a calculation across a set of table rows that are somehow related to the current row.

this query creates an aggregation of group by without using it
its like (take the sum of `standard_quantity` across all rows leading up to a given row in order by `occured_at`)

![alt text](<Pasted image 20240702012833.png>)
![alt text](<Pasted image 20240702012910.png>)
![alt text](<Pasted image 20240707202344.png>)


![alt text](<Pasted image 20240707202525.png>)

- `over` see all the results, `partition by` see the partition, frame or boundaries have rows
- we can use over clause more than once in the same select query
- partitioning limits a set to rows with the same value in the partitioning


![alt text](<Pasted image 20240707202743.png>)
- calculates the sum of salaries (`Sumsal`) for each department (`dno`) and displays the first name (`fname`), last name (`lname`), department number (`dno`), and the calculated sum for each employee in the `Employee` table.

![alt text](<Pasted image 20240707203113.png>)
![alt text](<Pasted image 20240707203117.png>)

