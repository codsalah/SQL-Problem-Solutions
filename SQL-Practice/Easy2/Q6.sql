-- Show the city, company_name, contact_name of all customers from cities 
-- which contains the letter 'L' in the city name, sorted by contact_name
 
select city, company_name, contact_name from customers 
where city like '%l%' order by contact_name;