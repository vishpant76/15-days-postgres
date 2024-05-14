-- Day 15
-- Create users
CREATE USER sarah
WITH PASSWORD 'sarah1234';

CREATE ROLE alex
WITH LOGIN PASSWORD 'alex1234';

-- After creating with above, we connected to greencycles using alex user credentials. However, trying to do SELECT * from on any tables would not work due to permission denied error. It is also not possilble to create objects such as CREATE TABLE from version 15 onwards, although it was possible in older versions. See https://github.com/vishpant76/15-days-postgres/edit/main/Section-15/day-15-notes.md for details.
-- CREATE Table test_table(id SERIAL);

-- So, let's grant user 'alex' the necessary permission from our superuser 'vishvon'.
GRANT ALL ON SCHEMA public TO alex;

-- Now try again under 'alex', now the CREATE will work.
CREATE Table test_table(id SERIAL);

select * from test_table;

-- More examples of user/role creation
CREATE USER ria
WITH PASSWORD 'ria123';

CREATE USER mike
WITH PASSWORD 'mike123';

-- Create roles
create ROLE read_only;
CREATE ROLE read_update;

-- grant usage
GRANT USAGE
ON SCHEMA PUBLIC
to read_only;

-- Grant SELECT on tables
GRANT SELECT
ON ALL TABLES IN SCHEMA PUBLIC
TO read_only;


-- 
GRANT read_only to mike;

-- Querying customer table under user mike:
SELECT * FROM customer;

-- But if we were to delete something, it wouldn't work as mike currently doesn't have that permission
delete from customer
where customer_id = 8;


-- Grant read_only to read_update role
GRANT read_only
TO read_update;

-- Grant all privileges on all tables in public to read_update role
GRANT ALL
ON ALL TABLES IN SCHEMA public
TO read_update;

-- Revoke some privileges
REVOKE DELETE, INSERT
ON ALL TABLES IN SCHEMA PUBLIC
FROM read_update;

-- Assign role to users
GRANT read_update
TO ria;


-- Under the user 'ria', we should now be able to UPDATE the data, but NOT delete it since we revoked delete privileges.
-- select * from customer
-- where first_name ILIKE 'mar%';
delete from customer
where customer_id = 5;

-- updating
update customer
SET first_name = 'MARIE'
where first_name = 'MARY';


-- DROP roles
DROP ROLE mike;

-- Some roles may not get dropped because certain objects depend on them.
DROP ROLE read_update;

-- In such case we have to first drop those dependencies.
DROP OWNED BY read_update;
-- And then try dropping the role again
DROP ROLE read_update;

/*
Challenge:
Create the user mia with password 'mia123'
Create  the role analyst_emp;
Grant SELECT on all tables in the public schema to that role.
Grant INSERT and UPDATE on the employees table to that role.
Add the permission to create databases to that role.
Assign that role to mia and test the privileges with that user.
*/
CREATE USER mia
WITH PASSWORD 'mia123';

CREATE ROLE analyst_emp;

GRANT SELECT 
ON ALL TABLES IN SCHEMA PUBLIC
TO analyst_emp;

GRANT INSERT,UPDATE
ON employees
TO analyst_emp;

ALTER ROLE analyst_emp CREATEDB;

GRANT analyst_emp TO mia;


-- Using Indexes
-- Consider the below Correlated subquery that takes a long time to prcess.
-- NOTE: It's taking time when run on PgAdmin, but not on VSCode, which is strange...

SELECT
(SELECT avg(amount)
from payment p2
where p2.rental_id = p1.rental_id)
from payment p1;

-- Since rental_id is being used as a filter column, we can create an index on it to improve the performance of our query.

CREATE INDEX index_rental_id_payment
ON payment
(rental_id)


-- Assignment/Challenge
/*
Execute the following query:
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   )
This query has a very bad performance.
Test indexes on different columns and compare their performance.
Also considder an index on multiple columns.
Questions for this assignment
On which column(s) would you place an index to get the best performance in the query?
*/

SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   );

create index index_departure_airport
ON flights(departure_airport, flight_no);

drop index index_departure_airport;
