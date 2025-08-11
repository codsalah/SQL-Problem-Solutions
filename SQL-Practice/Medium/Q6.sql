/*
Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.
*/


select 
	count(case when gender = 'M' then 1 end) as male_count,
    count(Case when gender = 'F' then 1 end) as female_count
from patients