-- Length, Lower, and upper
select lower(email) as email_lower, upper(email) as email_upper, email, length(email)
from customer;

-- Challenge 1
select * from customer;
select lower(first_name) first_name, lower(last_name) last_name, lower(email)
from customer
where length(first_name) > 10 or length(last_name) > 10;


-- LEFT() - to extract the text of a string starting from left side. 
select left(first_name, 2), first_name
from customer;

-- RIGHT() - starting from right side.
select right(first_name, 2), first_name
from customer;

-- If we want to extract from somewhere in the middle, we can nest left and right.
select right(left(first_name, 3), 1), first_name
from customer;

-- Challenge 2
select * from customer;
-- Extract the last 5 chars of the email.
select right(email, 5), email from customer;
-- extract just the dot (.) from the email address.
select left(right(email, 4), 1), email from customer;

-- Concatenate
select
left(first_name, 1) || '.' || left(last_name, 1),
first_name, last_name
from customer;

-- Challenge 3
-- Create anonymized version of email address
-- select * from customer;
select left(email, 1) || '***' || right(email, 19) as anonymized_email
from customer;

-- Position
select left(email, position('@' IN email)-1), email
from customer;

select left(email, position(last_name IN email)-2), email
from customer;

-- Challenge 4
-- Use only email address and the last name columns
-- EXtract the first name from the email address and concatenate it with the last name. Should be like: "Last Name, First name".
select last_name || ', ' || left(email, position('.' IN email) - 1) as "Last name, first name"
from customer;


-- SUBSTRING
-- SUBSTRING (string FROM start [for length])
-- POSITION('@' in email) - POSITION('.' in email)
select email,
substring(email from position('.' in email)+1 for POSITION('@' in email) - POSITION('.' in email) - 1)
from customer;


-- Challenge 5
-- Create anonymized form of the email address
-- part 1
select email, left(email, 1) || '***' || substring(email from position('.' in email) for 2) || '***' || substring(email from position('@' in email))
from customer;
-- part 2 - more complex
-- ***lastCharofFirstName.FirstCharOfLastName***@email.com
select '***' || substring(email from position('.' in email) - 1 for 3) || '***' || substring(email from position('@' in email))
from customer;

-- EXTRACT
select extract(day from rental_date), count(*)
FROM rental
group by extract(day from rental_date)
order by count(*) desc;

select extract(month from rental_date), count(*)
FROM rental
group by extract(month from rental_date)
order by count(*) desc;

-- Challenge 6
-- What's the month with the highest total payment amount?
select * from payment;
-- Below we are creating an alias 'month' for the extract result, and the same alias can be used in group by clause. It works because alias is evaluated before the group by gets evaluated.
-- Aliases allowed in GROUP BY but not in HAVING -- Need to understand the reason.
select extract(month from payment_date) as month, sum(amount)
from payment
group by month
order by sum(amount) desc;

-- What's the day of week with the highest total payment amount?
select extract(dow from payment_date), sum(amount)
from payment
group by extract(dow from payment_date)
order by sum(amount) desc;

-- What's the highest amount one customer has spent in a week?
select customer_id, extract(week from payment_date) as Week, sum(amount) as total_amt
from payment
group by Week, customer_id
order by total_amt desc;



-- To Char function
select *, extract(month from payment_date), TO_CHAR(payment_date, 'DD-MM-YY')
from payment;

select sum(amount), to_char(payment_date, 'Dy, Month, YYYY')
from payment
group by to_char(payment_date, 'Dy, Month, YYYY');


-- Challenge 7
-- Sum payments and group in the said format.
select sum(amount), to_char(payment_date, 'Dy, DD/MM/YYYY') as Day
from payment
group by Day;
-- 
select sum(amount), to_char(payment_date, 'Mon, YYYY') as Month
from payment
group by Month;
-- 
select sum(amount), to_char(payment_date, 'Dy, HH:MI') as Day
from payment
group by Day
order by sum(amount);


-- Intervals & Timestamps
select current_timestamp, current_timestamp - rental_date
from rental;

select current_timestamp,
extract(day from return_date-rental_date)*24 + extract(hours from return_date-rental_date) || ' hours'
from rental;

-- Challenge 8
-- Create list of all rental durations of customer with id 35
select * from rental;
select customer_id, return_date - rental_date as rental_duration
from rental
where customer_id = 35;

-- Which customer has the longest average rental duration?
select customer_id, avg(return_date-rental_date) as average
from rental
group by customer_id
order by average desc;