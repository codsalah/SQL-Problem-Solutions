select user_id, email from Users
where email regexp '^[A-Za-z0-9]+@[A-Za-z]+\\.com$'
order by user_id asc;