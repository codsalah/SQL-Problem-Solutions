SELECT 
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS patients_in_group
FROM patients
GROUP BY FLOOR(weight / 10) * 10
ORDER BY weight_group DESC;