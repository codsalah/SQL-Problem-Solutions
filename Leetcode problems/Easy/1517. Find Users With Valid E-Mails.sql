select user_id, name, mail
from Users
where right(mail,13) = '@leetcode.com'                          -- domain name is @leetcode.com
and left(mail,LEN(mail) - 13) LIKE '[A-Za-z]%'                  -- first part of email is staring with letter either Capital / small 
and left(mail,LEN(mail) - 13) NOT LIKE '%[^A-Za-z0-9._-]%'


---
# Write your MySQL query statement below
SELECT user_id, name, mail
FROM Users 
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$';