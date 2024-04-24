-- RIGHT JOIN
-- This will return those aircrafts that have not been used in a flight.
select * from aircrafts_data a
left join flights f
on a.aircraft_code = f.aircraft_code
where f.aircraft_code is null;
-- But if we change it to right join, we won't get anything. Because it's like saying an aircraft was used in a flight but there is no record of it in aircrafts_data!
select * from aircrafts_data a
right join flights f
on a.aircraft_code = f.aircraft_code
where f.aircraft_code is null;

-- But if we change the positions, then we get results, which is again sort of similar to the first query that used left join, just that the result their were on the left side, but here they are on the right side.
select * from flights f
right join aircrafts_data a
on a.aircraft_code = f.aircraft_code
where f.aircraft_code is null;

-- Challenge: What are the customers (first_name, last_name, ph number and their district) from Texas ? 
-- select * from customer;
-- select * from address;
select first_name, last_name, phone, district
from customer c
left join address a
on c.address_id = a.address_id
where a.district='Texas';

-- Are there any old addresses that are not related to any customer?
select first_name, last_name, address, phone, district
from customer c
right join address a
on c.address_id = a.address_id
where c.address_id is null;

-- Aliter for above:
select * from address a
left join customer c
on c.address_id = a.address_id
where c.customer_id is null;