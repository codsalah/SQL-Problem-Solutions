Select patient_id, patient_name, conditions 
FROM Patients WHERE conditions like 'DIAB1%' OR conditions like '% DIAB1%'