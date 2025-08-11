-- Show the first_name, last_name, and height of the patient with the greatest height.

select first_name, last_name, max(height) from patients;
