## ERD Entity relationship diagram
An **entity relationship diagram** (ERD) is a common way to view data in a database. Below is the ERD for the database we will use from Parch & Posey. These diagrams help you visualize the data you are analyzing including:
1. The names of the tables.
2. The columns in each table.
3. The way the tables work together.
**You can think of each of the boxes below as a spreadsheet.**

![alt text](<Pasted image 20240618135429-1.png>)

## What to Notice

In the Parch & Posey database there are five tables:
1. `web_events`
2. **accounts**
3. **orders**
4. `sales_reps`
5. **region**
- You can think of each of these tables as an individual spreadsheet. 
- Then the columns in each spreadsheet are listed below the table name. 
- For example, the **region** table has two columns: `id` and `name`. 
- Alternatively the **`web_events`** table has four columns.

![alt text](<Pasted image 20240618135903.png>)

![alt text](<Pasted image 20240618135707.png>)

![alt text](<Pasted image 20240618135841.png>)

The key to SQL is understanding **statements**. A few statements include:
1. **CREATE TABLE** is a statement that creates a new table in a database.
2. **DROP TABLE** is a statement that removes a table in a database.
3. **SELECT** allows you to read data and display it. This is called a **query**.

SELECT … FROM …. (**Mandatory**)
1. **SELECT** indicates which column(s) you want to be given the data for.  
	- FILLING OUT A FORM TO GET A SET OF RESULTS
	- THESE QUESTIONS ARE STRUCTURED IN THE SAME ORDER EVERY TIME
	- Tells the query which column to read from 
	- ==SELECT  deals with the columns==
2. **FROM** specifies from which table(s) you want to select the columns. Notice the columns need to exist in this table.
	- Tells the query what data to use
	- ==FROM deals with the tables==

## naming in SQL
### Using Upper and Lower Case in SQL

```sql
SELECT account_id
FROM orders
```
is the same as:
```sql
select account_id
from orders
```
which is also the same as:
```sql
SeLeCt AcCoUnt_id
FrOm oRdErS
```
 **it is common and best practice to capitalize all SQL commands, like SELECT and FROM, and keep everything else in your query lower case.**

### Avoid Spaces in Table and Variable Names
It is common to use underscores and avoid spaces in column names. It is a bit annoying to work with spaces in SQL. 
In Postgres if you have spaces in column or table names, you need to refer to these columns/tables with double quotes around them 
Ex: `FROM "Table Name" as opposed to FROM table_name`
### Semicolons
It is considered best practice to put a semicolon at the end of each statement, which also allows you to run multiple queries at once if your environment allows this.

## LIMIT
The **LIMIT** command is always the very last part of a query.
 Show just the first 10 rows of the orders table with all of the columns:
 - ==limit deals with the rows==

```sql
SELECT *
FROM orders
LIMIT 10;
```
 
![alt text](<Pasted image 20240618142137.png>)


## ORDER BY
- `ORDER BY` CLAUSE WILL ALLOW YOU TO SORT BY DATE
- `ORDER BY` must be `FROM` and before `LIMIT`
- from a to z , lowest to highest, earliest to latest (**ascending order)**
- if you want to order the other way you can add `DESC` at the end of the `order by` statement
- ==order by deals with columns==
### multiple columns `ORDER BY`
- you can order by two columns like `ORDER BY id, total_amt_usd` 
- **Note** data is ordered by first column then each value of the first column is ordered by the second column 
	- it will first order the **ids** then order the **total amount** for each id
- you can make one column **ascending** and the other column **descending** 
### Quiz
1. Write a query to return the 10 earliest orders in the **orders** table. Include the `id`, `occurred_at`, and `total_amt_usd`.
```sql
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;
```

2. Write a query to return the top 5 **orders** in terms of largest `total_amt_usd`. Include the `id`, `account_id`, and `total_amt_usd`.
```sql
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;
```

3. Write a query to return the lowest 20 **orders** in terms of smallest `total_amt_usd`. Include the `id`, `account_id`, and `total_amt_usd`.
```sql
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;
```
---- 
1. Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).  
  ```sql
  SELECT order_id, account_id, total_amt_usd
  FROM orders
  ORDER BY id, total_amt_usd DESC;
```
    
2. Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).  
  ```sql
  SELECT order_id, account_id, total_amt_usd
  FROM orders
  ORDER BY total_amt_usd DESC, account_id;
```
    
3. Compare the results of these two queries above. How are the results different when you switch the column you sort on first?
**In query #1, all of the orders for each account ID are grouped together and then within each of those groupings, the orders appear from the greatest order amount to the least.**

**In query #2, since you sorted by the total dollar amount first, the orders appear from greatest to least regardless of which account ID they were from. Then they are sorted by account ID next.**

## WHERE
**Where** appear always **after  FROM**  and it has a condition that must be met, You can also think of the **WHERE** command as _filtering_ the data.

Common symbols used in **WHERE** statements include:
1. `>` (greater than)  
2. `<` (less than)  
3. `>=` (greater than or equal to)  
4. `<=` (less than or equal to)  
5. `=` (equal to)  
6. `!=` (not equal to)
### WHERE with Non-Numeric Data

### Quiz

1. Pulls the first 5 rows and all columns from the **orders** table that have a dollar amount of `gloss_amt_usd` greater than or equal to 1000.  
```sql
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;
```  
    
2. Pulls the first 10 rows and all columns from the **orders** table that have a `total_amt_usd` less than 500.
```sql
SELECT *
FROM orders
WHERE total_amt_usd < 500 
LIMIT 5;
```
3. Filter the accounts table to include the company `name`, `website`, and the primary point of contact (`primary_poc`) just for the Exxon Mobil company in the **accounts** table.
```sql
    SELECT name, website, primary_poc
    FROM accounts
    WHERE name = 'Exxon Mobil';
```

## Arithmetic Operators
you can do **Arithmetic Operations** after the select statement for the columns this is called derived column
![[Pasted image 20240618154647.png]]
### Derived column
- A NEW COLUMN THAT IS A MANIPULATION OF THE EXISTING COLUMNS IN YOUR DATABASE
- This derived column, and its alias, are generally only temporary, existing just for the duration of your query.
	- The next time you run a query and access this table, the new column will not be there.

mathematical operators:
1. `*` (Multiplication)
2. `+` (Addition)
3. `-` (Subtraction)
4. `/` (Division)
**example**:

```sql
SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
FROM orders
LIMIT 10;
```

#### Order of Operations
1. Parentheses,
2. Exponents,
3. Multiplication and Division, and
4. Addition and Subtraction
## Quiz
Using the **orders** table:
1. Create a column that divides the `standard_amt_usd` by the `standard_qty` to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the `id` and `account_id` fields.  
```sql
SELECT standard_amt_usd / standard_qty as unit_price, id, account_id
FROM orders
LIMIT 10;
```  
    
1. Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with `_usd`. (Try to do this without using the `total` column.) Display the `id` and `account_id` fields also.
```sql
SELECT  id, account_id
	poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;
```

## Logical Operators

**Logical Operators** include:

1. **LIKE**  
    This allows you to perform operations similar to using **WHERE** and `=`, but for cases when you might **not** know **exactly** what you are looking for.  
2. **IN**  
    This allows you to perform operations similar to using **WHERE** and `=`, but for more than one condition.  
3. **NOT**  
    This is used with **IN** and **LIKE** to select all of the rows **NOT LIKE** or **NOT IN**  
    a certain condition.  
4. **AND & BETWEEN**  
    These allow you to combine operations where all combined conditions must be true.  
5. **OR**  
    This allow you to combine operations where at least one of the combined conditions must be true.

### LIKE
- Like function require the use of **WILD CARD** this wild card is `%` 
- Remember you will need to use single quotes for the text you pass to the **LIKE** operator, because of this lower and uppercase letters are not the same within the string.
-  Searching for **'T'** is not the same as searching for **'t'**. In other SQL environments (outside the classroom), you can use either single or double quotes.

