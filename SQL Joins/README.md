# Introduction to JOINs
- **JOIN** tells query an in additional table from which you would like to pull data
- **JOIN** statements is to allow us to pull data from more than one table at a time.
- We use **ON** clause to specify a **JOIN** condition which is a logical statement to combine the table in `FROM` and `JOIN` statements.

![alt text](<Pasted image 20240618194908.png>)
```sql
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```
- The **JOIN** indicates the second table. The **ON** clause specifies the column on which you'd like to merge the two tables together.
- The **ON** statement holds the two columns that get linked across the two tables.
- to select specific columns to appear provide `table_name.column_name`  like this:
	- This query only **pulls two columns**, not all the information in these two tables.
```sql
SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

the below query pulls all the columns from _both_ the **accounts** and **orders** table.
```sql
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

### Quiz

1. Try pulling all the data from the **accounts** table, and all the data from the **orders** table.  
```sql
SELECT *
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;
```  
    
1. Try pulling **`standard_qty`**, **`gloss_qty`**, and **`poster_qty`** from the **orders** table, and the **website** and the **`primary_poc`** from the **accounts** table.
```sql
SELECT orders.standard_qty, orders.gloss_qty,
	orders.poster_qty, accounts.primary_poc, 
	accounts.primary_poc
FROM orders
JOIN website
ON orders.account_id = accounts.id;
```  

# Entity Relationship Diagrams
an **entity relationship diagram** (ERD) is a common way to view data in a database. It is also a key element to understanding how we can pull data from multiple tables.

![alt text](<Pasted image 20240618200028.png>)

observe that tables have **PK** or **FK** next to the column name, while other columns don't have a label at all.
 the **PK** is associated with the first column in every table. The **PK** here stands for **primary key**.
A **primary key** exists in every table, and it is a column that has a **unique** value for every row.
For this database it is always called `id`, but that is not true of all databases.
### Primary Key (PK)
A **primary key** is a unique column in a particular table. This is the first column in each of our tables. Here, those columns are all called **id**, but that doesn't necessarily have to be the name.
It is common that the **primary key** is the **first column** in our tables in most databases.
### Foreign Key (FK)
A **foreign key** is a _column in one table that is a primary key in a different table_. We can see in the Parch & Posey ERD that the foreign keys are:
1. **`region_id`**
2. **`account_id`**
3. **`sales_rep_id`**

![alt text](<Pasted image 20240618200349.png>)

### Primary - Foreign Key Link
1. The **`region_id`** is the foreign key.
2. The `region_id` is **linked** to `id` - this is the primary-foreign key link that connects these two tables.
3. The crow's foot shows that the **FK** can actually appear in many rows in the **`sales_reps`** table.
4. While the single line is telling us that the **PK** shows that id appears only once per row in this table.

![alt text](<Pasted image 20240618200552.png>)

| Definition or Column Description       | Term or Column                                                                                         |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| account_id                             | A foreign key that exists in both the **`web_events`** and **`orders`** tables.                        |
| Primary Key                            | Has a unique value for every row in that column. There is one in every table.                          |
| ON web_events.account_id = accounts.id | The **`ON`** statement associated with a **`JOIN`** of the **`web_events`** and **`accounts`** tables. |
| Foreign Key                            | The **`link`** to the primary key that exists in another table.                                        |
| id                                     | The primary key in every table of our example database.                                                |
# JOIN Revisited

![alt text](<Pasted image 20240618200921.png>)

```sql
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
```

![alt text](<Pasted image 20240618200928.png>)

`ON sales_reps.region_id = region.id`

```sql
SELECT web_events.channel, accounts.name, orders.total
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id
```
![alt text](<Pasted image 20240618201359.png>)

**Note** ▶ the join condition is not affected by the order of the columns in the equality comparison. 
`accounts.id = web_events.account_id` and `web_events.account_id = accounts.id`

# Alias
THE ALIAS FOR A TABLE WILL BE **CREATED IN** THE **FROM** OR **JOIN** CLAUSES

Example:

