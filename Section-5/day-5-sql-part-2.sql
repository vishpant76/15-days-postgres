-- DAY 5 continued here...
-- CASE WHEN and SUM
SELECT
  SUM(CASE
    WHEN rating IN ('PG', 'G') THEN 1
    ELSE 0
  END) as no_of_g_or_pg_ratings
FROM
  film

-- 
select rating, count(*)
from film
group by rating;

select
	sum(case when rating='NC-17' then 1 else 0 end) as "NC-17",
	sum(case when rating='PG-13' then 1 else 0 end) as "PG-13",
	sum(case when rating='PG' 	 then 1 else 0 end) as "PG",
	sum(case when rating='G' 	 then 1 else 0 end) as "G",
	sum(case when rating='R' 	 then 1 else 0 end) as "R"
from film;

-- COALESCE
select coalesce(actual_arrival - scheduled_arrival, '0:00')
from flights;

-- CAST - to change the data type
select coalesce(CAST(actual_arrival - scheduled_arrival AS VARCHAR), 'Not Arrived')
from flights;

-- Using CAST with functions
select
length(cast(actual_arrival as varchar))
from flights

-- More examples
select cast(ticket_no as bigint)
from tickets;

-- Challenge
select rental_date, coalesce(cast(return_date as varchar), 'Not Returned')
from rental
order by rental_date desc;

-- REPLACE
-- select passenger_id from tickets;
select replace(passenger_id, ' ', '')
from tickets;

-- select flight_no from flights;
select replace(flight_no, 'PG', '')
from flights;

-- Using REPLACE WITH CAST
select
cast(replace(flight_no, 'PG', '') AS INT)
from flights;