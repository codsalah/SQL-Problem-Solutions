/*
Show the city, company_name, contact_name from the customers and suppliers table merged together.
Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
*/
select city, company_name, contact_name, 'customers' as relationship from customers
UNION
select city, company_name, contact_name, 'suppliers' as relationship from suppliers
