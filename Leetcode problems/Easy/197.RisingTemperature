WITH TempCompare AS (
    SELECT id, recordDate, temperature,
        LAG(temperature) OVER (ORDER BY recordDate) AS prevTEMP
    FROM Weather
)
SELECT id 
FROM TempCompare 
WHERE prevTEMP IS NOT NULL AND temperature > prevTEMP;