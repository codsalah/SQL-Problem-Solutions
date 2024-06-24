# Aggregations
**aggregators only aggregate vertically - the values of a column**. meaning they perform calculations on column values across multiple rows.
SQL itself doesn't provide built-in functions for horizontal aggregation
## Count
COUNTS HOW MANY ROWS ARE IN A PARTICULAR COLUMN
![alt text](<Pasted image 20240619082331.png>)
![alt text](<Pasted image 20240619082258.png>)

an example of finding all the rows in the accounts table.
```sql
SELECT COUNT(*)
FROM accounts;
```
or 
```sql
SELECT COUNT(accounts.id)
FROM accounts;
```

WE CAN USE THE COUNT FUNCTION ON ANY COLUMN IN A TABLE
## Sum
ADD ALL VALUES IN A PARTICULAR COLUMN
![alt text](<Pasted image 20240619082744.png>)
You can not use `SUM(*)` so you will need to specify column names rather than using star
**Nulls** will be treated as Zero in the **SUM** function, **SUM** will ignore **NULL** value
you can only use **SUM** on numeric columns.

### Quiz
1. Find the total amount of **`poster_qty`** paper ordered in the **orders** table.  
```sql
SELECT sum(poster_qty)
FROM orders;
```  
    
2. Find the total amount of **`standard_qty`** paper ordered in the **orders** table.  
```sql
SELECT sum(standard_qty)
FROM orders;
```  
    
3. Find the total dollar amount of sales using the **`total_amt_usd`** in the **orders** table.  
```sql
SELECT sum(total_amt_usd)
FROM orders;
```  
    
4. Find the total amount spent on **`standard_amt_usd`** and **`gloss_amt_usd`** paper for each order in the orders table. This should give a dollar amount for each order in the table.  
```sql
SELECT SUM(standard_amt_usd) as sum_standard_usd 
	,SUM(gloss_amt_usd) as sum_gloss_usd
FROM orders;
```  
    
5. Find the **`standard_amt_usd`** per unit of **`standard_qty`** paper. Your solution should use both an aggregation and a mathematical operator.
```sql
SELECT SUM(poster_qty) / SUM(standard_qty) AS std_price_per_unit
FROM orders;
```  

## Min and Max
RETURNS THE LOWEST AND HIGHEST VALUES IN A PARTICULAR COLUMN

## NULLs
It means no data (different from zero), **NULLs** are a datatype that specifies where no data exists in SQL.
They are often ignored in our aggregation functions, which you will get a first look at in the next concept using **COUNT**.
![alt text](<Pasted image 20240619082014.png>)
![alt text](<Pasted image 20240619082042.png>)
Remember that you have to type `IS NULL` not `= null` because `null` is not a value.
**NULL**s frequently occur when performing a **LEFT** or **RIGHT JOIN**. when some rows in the left table of a left join are not matched with rows in the right table, those rows will contain some **NULL** values in the result set.
**NULL**s can also occur from simply missing data in our database.
**Note**
- IF THE COUNT RESULT OF A COLUMN IS LESS THAN THE NUMBER OF ROWS IN THE TABLE, WE KNOW THE DIFFERENCE IS THE NUMBER OF NULLS


![alt text](<Pasted image 20240619090036.png>)

## MIN & MAX and AVG
Notice that **MIN** , **MAX**  and **AVG** are aggregators that again ignore **NULL** values.
rows with null values are ignored means that it will not be part of the computation
![alt text](<Pasted image 20240619090438.png>)
![alt text](<Pasted image 20240619090456.png>)

**Avg** is only used on numerical columns
It is the sum of all of the values in the column divided by the number of values in a column.

![alt text](<Pasted image 20240619090542.png>)
![alt text](<Pasted image 20240619090549.png>)

If you want to deal with **NULLs** as zero, use **(SUM / COUNT)** 

### Quiz
Use the **SQL** environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

1. When was the earliest order ever placed? You only need to return the date.  
```sql
SELECT min(occurred_at)
FROM orders;
```
2. Try performing the same query as in question 1 without using an aggregation function.  
```sql
SELECT occured_at
FROM orders
ORDER BY occured_at 
LIMIT 1;
```
3. When did the most recent (latest) **`web_event`** occur?  
```sql
SELECT max(occurred_at)
FROM web_events;
```
4. Try to perform the result of the previous query without using an aggregation function.  
```sql
SELECT occured_at
FROM web_events
ORDER BY occured_at DESC
LIMIT 1;
```
5. Find the mean (**AVERAGE**) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.  
```sql
SELECT AVG(paper_amt_usd) mean_standard,
	AVG(gloss_qty) mean_gloss, 
	AVG(poster_qty) mean_poster,
	AVG(standard_amt_usd) mean_standard_usd, 
	AVG(gloss_amt_usd) mean_gloss_usd, 
	AVG(poster_amt_usd) mean_poster_usd
FROM orders
LIMIT 6;

```
6. Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN **`total_usd`** spent on all **orders**?
```sql
SELECT *
FROM (SELECT total_amt_usd
         FROM orders
         ORDER BY total_amt_usd
         LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
```