```sql
SELECT t1.*, t2.*
FROM tablename AS t1
JOIN tablename2 AS t2
	ON t1.PK = t2.FK
```

## Quiz
![alt text](<Pasted image 20240618201948.png>)

1. Provide a table for all **web_events** associated with account **name** of `Walmart`. There should be three columns. Be sure to include the `primary_poc`, time of the event, and the `channel` for each event. Additionally, you might choose to add a fourth column to assure only `Walmart` events were chosen.  
  ```sql
SELECT a.primary_poc, w.occured_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.acount_id = a.id
WHERE a.name = 'Walmart';
```  
    
2. Provide a table that provides the **region** for each **sales_rep** along with their associated **accounts**. Your final table should include three columns: the region **name**, the sales rep **name**, and the account **name**. Sort the accounts alphabetically (A-Z) according to account name.  
  ```sql
SELECT r.name region, s.name rep, a.name account 
FROM sales_reps s 
JOIN acounts a
ON s.id = a.sales_rep_od
JOIN region r
ON r.id = s.region_id
ORDER BY a.name;
/*the order of the `JOIN` clauses can be switched without affecting the correctness of the query*/
```  
    
3. Provide the **name** for each region for every **order**, as well as the account **name** and the **unit price** they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: **region name**, **account name**, and **unit price**. A few accounts have 0 for **total**, so I divided by (total + 0.01) to assure not dividing by zero.
  ```sql
SELECT r.name, a.name, (o.total_amt_usd/o.total+ 0.01) as unit_price
FROM region r 
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id

```  
    

# LEFT and RIGHT JOINs
## types of joins 
![alt text](<Pasted image 20240619075906.png>)

![alt text](<Pasted image 20240618205318.png>)

## Inner join
![alt text](<Pasted image 20240618204515.png>)
these are the tables that you will get back when you type `join` , `inner join`
![alt text](<Pasted image 20240618204604.png>)
just like this:
![alt text](<Pasted image 20240618204746.png>)

![alt text](<Pasted image 20240618204809.png>)

![alt text](<Pasted image 20240618204814.png>)
an inner join will return only rows in the inner section ()
![alt text](<Pasted image 20240618204825.png>)
the account that did not have an order yet will not be shown in the `inner join `

```sql
SELECT columns
FROM table1
JOIN table2
ON table1.common_column = table2.common_column;
```
Returns only the rows that have matching values in both tables.
## Left join
every single row in the order table here can be matched with the accounts table 
![alt text](<Pasted image 20240618205437.png>)

![alt text](<Pasted image 20240618205454.png>)
```sql
SELECT columns
FROM left_table
LEFT JOIN right_table
ON left_table.common_column = right_table.common_column;

```
Returns all rows from the left table and the matched rows from the right table.
If no match is found, NULL values are returned for columns from the right table.
## right join (rarely used)

![alt text](<Pasted image 20240618205549.png>)

![alt text](<Pasted image 20240618205608.png>)

```sql
SELECT columns
FROM left_table
RIGHT JOIN right_table
ON left_table.common_column = right_table.common_column;

```
Returns all rows from the right table and the matched rows from the left table.
If no match is found, NULL values are returned for columns from the left table.
## outer join (Full join)
- if you want to include  data that does not exist in both tables but exist in one of the tables you will need to use inner join
- The last type of join is a full outer join. This will return the inner join result set, as well as any unmatched rows from either of the two tables being joined.

```sql
SELECT columns
FROM table1
FULL JOIN table2
ON table1.common_column = table2.common_column;
```
Returns all rows when there is a match in either left or right table.
Rows without a match in either table are included with NULL values.
# JOINs and Filtering

**Example: INNER JOIN with Filtering**
```sql
SELECT employees.name, departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id
WHERE departments.location = 'New York';
```

**Example: LEFT JOIN with Filtering**
```sql
SELECT employees.name, departments.department_name 
FROM employees LEFT 
JOIN departments 
ON employees.department_id = departments.department_id 
WHERE employees.status = 'Active';
```




