-- Day 14 - User defined functions
-- Using PL/PgSQL
/*
Create a user defined function that calculates/counts the number of films that are within a specific range of the rental_rate.
*/
create function count_rr(min_r decimal(4,2), max_r decimal(4,2))
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE
movie_count INT;
BEGIN
SELECT COUNT(*)
INTO movie_count
from film
where rental_rate BETWEEN min_r AND max_r;
RETURN movie_count;
END;
$$

select count_rr(3,6);


-- Challenge - Create a function that expects the customer's first and last name and returns the total amount of payments this customer has made.  

-- select c.customer_id, first_name, last_name, sum(amount)
-- from customer c
-- inner join payment p
-- on c.customer_id = p.customer_id
-- group by c.customer_id, first_name, last_name
-- order by 2;

create or REPLACE function get_total_amount(firstName text, lastName text)
RETURNS DECIMAL(5,2)
LANGUAGE plpgsql
AS
$$
DECLARE
total_amount DECIMAL(5,2);
BEGIN
select sum(amount)
INTO total_amount
from customer c
left join payment p
on c.customer_id = p.customer_id
group by c.customer_id
HAVING first_name=firstName AND last_name=lastName;
RETURN total_amount;
END;
$$

select get_total_amount('CECIL', 'VINES');

-- EXperimenting with the above function by creating it without any DECLARE - it works.
create or REPLACE function get_total_amount_v2(firstName text, lastName text)
RETURNS DECIMAL(6,2)
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN (select sum(amount)
from customer c
inner join payment p
on c.customer_id = p.customer_id
group by c.customer_id
HAVING first_name=firstName AND last_name=lastName);
END;
$$

select get_total_amount_v2('DANNY', 'ISOM');

-- We can even use the user-defined functions directly in a SQL!!
SELECT first_name, last_name, get_total_amount(first_name, last_name)
from customer
-- order by 1;


