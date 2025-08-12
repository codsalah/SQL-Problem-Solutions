/*
Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

Check patients, admissions, and doctors tables for required information. 
*/

SELECT p.patient_id, p.first_name, p.last_name, d.specialty FROM patients p
JOIn admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE d.first_name = 'Lisa' and a.diagnosis = 'Epilepsy'