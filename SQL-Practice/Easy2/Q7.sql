/*
Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
*/

select company_name, contact_name, fax from customers where fax is not null;