SELECT user_id, spend, transaction_date
FROM (
    SELECT 
        user_id, 
        spend, 
        transaction_date, 
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS row_num
    FROM transactions
) t
WHERE row_num = 3;