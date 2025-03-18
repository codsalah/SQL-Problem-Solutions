-- first login for each player (min event_date but for each player)

select player_id, min(event_date)
from Activity 
group by player_id 
