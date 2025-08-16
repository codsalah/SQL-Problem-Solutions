SELECT
    user_id,
    tweet_date,
    ROUND(
        AVG(tweet_count) OVER (
            PARTITION BY user_id
            ORDER BY tweet_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW  ---- -_-
        ), 2
    ) AS rolling_avg_3d
FROM tweets
ORDER BY user_id, tweet_date;
