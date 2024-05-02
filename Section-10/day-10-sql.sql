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
-- select * from film_category;
-- select * from film;
-- select * from category;

-- begin;
create view films_category
as
select title, length, name
from film f
inner join film_category fc
on fc.film_id = f.film_id
inner join category c
on c.category_id = fc.category_id
where name in ('Action', 'Comedy')
order by length desc;
-- end;

-- select * from films_category;

-- Materialized View
create materialized view mv_films_category
as
select title, length, name
from film f
inner join film_category fc
on fc.film_id = f.film_id
inner join category c
on c.category_id = fc.category_id
where name in ('Action', 'Comedy')
order by length desc;


-- select * from mv_films_category;
-- let's make an update to the film table
update film
set length = 192
where title = 'SATURN NAME';

-- If we query the materialized view now, the update made above will not be reflected because we have not refreshed the materialized view yet!
REFRESH MATERIALIZED VIEW mv_films_category;

-- Now the changes will reflect in MV:
select * from mv_films_category;


-- Managing Views
CREATE or REPLACE VIEW <name>
as new_query

-- Challenge
-- First creating view:
CREATE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id;

select * from v_customer_info;

-- Rename the view to v_customer_information:
ALTER VIEW v_customer_info
RENAME TO v_customer_information;

-- Rename the customer_id column to c_id.
ALTER VIEW v_customer_information
RENAME column customer_id TO c_id;

select * from v_customer_information;

-- Add also the initial column as the last column to the view by replacing the view.

CREATE or REPLACE VIEW v_customer_information
AS
SELECT cu.customer_id as c_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country,
	concat(LEFT(cu.first_name,1), LEFT(cu.last_name,1)) as initials
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id;

-- IMPORT and EXPORT
-- First create the table where the data will be imported from the external source.
CREATE TABLE sales (
transaction_id SERIAL PRIMARY KEY,
customer_id INT,
payment_type VARCHAR(20),
creditcard_no VARCHAR(20),
cost DECIMAL(5,2),
quantity INT,
price DECIMAL(5,2));

select * from sales;

-- Now right-click on the table from the left pane and go to Import/Export data option, where you can import/export data from/to file.