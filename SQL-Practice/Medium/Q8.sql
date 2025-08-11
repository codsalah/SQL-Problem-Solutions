-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

 
SELECT patient_id, diagnosis From admissions
Group by patient_id, diagnosis
Having count(diagnosis) > 1;