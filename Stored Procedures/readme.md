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
