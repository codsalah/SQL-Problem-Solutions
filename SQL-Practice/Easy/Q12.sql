-- Show all the columns from admissions where the patient was admitted and discharged on the same day.

select * from admissions where admission_date = discharge_date;