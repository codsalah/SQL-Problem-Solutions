SELECT user_id, COUNT(follower_id) as followers_count
FROM Followers
Group by user_id;