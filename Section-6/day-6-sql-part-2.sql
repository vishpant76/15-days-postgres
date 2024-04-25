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


-- SELECT *
-- FROM information_schema.columns
-- WHERE table_name = 'ticket_flights';

-- Joins on multiple conditions
-- select * from ticket_flights;
-- select * from boarding_passes;
-- Get the average price (amount) for the different seat_no. Using inner join here, but this could probably also be solved with LEFT JOIN as instructor showed in video. But wonder how the null records would influence the average?
select seat_no, round(avg(amount), 2)
from ticket_flights t
inner join boarding_passes b
on t.ticket_no=b.ticket_no AND t.flight_id=b.flight_id
group by seat_no
order by 2 desc;


-- JOINING MULTIPLE TABLES
-- We want to have passenger name, and scheduled departure in the data.	
select * from tickets;
select * from flights;
select * from ticket_flights;
select * from boarding_passes;

-- select ticket_no, passenger_name, scheduled_departure, scheduled_arrival
select t.ticket_no, tf.flight_id, t.passenger_name, f.scheduled_departure, f.scheduled_arrival from tickets t
inner join ticket_flights tf
on t.ticket_no = tf.ticket_no
inner join flights f
on f.flight_id = tf.flight_id;

-- Challenge
-- Which customers are from Brazil? Get the first, lastname, email, country for all customers of Brazil.
select * from customer where address_id is null;
-- select * from address;
-- select * from country;
-- select * from city;

select first_name, last_name, email, country from customer c
inner join address a
on a.address_id = c.address_id
inner join city ci
on ci.city_id = a.city_id
inner join country co
on co.country_id = ci.country_id
where country='Brazil';

-- ALITER for above: Using LEFT JOIN - to ensure that we have all customers.
select first_name, last_name, email, country from customer c
left join address a
on a.address_id = c.address_id
left join city ci
on ci.city_id = a.city_id
left join country co
on co.country_id = ci.country_id
where country='Brazil';