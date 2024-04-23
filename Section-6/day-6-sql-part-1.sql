-- Day 6 - JOINS
-- INNER JOIN
-- select * from customer
select * from payment p
inner join customer c
on p.customer_id = c.customer_id;

-- syntax for selecting all columns from payment table but only first name and lastname columns from the payment table.
select payment.*,
first_name,
last_name	
from payment
inner join customer c
on payment.customer_id = c.customer_id;


select payment.*, first_name, last_name, email
from payment
inner join staff
on staff.staff_id = payment.staff_id
where staff.staff_id=1;

-- Challenge 1
-- How many people choose seats in the category: Business, Economy, or Comfort?
select * from seats;
select * from boarding_passes;
select count(*) from boarding_passes;

-- Below is the WRONG approach! Which is also what instructor has used...
-- select fare_conditions, count(*)
-- from seats
-- inner join boarding_passes
-- on seats.seat_no = boarding_passes.seat_no
-- group by fare_conditions;

-- THIS IS THE CORRECT SOLUTION
select * from flights;
select fare_conditions, count(*)
from boarding_passes bp
inner join flights f
on bp.flight_id = f.flight_id
inner join seats s
on f.aircraft_code = s.aircraft_code AND s.seat_no = bp.seat_no
group by fare_conditions;

-- OUTER JOIN
select * from boarding_passes b
full outer join tickets t
on b.ticket_no = t.ticket_no;

-- Find the tickets that don't have a boarding pass related to it.
-- select * from tickets where ticket_no ='0005434319673';
-- select * from boarding_passes where ticket_no='0005434319673';
select * from boarding_passes b
full outer join tickets t
on b.ticket_no = t.ticket_no
where b.ticket_no is null;


-- LEFT OUTER JOIN
select * from aircrafts_data a
LEFT JOIN flights f
ON a.aircraft_code = f.aircraft_code;
-- select * from flights;
-- Find all aircrafts that have not been used in any flights.
select * from aircrafts_data a
LEFT JOIN flights f
ON a.aircraft_code = f.aircraft_code
where f.aircraft_code is null;

-- Challenge - Which seat has been chosen most frequently? All seats should be included even if they have never been chosen before. Are there seats that have never been booked before?
-- select * from seats;
-- select * from bookings;
-- select * from boarding_passes;
-- Again, the solutions here are fishy... Take the two SQL below with a grain of salt.
select s.seat_no, count(*) from seats s
LEFT JOIN boarding_passes b
ON s.seat_no = b.seat_no
-- where b.seat_no is null
group by s.seat_no
order by count(*) desc;

-- Challenge - 2nd part
select RIGHT(s.seat_no, 1), count(*) from seats s
LEFT JOIN boarding_passes b
ON s.seat_no = b.seat_no
group by RIGHT(s.seat_no, 1)
order by count(*) desc;

-- 