SELECT pn.province_name
FROM patients p 
JOIN province_names pn ON pn.province_id = p.province_id
GROUP BY pn.province_name
HAVING 
    SUM(CASE WHEN p.gender = 'M' THEN 1 ELSE 0 END) > 
    SUM(CASE WHEN p.gender = 'F' THEN 1 ELSE 0 END);