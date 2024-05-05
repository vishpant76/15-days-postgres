-- Section 12 - Day 12
-- Grouping Sets
select to_char(payment_date, 'Month') as month,
staff_id,
SUM(amount)
from payment
group by 
	grouping sets (
	(staff_id),
	(month),
	(staff_id, month))
order by 1, 2;

-- Challenge
-- Write a query that return the sum of the amount for each customer (first and last name) and each staff_id. Also add the overall revenue per customer.
-- select * from customer;
-- select * from payment;
select first_name, last_name, staff_id, sum(amount)
from customer c
left join payment p
on c.customer_id = p.customer_id
group by
	grouping sets (
	(first_name, last_name),
	(first_name, last_name, staff_id));

-- Challenge - Write a query that calculates the share of revenue each staff_id makes per customer.
select first_name, last_name, staff_id, sum(amount),
round(SUM(amount) / FIRST_VALUE(sum(amount)) OVER(PARTITION BY first_name, last_name ORDER BY SUM(amount) desc)*100,2) as percentage
from customer c
left join payment p
on c.customer_id = p.customer_id
group by
	grouping sets (
	(first_name, last_name),
	(first_name, last_name, staff_id))
order by 1,2;