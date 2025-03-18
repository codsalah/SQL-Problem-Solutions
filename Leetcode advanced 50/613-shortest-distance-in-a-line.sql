select min(next_x - x) as shortest
from (
    select x, lead(x) over (order by x) as next_x
    from point
) t
where next_x is not null;



















