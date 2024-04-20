-- Day 5
-- Math functions
-- Challenge 1
-- Create a list of the films including the relation of rental rate/replacement cost where the rental rate is less than 4% of the replacement cost. Create a list of that film IDs together with the percentage rounded to 2 decimal places. e.g: 3.54%
select * from film;

-- This is wrong...
/*
select film_id, rental_rate, replacement_cost, round(0.04*replacement_cost, 2) as percentage
from film
where rental_rate < 0.04*replacement_cost;
*/

-- Correct approach
select film_id, round((rental_rate/replacement_cost *100), 2) as percentage
from film
where round((rental_rate/replacement_cost *100), 2) < 4;


-- CASE WHEN. - Examples will be using demo/flights database
select COUNT(*) as Flights,
CASE
when actual_departure is NULL THEN 'no departure time'
when actual_departure - scheduled_departure < '00:05' THEN 'On Time'
when actual_departure - scheduled_departure < '01:00' THEN 'A little bit late'
ELSE 'Very Late'
END as is_Late
from flights
group by is_late;