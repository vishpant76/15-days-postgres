-- UNION
select first_name, 'actor' as origin from actor
UNION ALL
select first_name, 'customer' from customer
order by first_name;

-- Multiple Unions
select first_name, 'actor' as origin from actor
UNION ALL
select first_name, 'customer' as test1 from customer
UNION ALL
select first_name, 'staff' from staff
order by first_name;