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