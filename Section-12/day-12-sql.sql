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

-- Challenge: Write a query that returns all grouping sets in all combinations of customer_id, date and title (of film) with the aggregation of the payment amount.
-- How do you order the output to get that desired result?

select p.customer_id, date(payment_date), f.title, sum(amount)
from payment p
left join rental r
on p.rental_id = r.rental_id
left join inventory i
on i.inventory_id = r.inventory_id
left join film f
on f.film_id = i.film_id
group by
cube(
	p.customer_id,
	date(payment_date),
	title)
order by 1,2,3;

-- SELF JOINS
CREATE TABLE employee (
	employee_id INT,
	name VARCHAR(50),
	manager_id INT);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);

select * from employee;

-- Using self join
select e.employee_id, e.name as employee, m.name as manager, m2.name as manager_of_manager from employee e
left join employee m
on e.manager_id = m.employee_id
left join employee m2
on m.manager_id = m2.employee_id;

-- Find all the pairs of films with the same length!
-- select * from film;

select f1.title, f2.title, f1.length
from film f1
left join film f2
on f1.length = f2.length
where f1.title != f2.title
order by length desc;

-- CROSS JOIN
select staff_id, store.store_id, last_name
from staff
cross join store;

-- Natural join
select * from payment
natural left join customer;

-- with address table
select * from customer
natural inner join address;