-- Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'

select first_name, last_name, allergies from patients where allergies is not null and city = 'Hamilton';