Use the **accounts** table to find
1. All the companies whose names start with 'C'.
```sql 
SELECT name
FROM accounts
WHERE name LIKE 'C%';
```
1. All companies whose names contain the string 'one' somewhere in the name.
```sql
SELECT name
FROM accounts
WHERE name LIKE '%one%';
```
3. All companies whose names end with 's'.
```sql
SELECT name
FROM accounts
WHERE name LIKE '%s';
```

## IN
- The **IN** operator is useful for working with both numeric and text columns. This operator allows you to use an `=`, but for more than one item of that particular column.
- We can check one, two or many column values for which we want to pull data, but all within the same query.
- In the upcoming concepts, you will see the **OR** operator that would also allow us to perform these tasks, but the **IN** operator is a cleaner way to write these queries.
![alt text](<Pasted image 20240618174856.png>)

![alt text](<Pasted image 20240618174946.png>)

### Quiz

1. Use the **accounts** table to find the account `name`, `primary_poc`, and `sales_rep_id` for Walmart, Target, and Nordstrom.
```sql
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');
```
3. Use the **web_events** table to find all information regarding individuals who were contacted via the **channel** of `organic` or `adwords`.
```sql
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');
```

## Not 
- PROVIDES THE INVERSE RESULTS FOR IN, LIKE, AND SIMILAR OPERATORS
- The **NOT** operator is an extremely useful operator for working with the previous two operators we introduced: **IN** and **LIKE**. By specifying **NOT LIKE** or **NOT IN**, we can grab all of the rows that do not meet a particular criteria.

### Quiz
We can pull all of the rows that were excluded from the queries in the previous two concepts with our new operator.

1. Use the **accounts** table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.  
```
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');
```
3. Use the **web_events** table to find all information regarding individuals who were contacted via any method except using `organic` or `adwords` methods.
```sql
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');
```
Use the **accounts** table to find:
1. All the companies whose names do not start with 'C'.  
```sql
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';
```
1. All companies whose names do not contain the string 'one' somewhere in the name.  
```sql
SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';
```
1. All companies whose names do not end with 's'.
```sql
SELECT name
FROM accounts
WHERE name NOT LIKE '%s';
```

🟩 True statement
![alt text](<Pasted image 20240618180218.png>)
![alt text](<Pasted image 20240618180246.png>)

🟥 False statement
![alt text](<Pasted image 20240618180137.png>)
![alt text](<Pasted image 20240618180149.png>)
## Between
a cleaner statement using **BETWEEN** 
Instead of writing :
```
WHERE column >= 6 AND column <= 10
```

we can instead write, equivalently:
```
WHERE column BETWEEN 6 AND 10
```

### Quiz

1. Write a query that returns all the **orders** where the `standard_qty` is over 1000, the `poster_qty` is 0, and the `gloss_qty` is 0.  
```sql
SELECT *
FROM orders
WHERE poster_qty = 0 and gloss_qty = 0 and standard_qty > 1000
```  
    
2. Using the **accounts** table, find all the companies whose names do not start with 'C' and end with 's'.  
 ```sql
   SELECT *
   FROM accounts
   WHERE name LIKE 'c%' and name LIKE '%s'
```  
  
3. When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and `gloss_qty` data for all **orders** where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.  
  ```sql
   SELECT order_date, gloss_qty 
   FROM orders
   WHERE gloss_qty BETWEEN 24 and 29
```  
 
4. Use the **`web_events`** table to find all information regarding individuals who were contacted via the `organic` or `adwords` channels, and started their account at any point in 2016, sorted from newest to oldest.
```sql
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')
	AND occurred_at  BETWEEN "2016-01-01" AND "2017-01-01"
ORDER BY date DESC 
```


## OR
Similar to the **AND** operator, the **OR** operator can combine multiple statements. 
Each time you link a new statement with an **OR**, you will need to specify the column you are interested in looking at.
![alt text](<Pasted image 20240618182048.png>)

![alt text](<Pasted image 20240618182058.png>)

![alt text](<Pasted image 20240618182300.png>)

![alt text](<Pasted image 20240618182313.png>)

