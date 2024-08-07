


SELECT city, avg(mkt_price)
FROM zillow_transactions
GROUP BY city
HAVING(avg(mkt_price)  >  (SELECT avg(mkt_price)
                          FROM zillow_transactions))

                          