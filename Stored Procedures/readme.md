Resource 

[An Essential Guide to SQL Server Stored Procedure Parameters (sqlservertutorial.net)](https://www.sqlservertutorial.net/sql-server-stored-procedures/sql-server-stored-procedure-parameters/)



## Procedures
A procedure is a set of SQL statements that can be executed together as a single unit.
It is used to perform an operation or a series of operations on the database.
Procedures can accept parameters, perform calculations, update data, and return results.
They provide procedural programming capabilities within the database system, allowing for conditional logic and looping.

![alt text](<Pasted image 20240712191845.png>)

![alt text](<Pasted image 20240712192907.png>)

to use this procedure

![alt text](<Pasted image 20240712192912.png>)
to change in the procedure
![alt text](<Pasted image 20240712193007.png>)
after execution
![alt text](<Pasted image 20240712193023.png>)

![alt text](<Pasted image 20240712193141.png>)

dynamic variable 
give me 
![alt text](<Pasted image 20240712193547.png>)


-- prcedure list of data in table product that has that is 
-- between a min and a max and give me only 15 records
![alt text](<Pasted image 20240712195325.png>)

![alt text](<Pasted image 20240712195337.png>)

## Variables
If we want to use a variable in SQL Server, we have to declare it. The DECLARE statement is used to declare a variable in SQL Server.

A variable is an object that holds a single value of a specific type e.g., integer, date, or varying character string.
We typically use variables in the following cases:
![[Pasted image 20240712195424.png]]

``DECLARE @model_year INT; ``

``SET @model_year = 2023; ``

![alt text](<Pasted image 20240712200558.png>)

![alt text](<Pasted image 20240712200604.png>)

![alt text](<Pasted image 20240712202019.png>)
![alt text](<Pasted image 20240712202034.png>)
giving this variable to a procedure and execute it
![alt text](<Pasted image 20240712202135.png>)
![alt text](<Pasted image 20240712202204.png>)
![alt text](<Pasted image 20240712202211.png>)

### output parameters

In Microsoft SQL Server (MS SQL), variable outputs in stored procedures are commonly used to return values from a procedure back to the calling environment (like an application or another procedure). Here’s how it typically works:

1. **Declaring Variables**: You declare variables within the stored procedure using the `DECLARE` statement. For example:
   ```sql
   DECLARE @OutputVariable INT;
   ```

2. **Assigning Values**: Inside the procedure, you assign values to these variables as needed. For instance:
   ```sql
   SET @OutputVariable = 100;
   ```

3. **Outputting Variables**: To send the value of a variable back to the calling environment, you can use the `OUTPUT` keyword in the procedure's parameter list. This allows you to explicitly state that a parameter is used for output:
   ```sql
   CREATE PROCEDURE GetOutputValue
       @InputVariable INT,
       @OutputVariable INT OUTPUT
   AS
   BEGIN
       -- Perform some operations
       SET @OutputVariable = @InputVariable * 2;
   END
   ```



stored procedure finds products by model year and returns the number of products via the `@product_count` output parameter:
```sql
CREATE PROCEDURE uspFindProductByModel (
    @model_year SMALLINT,
    @product_count INT OUTPUT
) AS
BEGIN
    SELECT 
        product_name,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;

    SELECT @product_count = @@ROWCOUNT;
END;
```

![alt text](<Pasted image 20240712205130.png>)

![alt text](<Pasted image 20240712205222.png>)

![alt text](<Pasted image 20240712205349.png>)

## Dynamic SQL
Dynamic SQL refers to the technique of constructing SQL statements at runtime and then executing them within your database management system

![alt text](<Pasted image 20240712210629.png>)

# T-SQL Batches
## Batches
- Batches are parsed for syntax as a unit
	- Syntax errors cause the entire batch to be rejected
	- Runtime errors may allow the batch to continue after failure, by default.
	- 
![alt text](<Pasted image 20240712212844.png>)


## synonym

![alt text](<Pasted image 20240712212906.png>)
![alt text](<Pasted image 20240712212950.png>)

## CONTROL OF FLOW
![alt text](<Pasted image 20240712213031.png>)

## Working with IF...ELSE

• The IF...ELSE statement is a control-flow statement that allows you to execute or skip a statement block based on a specified condition.
• The following illustrates the syntax of the IF statement:
![alt text](<Pasted image 20240712213106.png>)

![alt text](<Pasted image 20240712213710.png>)
![alt text](<Pasted image 20240712213721.png>)

# WHILE
![alt text](<Pasted image 20240712213726.png>)
![alt text](<Pasted image 20240712213729.png>)
![alt text](<Pasted image 20240712213740.png>)
![alt text](<Pasted image 20240712214238.png>)


![alt text](<Pasted image 20240712214227.png>)
![alt text](<Pasted image 20240712214230.png>)


# Error handling 
![alt text](<Pasted image 20240712214011.png>)
- System error message are in `sys.messages`
- Add custom application errors using `sp_add_message`
# Raise error
## raise

## throw

## alerts



## try catch

