SELECT has_insurance, SUM(cost_after_insurance)
FROM (
    SELECT 
        CASE 
            WHEN patient_id % 2 = 0 THEN 'YES'
            ELSE 'No'
        END AS has_insurance,
        CASE 
            WHEN patient_id % 2 = 0 THEN 10
            ELSE 50
        END AS cost_after_insurance
    FROM admissions
) sub
GROUP BY has_insurance;