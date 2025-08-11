-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.

SELECT city, COUNT(patient_id) AS num_patients
FROM patients
GROUP BY city
ORDER BY COUNT(patient_id) DESC, city ASC;
