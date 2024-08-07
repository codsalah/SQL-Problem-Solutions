select review_nationality, count(*) num_reviews
from hotel_review
where positive_review != 'No positive'
group by review_nationality
order by num_reviews desc;
