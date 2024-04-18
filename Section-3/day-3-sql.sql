-- DAY 3
-- GROUPING
select sum(amount)
from payment;

select avg(amount)
from payment;

-- Multiple aggregate functions can be used in single select statement. But you can't use an aggregate function along with a column without aggregate function. 
select sum(amount), round(avg(amount), 3)
from payment;

-- Challenge 1
-- Find out min, max, avg rounded, and sum of the replacement cost of the films.
select * from film;
select min(replacement_cost) as Minimum, max(replacement_cost) as Maximum,
		round(avg(replacement_cost), 2) as Average, sum(replacement_cost) as Sum
from film;