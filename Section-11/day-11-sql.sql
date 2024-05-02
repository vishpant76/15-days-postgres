-- Section 11 - Day 11 - WIndow Functions
-- select * from payment;
select *, SUM(amount) OVER(PARTITION BY customer_id)
from payment;

-- COUNT
-- This will show us how many transactions there were per customer.
select *, count(*) OVER(PARTITION BY customer_id)
from payment;

-- We can even partition by multiple columns
-- How many sales occurred for each staff ID per customer:
select *, SUM(amount) OVER(PARTITION BY customer_id, staff_id)
from payment;

-- Using COUNT without any Paritition By
select *, count(*) OVER() 
FROM payment
order by 1;

-- Using ROUND with Avg when used as window function:
select *, round(avg(amount) over(), 2)
from payment
order by 1;