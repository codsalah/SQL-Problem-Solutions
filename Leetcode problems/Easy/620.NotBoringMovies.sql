SELECT id, movie, description, rating
FROM Cinema 
WHERE ID % 2 = 1 and description <> 'boring'  
ORDER BY rating DESC;