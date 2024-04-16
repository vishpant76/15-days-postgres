-- select * from actor;

-- select * from address;

-- select address, district
-- from address;

-- Day 1 Challenge 1
-- list of customers
select first_name, last_name, email
from customer;

-- Challenge 2
-- order by last name
select first_name, last_name, email
from customer
order by last_name desc, first_name desc;

select first_name, last_name, email
from customer
order by 2 desc, 1 desc;


-- DISTINCT
select distinct 
first_name, last_name
from actor
order by first_name;

select distinct rating from film;

-- distinct is across all of the selected columns
select distinct rating, rental_duration from film;


-- Challenge 3
select distinct amount from payment
order by amount desc;

-- LIMIT
-- Get the records having latest 10 rental dates
select * from rental
order by rental_date desc
limit 10;

-- COUNT
select count(*)
from rental;

-- COUNT in combination with DISTINCT
-- select count(first_name) from actor;
select
count (DISTINCT first_name)
from actor;

select count(distinct first_name) from customer;


-- DAY 1 more Challenges --
select distinct district from address;

-- latest rental date
select * from rental
order by rental_date desc
limit 1;

-- How many films
select count(*) from film;

-- How many distinct last names of the customers
select count(distinct last_name) from customer;