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


-- TRANSACTIONS
CREATE TABLE acc_balance (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
	  last_name TEXT NOT NULL,
    amount DEC(9,2) NOT NULL    
);

INSERT INTO acc_balance
VALUES 
(1,'Tim','Brown',2500),
(2,'Sandra','Miller',1600)

SELECT * FROM acc_balance;

-- Begin transaction
BEGIN;
UPDATE acc_balance
SET amount = amount - 100
where id = 1;
COMMIT;


-- The two employees Miller McQuarter and Christalle McKenny have agreed to swap their positions incl. their salary.
select * from employees;

BEGIN;
UPDATE employees
SET position_title = 'Head of Sales'
WHERE emp_id=2;
UPDATE employees
SET position_title = 'Head of BI'
WHERE emp_id=3;
UPDATE employees
SET salary = 12587.00
WHERE emp_id=2;
UPDATE employees
SET salary = 14614.00
WHERE emp_id=3;
COMMIT;

-- A better way to write the above. This time, reverting the changes made earlier.
BEGIN;
UPDATE employees
SET 
    position_title = CASE 
                        WHEN emp_id = 3 THEN 'Head of Sales'
                        WHEN emp_id = 2 THEN 'Head of BI'
                        ELSE position_title 
                    END,
    salary = CASE 
                WHEN emp_id = 3 THEN 12587.00
                WHEN emp_id = 2 THEN 14614.00
                ELSE salary
             END
WHERE emp_id IN (2, 3);
COMMIT;


-- ROLLBACK
select * from acc_balance;
BEGIN;
UPDATE acc_balance
SET amount = amount - 100
WHERE id = 2;
SAVEPOINT s1;
DELETE FROM acc_balance
WHERE id=1;
-- ROLLBACK;
ROLLBACK to SAVEPOINT s1;
COMMIT;
RELEASE SAVEPOINT s1;
COMMIT;


-- STORED PROCEDURE
-- select * from acc_balance;
CREATE OR REPLACE PROCEDURE sp_transfer
(tr_amount INT, sender INT, recepient INT)
LANGUAGE plpgsql
AS
$$
DECLARE sender_bal INT;
BEGIN
select amount INTO sender_bal from acc_balance where id = sender;

IF tr_amount < sender_bal
THEN
-- add balance 
UPDATE acc_balance
SET amount = amount + tr_amount
WHERE id = recepient;
-- subtract balance
UPDATE acc_balance
SET amount = amount - tr_amount
WHERE id = sender;
COMMIT;

ELSE
  RAISE NOTICE 'Sender balance % is lower than the transfer amount', sender_bal;
END IF;
END;
$$

CALL sp_transfer(101, 1, 2);


-- Challenge
-- Create a stored procedure called emp_swap that accepts two parameters emp1 and emp2 as input and swaps the two employees' position and salary.
CREATE or REPLACE PROCEDURE emp_swap
(emp1 INT, emp2 INT)
LANGUAGE plpgsql
AS
$$
DECLARE
pos1 text;
pos2 text;
sal1 NUMERIC(8,2);
sal2 NUMERIC(8,2);

BEGIN
SELECT position_title, salary INTO pos1, sal1 from employees where emp_id=emp1;
SELECT position_title, salary INTO pos2, sal2 from employees where emp_id=emp2;

UPDATE employees
SET
    position_title = CASE
                        WHEN emp_id = emp1 THEN pos2
                        WHEN emp_id = emp2 THEN pos1
                        ELSE position_title
                     END,
    salary = CASE
                WHEN emp_id = emp1 THEN sal2
                WHEN emp_id = emp2 THEN sal1
                ELSE salary
             END

WHERE emp_id IN (emp1, emp2);
COMMIT;
END;
$$

select * from employees;
CALL emp_swap(20,21);