
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


🟥
```sql
select fname, lname, dno, SUM(salary)
from Employee
group by fname, lname, dno;
```

we can not use this because it needs me to place all these columns in the group by

```sql
select fname, lname, dno, SUM(salary)
over(partition by dno) as Sumsal
from Employee;
```

![alt text](<Pasted image 20240707203557.png>)
notice above that it can see the rows in the same partition goes in sum total will be in the last element in the partition

![alt text](<Pasted image 20240707203910.png>)

if we want to display the count of incidents by category but still see the rest of the column in the table 
![alt text](<Pasted image 20240708080051.png>)



## Partition by
it means that the window we will take is from only what we partition with
![alt text](<Pasted image 20240702013043.png>)
### Quiz
Using Derek's previous video as an example, create another running total. This time, create a running total of `standard_amt_usd` (in the `orders` table) over order time with no date truncation. Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.

```sql
SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders
```

Now, modify your query from the previous quiz to include partitions. Still create a running total of `standard_amt_usd` (in the `orders` table) over order time, but this time, date truncate `occurred_at` by year and partition by that same year-truncated `occurred_at` variable. Your final table should have three columns: One with the amount being added for each row, one for the truncated date, and a final column with the running total within each year.

```sql
SELECT standard_amt_usd,
       DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders
```
## ROW_NUMBER & RANK
The `ROW_NUMBER` function assigns a unique sequential integer to rows within a partition of a result set, starting at 1 for the first row in each partition. If there are ties in the ordering, `ROW_NUMBER` will still assign unique numbers to each row.

The `RANK` function also assigns a unique rank to rows within a partition of the result set. However, if there are ties, `RANK` will assign the same rank to all tied rows. The next rank value will jump by the number of tied rows.

![alt text](<Pasted image 20240707204624.png>)

```sql
select fname, lname, dno, Salary, 
rank() over(partition by dno order by salary asc) as ranking
from Employee;
```

for each department rank the salaries ascending (for each dno) and give them rank 
then order the result with ranking (over the whole result) 
```sql
select fname, lname, dno, Salary, 
rank() over(partition by dno order by salary asc) as ranking
from Employee
order by ranking;
```

![alt text](<Pasted image 20240707205221.png>)

Calculate Cumulative Salaries in Each Department
![alt text](<Pasted image 20240707205411.png>)

select the average salary over each department
![alt text](<Pasted image 20240707205651.png>)

![alt text](<Pasted image 20240707210345.png>)

### Ranking functions
![alt text](<Pasted image 20240707210442.png>)
#### Rank
- Ranking functions require a window order clause
- Partitioning is optional
-  To display results in sorted order still requires ORDER BY!
- حاجه متكرره نفس الرانك (ترتيب الصف في ويندو معينه)
- لو مفيش حاجه تميز صف عن التاني خليهم يكونو بنفس الرانك 💯
- لكن بما انك ممكن تكرر كذا صف ف ممكن الرانك الجديد يسكيب ارقام كتير شبه تحت هنا
![alt text](<Pasted image 20240708081837.png>)
**EX**
this is order by per department (give each one a rank)
if a tie you will give them the same rank
![alt text](<Pasted image 20240708082152.png>)

![alt text](<Pasted image 20240708082601.png>)

#### DENSE_RANK
The `DENSE_RANK()` function also assigns ranks to rows within the partition of a result set but does not skip ranks if there are ties.
It produces consecutive ranks without gaps, ensuring each row gets a unique rank.
هنا بقا كرر زي منت عايز كده كده الرانك الجديد مش هيسكيب ارقام شبه تحت هنا

![alt text](<Pasted image 20240708082007.png>)

using the dense rank 
![alt text](<Pasted image 20240708082650.png>)

notice the differences with the rank

![alt text](<Pasted image 20240708082739.png>)
dense rank does not skip any rank if a tie happen
#### `Row_number`


#### `ntile`
group some values in some buckets (ranges) and gives you the percentile
so it takes a number of buckets as an argument
```sql
NTILE(number_of_buckets) OVER ([PARTITION BY partition_expression] ORDER BY sort_expression)
```
Let's divide these employees into 3 buckets based on their salaries:
```sql
SELECT employee_id, salary,
       NTILE(3) OVER (ORDER BY salary DESC) AS bucket
FROM employees;
```


```sql
SELECT employee_id, salary,
       NTILE(4) OVER (ORDER BY salary DESC) AS quartile
FROM employees;
```
**Use Cases**: Useful for creating percentiles, quartiles, deciles, and other types of grouped data analysis.

# Window Distribution Functions

![alt text](<Pasted image 20240707211300.png>)

