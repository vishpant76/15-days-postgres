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


-- ROLLUP
select
'Q' || to_char(payment_date, 'Q') as quarter,
EXTRACT(month from payment_date) as month,
date(payment_date), sum(amount)
from payment
group by
rollup(
'Q' || to_char(payment_date, 'Q'),
EXTRACT(month from payment_date),
date(payment_date)
)
order by 1,2,3;

-- Challenge - Write a query that calculates a booking amount rollup for the hierarchy of quarter, week in month and day.
-- select * from bookings;
select
'Q' || to_char(book_date, 'Q') as quarter,
EXTRACT(month from book_date) as month,
to_char(book_date, 'w') as week_in_month,
date(book_date),
sum(total_amount)
from bookings
group by
rollup(
	'Q' || to_char(book_date, 'Q'),
	EXTRACT(month from book_date),
	to_char(book_date, 'w'),
	date(book_date)
)
order by 1,2,3,4;

-- CUBE
-- select * from payment;
select customer_id, staff_id, date(payment_date),
sum(amount)
from payment
group by
cube(
	customer_id,
	staff_id, 
	date(payment_date)
	)
order by 1,2,3;

-- Challenge: Write a query that returns all grouping sets in all combinations of customer_id, date and title with the aggregation of the payment amount.
select * from payment;
select * from customer_list;
select, customer_id, date(payment_date),  