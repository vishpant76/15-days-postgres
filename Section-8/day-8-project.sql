-- DAY - 8 - MID COURSE PROJECT - Solve the 14 Challenges

-- Challenge 1
/*
Level: Simple
Topic: DISTINCT
Task: Create a list of all the different (distinct) replacement costs of the films.
Question: What's the lowest replacement cost?
Answer: 9.99
*/
-- select * from film;
select distinct(replacement_cost) from film
order by replacement_cost;

-- Challenge 2
/*
Level: Moderate
Topic: CASE + GROUP BY
Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges
low: 9.99 - 19.99
medium: 20.00 - 24.99
high: 25.00 - 29.99
Question: How many films have a replacement cost in the "low" group?
Answer: 514
*/
-- select replacement_cost from film order by 1;
select count(*),
case
	when replacement_cost<=19.99 then 'low'
	when replacement_cost<=24.99 then 'medium'
	when replacement_cost<=29.99 then 'high'
end as cost_range
from film
group by cost_range;

-- Challenge 3
/*
Level: Moderate
Topic: JOIN
Task: Create a list of the film titles including their title, length, and category name ordered descendingly by length. Filter the results to only the movies in the category 'Drama' or 'Sports'.
Question: In which category is the longest film and how long is it?
Answer: Sports and 184
*/
-- select * from film;
-- select * from film_category;
-- select * from category;

select title, length, name
from film f
left join film_category fi
on f.film_id = fi.film_id
left join category c
on fi.category_id = c.category_id
where name in ('Drama' , 'Sports')
order by 2 desc;

-- Challenge 4
/*
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of how many movies (titles) there are in each category (name).
Question: Which category (name) is the most common among the films?
Answer: Sports with 74 titles
*/
select name, count(*)
from film f
left join film_category fi
on f.film_id = fi.film_id
left join category c
on fi.category_id = c.category_id
group by name
order by 2 desc;

-- Challenge 5
/*
Level: Moderates
Topic: JOIN & GROUP BY
Task: Create an overview of the actors' first and last names and in how many movies they appear in.
Question: Which actor is part of most movies??
Answer: Susan Davis with 54 movies
*/
-- select * from actor;
-- select * from film_actor;
-- select * from film;

select first_name, last_name, count(*)
from actor a
left join film_actor f
on a.actor_id = f.actor_id
left join film fi
on f.film_id = fi.film_id
group by first_name, last_name
order by 3 desc;

-- Challenge 6
/*
Level: Moderate
Topic: LEFT JOIN & FILTERING
Task: Create an overview of the addresses that are not associated to any customer.
Question: How many addresses are that?
Answer: 4
*/
-- select * from customer;
-- select * from address;
select customer_id, first_name, last_name, a.address_id, address
from address a
left join customer c
on a.address_id = c.address_id
where customer_id is null;

-- Challenge 7
/*
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create the overview of the sales to determine the from which city (we are interested in the city in which the customer lives, not where the store is) most sales occur.
Question: What city is that and how much is the amount?
Answer: Cape Coral with a total amount of 221.55
*/
-- select * from sales;
-- select * from customer;
-- select * from address;
-- select * from city;

-- WRONG RESULT!
select city, sum(price)
from customer cu
inner join sales s
on cu.customer_id = s.customer_id
inner join address a
on a.address_id = cu.address_id
inner join city ci
on ci.city_id = a.city_id
group by city
order by 2 desc
limit 1;