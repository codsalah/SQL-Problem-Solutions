select seat_id
from (
    select seat_id,
           free,
           lag(free, 1) over (order by seat_id) as prev_free,
           lead(free, 1) over (order by seat_id) as next_free
    from Cinema
) t
where free = 1 and prev_free = 1 or next_free = 1
order by seat_id;










