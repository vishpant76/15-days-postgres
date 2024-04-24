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

/*
For the first part of the challenge we verified that there is at least a 1:1 correspondance between a seat in seats and being used via the boarding passes.  (That is, if a seat exists in seats it is used at least once in the boarding passes).

However, when you go to count up the most popular "lines" (A,B,C, etc...) the numbers you get far exceed the numbers in the boarding passes table.  There can't be more choices that have been made than the number of boarding passes processed.


As an example:

SELECT COUNT(*)

FROM boarding_passes

WHERE seat_no = '1A'



Gives me 5951

The below one:

SELECT

s.seat_no,

COUNT(*)

FROM seats s

LEFT JOIN boarding_passes bp

ON s.seat_no = bp.seat_no

WHERE s.seat_no = '1A'

GROUP BY s.seat_no

Should count all the occurrences of 1A in the merged table.  This gives me 53559 occurrences, but we have only 5951 boarding passes with 1A as the seat assignment!  What seems to be going on is we have multiple seat numbers of the same type (1A) for at least some of the aircraft codes, and the boarding_passes table only lists the seat number, which multiplies the seats of that type in the boarding_passes table:

SELECT COUNT(*)

FROM seats

WHERE seat_no = '1A'

(This is 9)

9*5951 from above = 53559 (Which is the number of seats I get back from the joined table)
*/

/*
Need to check the authenticity of the below:

select s.seat_no, count(*)



from seats as s

left join boarding_passes as b

on s.seat_no = b.seat_no

left join flights as f

on f.flight_id = b.flight_id



where s.aircraft_code = f.aircraft_code



group by s.seat_no

order by count(s.seat_no) desc


This would actually give you the correct results.
*/