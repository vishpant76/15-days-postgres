-- DAY 2
-- WHERE
select * from payment
where amount = 0;

select first_name, last_name
from 
customer
where first_name = 'ADAM';

-- Challenge 1
-- How many payments were made by the customer with customer_id 100
select count(*) from payment
where customer_id=100;
-- last name of customer with first name Erica
select * from customer
where first_name = 'ERICA';

-- Challenge 2
-- How many rentals have not been returned yet.
select count(*) from rental
where return_date is null;

--
select payment_id, amount
from payment
where amount<=2;


-- WHERE with AND/OR
select * from payment
where customer_id= 30
or customer_id = 31
and amount = 2.99

-- Challenge 3
select * from payment
where customer_id in (322, 346, 354) and (amount<2 or amount>10)
order by customer_id, amount desc;

-- ALTER DATABASE greencycles SET timezone TO 'Europe/Berlin';

-- BETWEEN
select payment_id, amount
from payment
where payment_date between '2020-01-24' and '2020-01-26';

-- BETWEEN and DATES with date format transformed
select * from rental
where rental_date between '2005-05-24' and '2005-05-26 00:00'
order by rental_date desc;

-- Challenge
-- Payments made between Jan 26th and 27th 2020 with an amount between 1.99 and 3.99
-- Results might be slightly different because my timezone is different from Udemy instructor's timezone.
select count(*) from payment
where (payment_date between '2020-01-26' and '2020-01-27 23:59') and (amount between 1.99 and 3.99);

-- IN and NOT IN
-- Challenge 4
select * from payment
where customer_id in (12, 25, 67, 93, 124, 234)
and
amount in (4.99, 7.99, 9.99)
and payment_date between '2020-01-01' and '2020-02-01';


-- LIKE
-- Challenge 5
-- 1st
select count(*) from film
where description like '%Documentary%';
-- 2nd
-- How many customers are there with a first name that is 3 letters long and either an X or a Y as the last letter in the last name
select count(*) from customer
where first_name like '___' and (last_name like '%X' or last_name like '%Y');


-- Comments and Aliases
/*
Multi line comment
*/


-- Final Challenges
-- 1.
select count(*) as number_of_movies from film
where description like '%Saga%'
and (title like 'A%' or title like '%R');


-- 2.
select first_name, last_name
from customer
where first_name like '%ER%' and first_name like '_A%'
order by last_name desc;

-- 3.
select count(*)
from payment
where (amount=0 or amount between 3.99 and 7.99)
and payment_date between '2020-05-01' and '2020-05-02';

-- ALTER DATABASE greencycles SET timezone TO 'Europe/Berlin';