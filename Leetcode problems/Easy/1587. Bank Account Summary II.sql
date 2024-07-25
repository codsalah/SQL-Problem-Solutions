SELECT u.name, SUM(amount) AS balance
FROM Transactions t
JOIN Users u ON u.account = t.account    
GROUP BY u.account, u.name
HAVING SUM(amount) > 10000;