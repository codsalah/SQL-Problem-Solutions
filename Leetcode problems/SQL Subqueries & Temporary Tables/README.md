
Both **subqueries** and **table expressions** are methods for being able to write a query that creates a table, and then write a query that interacts with this newly created table.
Sometimes the question you are trying to answer doesn't have an answer when working directly with existing tables in database.
**Note** 🔥 You can use subquery almost anywhere 
## Subqueries
Whenever we need to use existing tables to create a new table that we then want to query again, this is an indication that we will need to use some sort of **subquery**.

![alt text](<Pasted image 20240619122814.png>)

![alt text](<Pasted image 20240619122821.png>)


this is now a query in a query also known as subquery, it require **Alias** 

![alt text](<Pasted image 20240619122913.png>)

lets continue We want to find the average number of events for each day for each channel.
The first inner table will provide us the number of events for each day and channel
and then we will need to average these values together using a second query.

![alt text](<Pasted image 20240619123039.png>)

![alt text](<Pasted image 20240619123045.png>)

Note that first your inner query will run on its own as an independent then the outer query will run on the result you got from the inner query

if you are only returning a single value, you might use that value in a logical statement like **WHERE**, **HAVING**, or even **SELECT** - the value could be nested within a **CASE** statement.
Just like:
it works because the result of the subquery is only one cell

![alt text](<Pasted image 20240619124301.png>)

![alt text](<Pasted image 20240619124343.png>)

**Note** ▶
- Most conditional logic will work with subquery that return one cell result
- IN is the only type on conditional logic that work when subquery returns more than one result 
1. Here is the necessary quiz to pull the first month/year combo from the orders table.
```sql
SELECT DATE_TRUNC('month', MIN(occurred_at)) 
FROM orders;
```
2. Then to pull the average for each, we could do this all in one query, but for readability, I provided two queries below to perform each separately.
```sql
SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);
```


![alt text](<Pasted image 20240624040756.png>)

![alt text](<Pasted image 20240624040803.png>)


interesting example here we used the sub query in the where statement instead of joining the two tables to get the employee above age of 30

![alt text](<Pasted image 20240624042408.png>)

![alt text](<Pasted image 20240624042414.png>)
---
### Quiz Subquery

1. First, we needed to group by the day and channel. Then ordering by the **number of events** (the third column) gave us a quick way to answer the first question.
```sql
SELECT DATE_TRUNC('day',occurred_at) AS day,
       channel,
	    COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;
```

2. Here you can see that to get the entire table in question 1 back, we included an `*` in our **SELECT** statement. You will need to be sure to alias your table.
```sql
SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
          FROM web_events 
          GROUP BY 1,2
          ORDER BY 3 DESC) sub;
```

3. Finally, here we are able to get a table that shows the average number of events a day for each channel.
```sql
SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
         FROM web_events 
         GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;
```

## Subquery Formatting
When writing **Subqueries**, it is easy for your query to look incredibly complex. In order to assist your reader, which is often just yourself at a future date, formatting SQL will help with understanding your code.

The important thing to remember when using subqueries is to provide some way for the reader to easily determine which parts of the query will be executed together.

**BAD Formatted Query** section.
```sql
SELECT *
FROM (
SELECT DATE_TRUNC('day',occurred_at) AS day,
channel, COUNT(*) as events
FROM web_events 
GROUP BY 1,2
ORDER BY 3 DESC) sub;
```

---
**WELL Formatted Query** section.
```sql
SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2
      ORDER BY 3 DESC) sub
GROUP BY day, channel, events
ORDER BY 2 DESC;
```

### More Subqueries Quizzes
![[Pasted image 20240618200552.png]]
You should write your solution as a subquery or subqueries, not by finding one solution and copying the output. The importance of this is that it allows your query to be dynamic in answering the question - even if the data changes, you still arrive at the right answer.

