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