```sql
SELECT
    fname,
    lname,
	dno,
	salary,
    PERCENT_RANK() OVER (partition by dno ORDER BY salary DESC) AS percent_rank
FROM Employee;
```

## Window Offset Functions
- Window offset functions allow comparisons between rows in a set without the need for a self-join
- Offset functions operate on a position relative to the current row, or to the start or end of the window frame

![[Pasted image 20240707211633.png]]

#### Lag 
number of rows above is with me in the functions
note that it all need `order by`
![alt text](<Pasted image 20240707211748.png>)

![alt text](<Pasted image 20240707211936.png>)
It can see the whole data ordered by salary `decsending` compare each two and return what is 

This will shift by 2 lagging for each partition group

![alt text](<Pasted image 20240707212658.png>)

![alt text](<Pasted image 20240707212708.png>)

**EX** another 

![alt text](<Pasted image 20240708083010.png>)

![alt text](<Pasted image 20240708083042.png>)
salary and lag of the salary gives you the previous record 
##### Nulls in lag
if you find null in lag this means that the category is started,  (the first record in the category)
#### Lead 
number of rows below is with me in the functions
note that it all need `order by`, shift also but to get from the after record

![alt text](<Pasted image 20240708083118.png>)

![alt text](<Pasted image 20240708083130.png>)

##### Nulls in lead
if you find null this means that the category is finished (the last record in the category)
### First value 
To retrieve the first value within a partition ordered by a specific criteria (e.g., salary), you can use the `FIRST_VALUE()` window function.
```sql
SELECT
    fname,
    lname,
    dno,
    salary,
    FIRST_VALUE(salary) OVER (PARTITION BY dno ORDER BY salary ASC) AS first_salary
FROM Employee;
```

**`FIRST_VALUE(salary) OVER (PARTITION BY dno ORDER BY salary ASC)`**:

- **`FIRST_VALUE(salary)`**: Retrieves the first value of `salary` within each partition (`dno`).
- **`OVER (PARTITION BY dno ORDER BY salary ASC)`**: Partitions the data by `dno` and orders rows within each partition by `salary` in ascending order (`ASC`).
### last value
SQL does not have a direct function like `LAST_VALUE()` for window functions because it requires specifying the entire window frame, which is often not practical.

```sql
SELECT
    fname,
    lname,
    dno,
    salary,
    MAX(salary) OVER (PARTITION BY dno ORDER BY salary ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_salary
FROM Employee;
```

# Window Boundaries

![alt text](<Pasted image 20240707213224.png>)

```sql
SELECT
    fname,
    lname,
    dno,
    salary,
    SUM(salary) OVER(ORDER BY salary DESC ROWS 
    BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS PrevEmp
FROM Employee;
```

![alt text](<Pasted image 20240707213603.png>)
```sql
SELECT
    fname,
    lname,
    dno,
    salary,
    SUM(salary) OVER(ORDER BY salary DESC ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING) AS PrevEmp
FROM Employee;
```
![alt text](<Pasted image 20240707213625.png>)

# Pivoting and Grouping Sets
- Pivoting data is rotating data from a `rows-based` orientation to a `columns-based` orientation.
- Distinct values from a single column are projected across as headings for other columns _may include aggregation_

![alt text](<Pasted image 20240707213718.png>)

### Elements of PIVOT
• Pivoting includes three phases:
- Grouping determines which element gets a row in the result set
- Spreading provides the distinct values to be pivoted across
- Aggregation performs an aggregation function (such as SUM)

![alt text](<Pasted image 20240707213822.png>)

![alt text](<Pasted image 20240707213827.png>)

![alt text](<Pasted image 20240707214106.png>)


### UNPIVOT
![alt text](<Pasted image 20240707214212.png>)

### Grouping Sets
- clause BY GROUP T-SQL on builds subclause SETS GROUPING •
- query same in defined be to groupings multiple Allows •
- outputs multiple combine to ALL UNION of use to Alternative •
- set result one into (BY GROUP different with each)

![alt text](<Pasted image 20240707214409.png>)

![alt text](<Pasted image 20240707214514.png>)

![alt text](<Pasted image 20240707214921.png>)

## Cube 
_Available in: Oracle, SQL Server, and Postgres (not MySQL)._
It’s similar to ROLLUP in SQL but allows for more subtotals to be shown.

![alt text](<Pasted image 20240707220556.png>)

The `CUBE` operation generates a result set that includes subtotals for every combination of the columns
gives you the sum but with all the combinations

## ROLLUP
![alt text](<Pasted image 20240707220606.png>)
Generates hierarchical subtotals moving from specific to general.
Provides subtotals moving from specific to more general,
Provides fewer subtotals compared to `CUBE`.
## Grouping Id

![alt text](<Pasted image 20240707215322.png>)

# Task
