select player_id, device_id 
from Activity 
where (player_id, event_id) in (
    select player_id, min(event_date)
    from Activity 
    group by player_id 
)