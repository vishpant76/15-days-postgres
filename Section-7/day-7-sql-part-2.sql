-- Day 7 - continued...
-- Subqueries in FROM
select round(avg(total_amount), 2) as avg_lifetime_span
from
(select customer_id, sum(amount) as total_amount from payment
group by customer_id) as from_sub_query;

-- Challenge - What is the average total amount spent per day (average daily revenue) ?
-- select * from payment;
select round(avg(total_amount),2) as avg_amt_per_day
from (
	select DATE(payment_date), sum(amount) as total_amount
	from payment
	group by date(payment_date));


-- Subqueries in SELECT
-- Limited use cases
select *, (select round(avg(amount),2) from payment) as Average_Amount
from payment;

-- Challenge: Show all the payments together with how much the payment amount is below the maximum payment amount.
-- select max(amount) from payment;
select *,(select max(amount) from payment)-amount as max_amount_comparison
from payment;


-- Correlated Subqueries in Where
-- Show only those payments that have the highest amount per customer.
select * from payment;

select * from payment p1
where amount = (select max(amount) from payment p2
			   where p1.customer_id = p2.customer_id)
-- 			   group by customer_id)
order by customer_id;

-- Challenge - Show only those movie titles, their associated film_id and replacement_cost with the lowest replacement_costs for every single rating category - also show the rating.
select * from film;

select film_id, title, replacement_cost, rating from film f1
where replacement_cost = (select min(replacement_cost) from film f2
						 where f1.rating = f2.rating)

-- Challenge - Show only those movie titles, their associated film_id and the length that have the highest length in each rating category - also show the rating.
select film_id, title, length, rating from film f1
where length = (select max(length) from film f2
			   where f1.rating = f2.rating)


-- Correlated Subquery in SELECT
-- Show the maximum amount for every customer.
select *, (select max(amount) from payment p2
		  where p1.customer_id = p2.customer_id)
		  from payment p1
order by customer_id;

-- A simpler approach to solve the above, without using correlated subquery, but note that this is grouping by customer_id so there will be only one record per customer_id.
SELECT 
    customer_id, 
    MAX(amount) AS max_amount
FROM payment
GROUP BY customer_id
ORDER BY customer_id;


-- Correlated Subqueries - More Challenges
-- 1. Show all the payments plus the total amount for every customer as well as the number of payments of each customer.
-- select * from payment;
select *, (select sum(amount) from payment p2
			   where p1.customer_id = p2.customer_id),
		  (select count(*) from payment p2
			   where p1.customer_id = p2.customer_id)
			   from payment p1
order by customer_id;

-- 2. Show only those films with the highest replacement costs in their rating category plus show the average replacement cost in their rating category.
select title, replacement_cost, rating, (select round(avg(replacement_cost), 2) as avg_replacement_cost from film f2
		  where f1.rating = f2.rating) 
		  from film f1
where replacement_cost = (select max(replacement_cost) from film f2
						 where f1.rating = f2.rating);

-- 3. Show only those payments with the highest payment amount for each customer's first name - including the payment_id of that payment.
-- How would you solve this if you were not to see the payment_id ?
-- select * from payment;
-- select * from customer;
-- This solution is questionable as it does not quite align with the problem statement of using first_name; it uses customer_id.

select c1.customer_id, c1.first_name, p1.payment_id, amount
from customer c1
inner join payment p1
on p1.customer_id = c1.customer_id
where amount = (select max(amount) from payment p2
			   where p1.customer_id=p2.customer_id)
order by 1;

