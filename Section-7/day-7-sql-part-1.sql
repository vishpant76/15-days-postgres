-- UNION
select first_name, 'actor' as origin from actor
UNION ALL
select first_name, 'customer' from customer
order by first_name;

-- Multiple Unions
select first_name, 'actor' as origin from actor
UNION ALL
select first_name, 'customer' as test1 from customer
UNION ALL
select first_name, 'staff' from staff
order by first_name;


-- SUBQUERIES:
-- Get the results from the payment table where amount is greater than average
select * from payment
where amount > (select avg(amount) from payment);

-- Select all of payments of customer Adam
select * from payment
where customer_id = (select distinct c.customer_id
					from customer c
					inner join payment p
					on c.customer_id = p.customer_id
					and c.first_name = 'ADAM');

-- Challenge - Select all of the films where the length is longer than the average of all films.
select * from film
where length > (select avg(length)
			   from film);
			   
-- Challenge - Return all the films that are available in the inventory in store 2 more than 3 times.
-- select * from film;
-- select * from inventory;
-- Using JOINS
select f.film_id, title, count(*) from film f
inner join inventory i
on f.film_id = i.film_id
where store_id = 2
group by f.film_id, title
having count(*) > 3
order by 1;
-- Aliter - Using Subquery
select * from film
where film_id IN (select film_id from inventory
				  where store_id = 2
				  group by film_id
				  having count(*) > 3);

-- More Challenges
-- 1. Return all customers' first names and last names that have made a payment on '2020-01-25'.
-- select * from customer;
-- select * from payment;
select first_name, last_name
from customer where customer_id IN (select customer_id from payment
where to_char(payment_date, 'YYYY-MM-DD') = '2020-01-25');

-- 2. Return all customers' first_names and email that have spent more than $30.
select first_name, email
from customer
where customer_id in (select customer_id
					  from payment
					  group by customer_id
				      having sum(amount) > 30);
					  
-- 3. Return all customers' first and last names that are from California and have spent more than 100 in total.
-- select * from customer;
-- select * from address order by district;
-- select * from city;
-- select * from payment;

SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  customer_id IN (
    SELECT
      customer_id
    FROM
      payment
    GROUP BY
      customer_id
    HAVING
      SUM(amount)>100
  )
  AND customer_id IN (
    SELECT
      c.customer_id
    FROM
      customer c
      INNER JOIN address a ON a.address_id=c.address_id
    WHERE
      a.district='California'
  )
ORDER BY
  1;