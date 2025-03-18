
-- think of it from the most inner, first get the RED company id, 
-- then get the salesperson id that is not in the orders table
-- then get the name of the salesperson from the salesperson table
select s.name from SalesPerson s 
where s.sales_id not in (
    select sales_id from Orders 
    where com_id in (
        select com_id from Company 
        where name = 'RED'));