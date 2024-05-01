-- Section 10 - Day 10
-- Update
-- select * from customer
-- order by customer_id;
UPDATE customer
set last_name = 'BROWN'
WHERE customer_id = 1;

-- Make all emails in email column lowercase
UPDATE customer
SET email = lower(email);

-- Challenge
-- Update all rental prices that are 0.99 to 1.99
-- Alter the customer table:
-- Add the column 'intials' (varchar(10))
-- update the values to the actual initials for e.g. Frank Smith should be F.S.
-- select * from film;
UPDATE film
set rental_rate = 1.99
where rental_rate = 0.99;

ALTER TABLE customer
ADD COLUMN initials varchar(4)

BEGIN;
UPDATE customer
set initials = LEFT(first_name,1) || '.' || LEFT(last_name,1) || '.';
commit;

-- DELETE
-- select * from songs;
-- insert into songs(song_name, genre, price, release_date)
-- values
-- ('qwerty me', 'Pop', 4.99, '01-05-2023'),
-- ('always me', 'Rock', 5.99, '01-05-1999');

delete from songs
where genre = 'Jazz';

delete from songs
where song_id in (4,5)
returning song_id, song_name;

-- DELETE - Challenge - Delete the rows in the payment table with ID 17064 and 17067
-- select * from payment
-- where payment_id in (17064, 17067);
-- begin;
delete from payment
where payment_id in (17064, 17067)
returning *;
-- rollback;
-- commit;

-- CREATE TABLE AS
create table customer_address
as
select first_name, last_name, email, address, city
from customer c
left join address a
on c.address_id = a.address_id
left join city ci
on ci.city_id = a.city_id;

-- select * from customer_address;

-- Challenge - Create As
-- Create a table with the first name and last name of the customer in single column, and their total spendings that they have done in the payments table.
select * from customer;
select * from payment;

begin;
create table customer_spendings
as
select first_name || ' ' || last_name as name, sum(amount) from customer c
left join payment p
on c.customer_id = p.customer_id
group by first_name, last_name
order by 1,2;
-- rollback;

select * from customer_spendings;


-- VIEWS
-- We DROP the table customer_spendings above and create a VIEW instead.
-- DROP table customer_spendings;
begin;
create VIEW customer_spendings
as
select first_name || ' ' || last_name as name, sum(amount) from customer c
left join payment p
on c.customer_id = p.customer_id
group by first_name, last_name
order by 1,2;
commit;

select * from customer_spendings;


-- VIEW - Challenge
-- Create a view called films_category that shows a list of the film titles including their title, length and category name ordered descendingly by the length.
-- Filter the results to only the movies in the category 'Action' and 'Comedy'.
