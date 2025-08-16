
SELECT user_id, datediff(max(post_date), min(post_date)) as days_between
from posts 
where year(post_date) = 2021
group by user_id
having count(distinct date(post_date)) >= 2
order by user_id;