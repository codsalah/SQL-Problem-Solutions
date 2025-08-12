SELECT
    admission_date,
    COUNT(*) AS total_admissions,
    COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY admission_date) AS change_from_previous_day
FROM admissions
GROUP BY admission_date
ORDER BY admission_date;
