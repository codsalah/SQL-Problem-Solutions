select  date, 
    sum( CASE WHEN paying_customer = 'yes' THEN downloads END) as paying,
    sum( CASE WHEN paying_customer = 'no' THEN downloads END) as non_paying
FROM ms_user_dimension t1
JOIN ms_acc_dimension t2 ON t1.acc_id = t2.acc_id
JOIN ms_download_facts t3 ON t1.user_id = t3.user_id
GROUP BY DATE 
HAVING non_paying > paying