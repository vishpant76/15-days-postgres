-- Section 9 - Day 9
-- Managing database and tables
create database company_y
	WITH encoding = 'UTF-8';

COMMENT ON DATABASE company_y IS 'That is our database';


-- enum
-- create type mppa_rating as enum ('G', 'PG', [...]);

-- ANY operator on Array data type
-- How many movies contain the special feature of 'Behind the Scenes'?
-- select * from film;
select count(*) from film where 'Behind the Scenes' = ANY(special_features);

-- Aliter
SELECT count(special_features)
FROM film
WHERE ARRAY_TO_STRING(special_features, ' ') ILIKE '%Behind%';

-- Create Table

create table director (
director_id serial primary key,
director_account_name varchar(20) unique,
first_name varchar(50),
last_name varchar(50) DEFAULT 'Not Specified',
date_of_birth DATE,
address_id INT REFERENCES address(address_id));

-- INSERT INTO
insert into online_sales(transaction_id, customer_id, film_id, amount, promotion_code)
values (1, 124, 65, 14.99, PROMO2022), (2, 225, 231, 12.99, JULYPROMO),
(3, 119, 53, 15.99, SUMMERDEAL);


-- Alter Table

create table director (
director_id serial primary key,
director_account_name varchar(20) unique,
first_name varchar(50),
last_name varchar(50) DEFAULT 'Not Specified',
date_of_birth DATE,
address_id INT REFERENCES address(address_id));
-- Challenges
/*
1. director_account_name to VARCHAR(30)
2. drop the default on last_name
3. add the constraint not null to last name
4. add the column email of data type VARCHAR(40)
5. rename the director_account_name to account_name
6. rename the table from director to directors
*/
select * from directors;
ALTER TABLE DIRECTOR
ALTER COLUMN director_account_name TYPE VARCHAR(30),
ALTER COLUMN last_name DROP DEFAULT,
ALTER COLUMN last_name SET NOT NULL,
ADD COLUMN email VARCHAR(40);

ALTER TABLE director
RENAME director_account_name TO account_name

ALTER TABLE director
RENAME TO directors

-- DROP and Truncate
-- create temp table
create table emp_table
(
	emp_id serial primary key,
	emp_name text
)
select *  from emp_table;

-- Now drop table
drop table emp_table;

-- Recreate the table and then insert few rows
insert into emp_table
values (1,'Frank'), (2,'Mary');

-- Now truncate table
truncate table emp_table;


-- CHECK constraint
-- Challenge - See notes.md for details
create table songs(
song_id serial primary key,
song_name varchar(30) not null,
genre varchar(30) default 'Not Define',
price numeric(4,2) check(price >= 1.99),
release_date DATE constraint date_check	CHECK(release_date BETWEEN '01-01-1950' AND current_date));

select * from songs;

insert into songs (song_name, price, release_date)
values ('SQL song', 0.99, '01-07-2022');

ALTER TABLE songs
DROP constraint songs_price_check;

ALTER TABLE songs
ADD CONSTRAINT songs_price_check check(price >= 0.99)