# GROUP BY
`GROUP BY` is between The `WHERE` and `ORDER BY`
using aggregations and group by will return more than one value (group of values), grouped by what you need
_the example below_ is computing the sum of standard, gloss, poster grouped by the account
meaning that each id will have these computations
![alt text](<Pasted image 20240619093553.png>)
- **GROUP BY** can be used to aggregate data within subsets of the data. For example, grouping for different _accounts_, different _regions_, or different _sales representatives_.
- Any column in the **SELECT** statement that is not within an aggregator must be in the **GROUP BY** clause.
- The **GROUP BY** always goes between **WHERE** and **ORDER BY**.
- **ORDER BY** works like **SORT** in spreadsheet software.
>> Note 🔽
>  🟩SQL evaluates the aggregations before the **LIMIT** clause. If you don’t group by any columns, you’ll get a 1-row result—no problem there.
>  🟩If you group by a column with enough unique values that it exceeds the **LIMIT** number, the aggregates will be calculated, and then some rows will simply be omitted from the results.
>  🟩

**example**
![alt text](<Pasted image 20240619104117.png>)
![alt text](<Pasted image 20240619104126.png>)

### Questions: GROUP BY
![alt text](<Pasted image 20240618200552.png>)
1. Which **account** (by name) placed the earliest order? Your solution should have the **account name** and the **date** of the order.  
```sql
SELECT a.name, o.occured_at
FROM orders o
JOIN accounts a
ON a.id = o.account_id 
ORDER BY o.occured_at 
LIMIT 1;
```

```sql
SELECT s.name, min(o.occured_at)
FROM orders o
JOIN accounts a
ON a.id = o.account_id 
ORDER BY o.occured_at 
```
2. Find the total sales in **usd** for each account. You should include two columns - the total sales for each company's orders in **usd** and the company **name**.  
```sql
SELECT a.name, o.total_amt_usd total_sales
FROM orders o
JOIN accounts a
GROUP BY a.name;
```
3. Via what **channel** did the most recent (latest) **`web_event`** occur, which **account** was associated with this **`web_event`**? Your query should return only three values - the **date**, **channel**, and **account name**.  
```sql
SELECT w.occured_at w.channel, a.name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;
```
4. Find the total number of times each type of **channel** from the **`web_events`** was used. Your final table should have two columns - the **channel** and the number of times the channel was used.  
```sql
SELECT w.channel, COUNT(*)
FROM web_events w 
GROUP BY w.channel
```
5. Who was the **primary contact** associated with the earliest **`web_event`**?  
```sql
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occured_at 
LIMIT 1;
```
6. What was the smallest order placed by each **account** in terms of **`total usd`**. Provide only two columns - the account **name** and the **total usd**. Order from smallest dollar amounts to largest.  
```sql
SELECT a.name, MIN(total_amt_usd) smallest_order 
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order
```
7. Find the number of **sales reps** in each region. Your final table should have two columns - the **region** and the number of **sales_reps**. Order from fewest reps to most reps.
```sql
SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;
```

Note
the order and the order by determines which column is ordered on first
you can order `DESC` for any column in your order by
You can **GROUP BY** multiple columns at once, This is often useful to aggregate across a number of different segments.
![alt text](<Pasted image 20240619101416.png>)
![alt text](<Pasted image 20240619101519.png>)

### Questions 2: GROUP BY
Use the **SQL** environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

1. For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account **name** and one for the average quantity purchased for each of the paper types for each account.  
```sql
SELECT a.name, AVG(poster_qty) avg_stand, 
	AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
FROM accounts a
JOIN orders o
ON o.id_account = a.id
GROUP BY a.name;
```
2. For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account **name** and one for the average amount spent on each paper type.  
```sql
SELECT  a.name, AVG(poster_amt_usd) avg_amt_poster,
	AVG(stand_amt_usd) avg_amt_stand, AVG(gloss_amt_usd) avg_amt_gloss
FROM accounts a
JOIN orders o
ON o.id_account = a.id
GROUP BY a.name;
```
3. Determine the number of times a particular **channel** was used in the **`web_events`** table for each **sales rep**. Your final table should have three columns - the **name of the sales rep**, the **channel**, and the number of occurrences. Order your table with the highest number of occurrences first.  
```sql
SELECT s.name, w.occured_at, COUNT(*) AS occurrences
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY occurrences DESC
```
4. Determine the number of times a particular **channel** was used in the **web_events** table for each **region**. Your final table should have three columns - the **region name**, the **channel**, and the number of occurrences. Order your table with the highest number of occurrences first.
```sql
SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

```

