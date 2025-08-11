/*
Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table.
*/
select p.patient_id, p.first_name, p.last_name from patients p 
JOIN admissions a on p.patient_id = a.patient_id 
WHERE diagnosis = 'Dementia'