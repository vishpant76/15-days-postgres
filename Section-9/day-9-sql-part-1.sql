-- Section 9 - Day 9
-- Managing database and tables
create database company_y
	WITH encoding = 'UTF-8';

COMMENT ON DATABASE company_y IS 'That is our database';


-- enum
-- create type mppa_rating as enum ('G', 'PG', [...]);

-- ANY operator on Array data type
-- How many movies contain the special feature of 'Behind the Scenes'?
-- select * from film;
select count(*) from film where 'Behind the Scenes' = ANY(special_features);

-- Aliter
SELECT count(special_features)
FROM film
WHERE ARRAY_TO_STRING(special_features, ' ') ILIKE '%Behind%';