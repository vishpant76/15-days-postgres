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

-- Challenge 1
-- 1st
-- How many tickets sold in various categories. How many high price tickets has the company sold?
-- select * from bookings;
select count(*),
case
	when total_amount<20000 then 'Low Price Ticket'
	when total_amount >= 20000 and total_amount<150000 then 'Mid Price Ticket'
	when total_amount>=150000 then 'High Price Ticket'
end as Price_Category
from bookings
group by Price_Category;

-- Challenge 1
-- 2nd
-- How many flights have departed in the following seasons:
-- Winter: Dec, Jan, Feb; Spring: Mar, Apr, May; Summer: June, Jul, Aug; Fall: Sept, Oct, Nov.
select * from flights;
-- select flight_id, flight_no, scheduled_departure, extract(month from scheduled_departure)
-- from flights;
select count(*),
case
	when extract(month from scheduled_departure) in (12, 1, 2) then 'Winter'
	when extract(month from scheduled_departure) in (3, 4, 5) then 'Spring'
	when extract(month from scheduled_departure) in (6, 7, 8) then 'Summer'
	when extract(month from scheduled_departure) in (9, 10, 11) then 'Fall'
end as Departure_Month
from flights
group by Departure_Month;

-- Challenge 1
-- 3rd - This is from Movies Database. The above ones were from Flights database
-- You want to create a tier list as follows:
-- 1. Rating is 'PG' or 'PG-13' or length is more than 210 min: 'Great Rating or Long (Tier 1)'
-- 2. Description contains 'Drama' and length is more than 90 min: 'Long Drama (tier 2)'
-- 3. Description contains 'Drama' and length is not more than 90 min: 'Short Drama (tier 3)'
-- 4. Rental_rate less than $1: 'Very Cheap (tier 4)'
-- If one movie can be in multiple categories, it gets the higher tier assigned.
-- If one movie can be in multiple categories it gets the higher tier assigned. How can you filter to only those movies that appear in one of these 4 tiers?
select * from film;
select title,
case
	when rating='PG' or rating='PG-13' or length>210 then 'Great Rating or Long (Tier 1)'
	when description like '%Drama%' and length>90 then 'Long Drama (tier 2)'
	when description like '%Drama%' and length<=90 then 'Short Drama (tier 3)'
	when rental_rate < 1 then 'Very Cheap (tier 4)'
-- 	ELSE 'None'
END as Movie_Tier
from film
where case
	when rating='PG' or rating='PG-13' or length>210 then 'Great Rating or Long (Tier 1)'
	when description like '%Drama%' and length>90 then 'Long Drama (tier 2)'
	when description like '%Drama%' and length<=90 then 'Short Drama (tier 3)'
	when rental_rate < 1 then 'Very Cheap (tier 4)'
END is not NULL;

-- Challenge Solutions - these are better

-- Challenge 1:

SELECT ticket_price, count(1)
FROM(SELECT
book_ref,
CASE
WHEN total_amount < 20000 THEN 'low price ticket'
WHEN total_amount < 150000 THEN 'mid price ticket'
ELSE 'high price ticket'
END as ticket_price
FROM bookings
) a
GROUP BY ticket_price;


-- Challenge 2:

SELECT 
COUNT(*) as flights,
CASE
WHEN EXTRACT(month from scheduled_departure) IN (12,1,2) THEN 'Winter'
WHEN EXTRACT (month from scheduled_departure) <= 5 THEN 'Spring'
WHEN EXTRACT (month from scheduled_departure) <= 8 THEN 'Summer'
ELSE 'Fall' 
END as season
FROM flights
GROUP BY season


-- Challenge 3:

SELECT
title,
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END as tier_list
FROM film
WHERE 
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END is not null