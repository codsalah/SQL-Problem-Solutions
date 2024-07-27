SELECT user_id, concat(upper(left(name, 1)), lower(substring(name, 2, len(name) - 1))) AS name
FROM Users
ORDER BY user_id;