## DISTINCT

**DISTINCT** is always used in **SELECT** statements, and it provides the unique rows for all columns written in the **SELECT** statement. Therefore, you only use **DISTINCT** once in any particular SELECT statement.
```sql
SELECT DISTINCT column1, column2, column3
FROM table1;
```

**Note** that **DISTINCT** can slow your queries down quite a bit.

🟥 You would **not** write:

```sql
SELECT DISTINCT column1, DISTINCT column2, DISTINCT column3
FROM table1;
```

### Quiz DISTINCT
1. Use **DISTINCT** to test if there are any accounts associated with more than one region.  
```sql
SELECT a.id account_id, r.id region_id, 
a.name account_name, r.name region_name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;
```

```
SELECT DISTINCT id, name
FROM accounts;
```
2. Have any **sales reps** worked on more than one account?
```sql
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;
```

```sql
SELECT DISTINCT id, name
FROM sales_reps;
```

## HAVING
**HAVING** is the “clean” way to filter a query that has been aggregated, 

### Quiz HAVING
1. How many of the **sales reps** have more than 5 accounts that they manage?  
```sql
SELECT id, name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;
```
2. How many **accounts** have more than 20 orders?  
```sql
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;
```
3. Which account has the most orders?  
```sql
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;
```
4. Which accounts spent more than 30,000 USD total across all orders?  
```sql
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;
```
5. Which accounts spent less than 1,000 USD total across all orders?  
```sql
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;
```
6. Which account has spent the most with us?  
```sql
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;
```
7. Which account has spent the least with us?  
```sql
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;
```
8. Which accounts used `facebook` as a **channel** to contact customers more than 6 times?  
```sql
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;
```
9. Which account used `facebook` most as a **channel**?  
```sql
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;
```
10. Which channel was most frequently used by most accounts?
```sql
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;
```

# Date Functions
![alt text](<Pasted image 20240619113401.png>)
**GROUP** **BY** a date column is not usually very useful in SQL, 

**Group by day**
![alt text](<Pasted image 20240619113531.png>)
### `DATE_TRUNC`
**DATE_TRUNC** allows you to truncate your date to a particular part of your date-time column. Common truncations are `day`, `month`, and `year`.

![alt text](<Pasted image 20240619113550.png>)

![alt text](<Pasted image 20240619113624.png>)

![alt text](<Pasted image 20240619113651.png>)
### DATE_PART
**DATE_PART** can be useful for pulling a specific portion of a date, but notice pulling `month` or day of the week (`dow`) means that you are no longer keeping the years in order. Rather you are grouping for certain components regardless of which year they belonged in.

![alt text](<Pasted image 20240619113731.png>)
### Day of Week (DOW) 
**'DOW'** PULLS THE DAY OF THE WEEK WITH **0 AS SUNDAY AND 6 AS SATURDAY**

![alt text](<Pasted image 20240619113919.png>)
THE **1 AND 2 HERE** IDENTIFY THESE COLUMNS IN THE SELECT STATEMENT
![alt text](<Pasted image 20240619114001.png>)

```sql
SELECT standard_qty, COUNT(*)
FROM orders
GROUP BY 1 
/*(this 1 refers to standard_qty since it is the first of the columns included in the select statement)*/
ORDER BY 1 
/*(this 1 refers to standard_qty since it is the first of the columns included in the select statement)*/
```

### Quiz DATE
1. Find the sales in terms of total dollars for all orders in each `year`, ordered from greatest to least. Do you notice any trends in the yearly sales totals?  
```sql

```
2. Which **month** did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?  
```sql

```
3. Which **year** did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?  
```sql

```
4. Which **month** did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?  
```sql

```
5. In which **month** of which **year** did `Walmart` spend the most on gloss paper in terms of dollars?
```sql

```

# CASE
- The **CASE** statement always goes in the **SELECT** clause.
- **CASE** must include the following components: **WHEN**, **THEN**, and **END**. 
- **ELSE** is an optional component to catch cases that didn’t meet any of the other previous **CASE** conditions.
- You can make any conditional statement using any conditional operator like WHERE between **WHEN** and **THEN**. This includes stringing together multiple conditional statements using AND and OR.

let's use a **CASE** statement. This way any time the **standard_qty** is zero, we will return 0, and otherwise we will return the **unit_price**.

```sql
SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;
```

