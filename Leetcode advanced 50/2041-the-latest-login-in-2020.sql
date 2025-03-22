select user_id, max(time_stamp) as last_stamp 
from Logins where time_stamp like '2020%'
group by user_id