1. Provide the **name** of the **`sales_rep`** in each **region** with the largest amount of **`total_amt_usd`** sales.  
```sql
SELECT s.name rep_name, r.name region_name,
		SUM(o.total_amt_usd) total_amt
FROM sales_reps s
JOIN accounts a 
On s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1,2
ORDER BY 3 DESC;
```
2. For the region with the largest (sum) of sales **`total_amt_usd`**, how many **total** (count) orders were placed?  
```sql
SELECT region_name, MAX(total_amt) total_amt
        FROM(
        SELECT s.name rep_name, 
        r.name region_name, 
        SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                JOIN accounts a
                ON a.sales_rep_id = s.id
                JOIN orders o
                ON o.account_id = a.id
                JOIN region r
                ON r.id = s.region_id
                GROUP BY 1, 2) t1
        GROUP BY 1;

```
3. **How many accounts** had more **total** purchases than the account **name** which has bought the most **standard_qty** paper throughout their lifetime as a customer?  
```sql
SELECT
```
4. For the customer that spent the most (in total over their lifetime as a customer) **total_amt_usd**, how many **web_events** did they have for each channel?  
```sql
SELECT
```
5. What is the lifetime average amount spent in terms of **total_amt_usd** for the top 10 total spending **accounts**?  
```sql
SELECT
```
1. What is the lifetime average amount spent in terms of **total_amt_usd**, including only the companies that spent more per order, on average, than the average of all orders.
```sql
SELECT
```

---
## 00 Toy problems
### scalar subquery
this is called scalar sub query as it return a single output 1 value, most of the time will be in the where statement and have an aggregation in it

![alt text](<Pasted image 20240624051303.png>)

now merge them together with the subquery

![alt text](<Pasted image 20240624051326.png>)


find the names of departments where the maximum salary is above
```sql
SELECT department_name
FROM departments
WHERE (
	SELECT MAX(salary) 
	FROM employees 
	WHERE employees.department_id = departments.department_id) > 85000;
```

Scalar Subquery in `SELECT` Clause
you want to list each employee along with the average salary of their department.
this is just instead of join then select
```sql
SELECT employee_id, employee_name, salary,
    (SELECT AVG(salary) 
     FROM employees e2 
     WHERE e2.department_id = e1.department_id) AS avg_department_salary
FROM employees e1;

```

### Multiple row subquery
subquery that return multiple rows and multiple columns or return only 1 column and multiple rows.

![alt text](<Pasted image 20240624052527.png>)

first find the highest salary for each department then combine it with employee table
for first part

![alt text](<Pasted image 20240624052815.png>)

![alt text](<Pasted image 20240624052821.png>)

now we need to use this query to get the employees

![alt text](<Pasted image 20240624053007.png>)

![alt text](<Pasted image 20240624053013.png>)

## 01 First problem 
[Intuitive SQL For Data Analytics - Tutorial (youtube.com)](https://www.youtube.com/watch?v=mXW7JHJM34k)
![alt text](<Pasted image 20240624044021.png>)
simple start
![alt text](<Pasted image 20240624044035.png>)

this wont work as

![alt text](<Pasted image 20240624044509.png>)

this comparesion can not be done 

![alt text](<Pasted image 20240624044529.png>)

so how we can approach this problem
one way is to know the minimum value of experience and insert that value in the where

![alt text](<Pasted image 20240624044659.png>)

![alt text](<Pasted image 20240624044704.png>)

the issue is that we don't want to hard code it so to solve this problem we will use a subquery

![alt text](<Pasted image 20240624044807.png>)

SQL internally will run the inner code to get the minimum value so this is the first condition

the second condition:
![alt text](<Pasted image 20240624044935.png>)

## 02 Second problem
![alt text](<Pasted image 20240624045354.png>)

_**Mentee table**_
**first** we go to the character table which have information about the mentee, and we labeled the table as `mentee_table` 
**second** we filtered it because we are not interested in characters that do not have a mentor
**third** in the select we get few data like the id of mentee , mentor id, and mentee experience
Now our goal is to also get experience of the mentor and we do that with a subquery
so we need to select it using a subquery like: 
**first** we go to characters table and we now call it `mentor_table`
**second** a condition where the id of the second table (mentor table) is the same as the id of the first table (mentee table)

![alt text](<Pasted image 20240624050149.png>)

now we want to see the difference between the character and their mentor
subtract the mentor experience from the mentee experience

## 03 Third problem


























