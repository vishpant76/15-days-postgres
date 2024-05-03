-- Section 11 - Day 11 - WIndow Functions
-- select * from payment;
select *, SUM(amount) OVER(PARTITION BY customer_id)
from payment;

-- COUNT
-- This will show us how many transactions there were per customer.
select *, count(*) OVER(PARTITION BY customer_id)
from payment;

-- We can even partition by multiple columns
-- How many sales occurred for each staff ID per customer:
select *, SUM(amount) OVER(PARTITION BY customer_id, staff_id)
from payment;

-- Using COUNT without any Paritition By
select *, count(*) OVER() 
FROM payment
order by 1;

-- Using ROUND with Avg when used as window function:
select *, round(avg(amount) over(), 2)
from payment
order by 1;

-- Challenge
-- Write a query that returns the list of movies including: film_id, title, length, category, average length of movies in that category.
-- Order the results by film_id.
select * from film;
select * from film_category;
select * from category;

select f.film_id, f.title, f.length, c.name, ROUND(AVG(f.length) OVER(PARTITION BY c.category_id), 2)
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
order by film_id;

-- Challenge
-- Write a query that returns all payment details including the number of payments that were made by this customer and that amount
-- Order the results by payment_id
select * from payment;
select *, count(*) OVER(PARTITION BY customer_id, amount) as no_of_payments_with_this_amount
from payment
order by payment_id;

-- OVER() with ORDER BY
-- Calculating Running Totals
select *, sum(amount) over(order by payment_id)
from payment;

select *, sum(amount) over(order by payment_date)
from payment;

-- Here, we combine the PARTITION BY with ORDER BY. So the result set will be partitioned according to the customer_id. And since we are using payment_id in ORDER BY, the running total will be calculated for each partition, i.e. for all the rows under a particular customer_id. Once we are done with the current customer_id and move to the next customer_id, the running total will start again from the amount of the first record of that new customer_id, and again it will calculated the running total (the cumulative sum) for the rows under that customer_id and so on.
select *, sum(amount) over(PARTITION BY customer_id order by payment_id)
from payment;

-- Challenge
-- Write a query that returns the running total of how late the flights are (difference between actual_arrival and scheduled_arrival) ordered by flight_id including the departure airport.
select * from flights
-- where flight_id in (18259, 18260);
-- select flight_id, departure_airport, scheduled_arrival-scheduled_departure
-- from flights;
select flight_id, departure_airport, SUM(actual_arrival - scheduled_arrival) OVER (order by flight_id) as sum
from flights;

-- As a second query, calculate the same running total but partition also by the departure airport.
-- select * from pg_timezone_names;
-- ALTER DATABASE demo SET TIMEZONE TO 'Europe/Berlin';
-- show timezone;
-- SELECT current_setting('TIMEZONE');
select flight_id, departure_airport, SUM(actual_arrival - scheduled_arrival) OVER (PARTITION BY departure_airport order by flight_id) as sum
from flights;


-- RANK()
select f.title, c.name, f.length,
RANK() OVER(order by length desc)
from film f
left join film_category fc
on f.film_id = fc.film_id
left join category c
on c.category_id = fc.category_id;
-- DENSE RANK()
select f.title, c.name, f.length,
DENSE_RANK() OVER(order by length desc)
from film f
left join film_category fc
on f.film_id = fc.film_id
left join category c
on c.category_id = fc.category_id;

-- Using Partition By with Rank
select
f.title,
c.name,
f.length,
dense_rank() over(partition by name order by length desc) as rank
from film f
left join film_category fc on f.film_id=fc.film_id
left join category c on c.category_id=fc.category_id;

-- Window function can't be used in WHERE, so use them with Subquery.
select* from
(select
f.title,
c.name,
f.length,
dense_rank() over(partition by name order by length desc) as rank
from film f
left join film_category fc on f.film_id=fc.film_id
left join category c on c.category_id=fc.category_id) a
where rank=18;

-- Challenge
-- Write a query that returns the customers' name, the country and how many payments they have. For that use the existing view customer_list.
-- Create a ranking of the top customers with most sales for each country. Filter the results to only the top 3 customers per country.
-- select * from customer_list;
-- select * from payment;
select * from
(
	select name, country, count(*), dense_rank() over(partition by country order by count(*) desc) as rank 
from customer_list c
left join payment p
on c.id = p.customer_id	
group by name, country) as a -- this alias is optional
where rank BETWEEN 1 and 3;