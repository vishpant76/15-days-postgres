### Section 5 - Day 5 - Mathematical functions and Conditional Expressions

- Coding Exercise 18 - Got confused with this one... I tried with the below approach first, but it failed:
```
SELECT
  product_name,
  quantity_sold*price_per_unit AS total_revenue
FROM
  sales
GROUP BY
  product_name
ORDER BY
  SUM(quantity_sold*price_per_unit) desc
LIMIT
  1;
```
This will not work because, here we are using quantity_sold * price_per_unit to calculate total_revenue as an alias in the SELECT clause. Then, in the ORDER BY clause, we're attempting to use SUM(quantity_sold * price_per_unit), which tries to aggregate the already aggregated values. This usage is invalid because we're already using GROUP BY, which implies that each row in the result set represents an aggregated group. See [full explanation](https://chat.openai.com/share/23604882-5ff1-4839-b98a-03eb9b3d4062) from CG here.

The correct query: Use SUM in the SELECT statemenet itself:
```
SELECT
  product_name,
  sum(quantity_sold*price_per_unit) AS total_revenue
FROM
  sales
GROUP BY
  product_name
ORDER BY
  total_revenue desc
LIMIT
  1;
```
![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/e1dde813-09ea-44f8-b027-7312f0c76700)

---

- Challenge 1 was slightly tricky. Added to Anki for review. Check out sql in the file.

- CASE WHEN - very important. Similar to IF/WHEN. Syntax:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/d3c2286e-72e1-4dad-9d5d-0339ccfdc051)

--

- A very cool example of CASE usage. Notice how we have bundled the CASE conditions together and formed the is_Late column. Since we are using an aggregate function (count(*)), we then apply Group By over is_Late, which will give us the count of all the flights grouped by their late status (as defined in CASE WHEN statements).
```
SELECT
  COUNT(*) AS Flights,
  CASE
    WHEN actual_departure IS NULL THEN 'no departure time'
    WHEN actual_departure-scheduled_departure<'00:05' THEN 'On Time'
    WHEN actual_departure-scheduled_departure<'01:00' THEN 'A little bit late'
    ELSE 'Very Late'
  END AS is_Late
FROM
  flights
GROUP BY
  is_late;
```

- Coding Exercise 19: On CASE WHEN

![EYSznAOOvf](https://github.com/vishpant76/15-days-postgres/assets/18080911/3aad1a4c-3a39-4224-8ae0-10702f9081f8)

---

- CASE When - Challenge - Refer to the [Part 1 - SQL File](https://github.com/vishpant76/15-days-postgres/blob/main/Section-5/day-5-sql-part-1.sql) for the challenge details. The instructor's solution were slightly better. Note that in the last challenge, **in the WHERE clause, the entire CASE statement had to be used instead of the alias to remove the NULLs from the result set because WHERE is processed before the aliases so we must use the entire statement in WHERE if we want to apply that condition**.

- CASE WHEN with SUM: This is a technique called **pivoting the data using conditional aggregation**. Read more in [this discussion](https://chat.openai.com/share/11a4d79a-117f-456b-b487-5a95ad33cd0b) with CG. An e.g illustrated below. In the 1st query, we simply group the result by rating, i.e. each type of rating and its corresponding film count would be displayed as a row. But in the second data, each of these ratings are transformed into an individual column. So the output result will have only one row displaying the count of each type of ratings (which will be columns). Each CASE statement checks the condition for the specified rating; if it's found, it increments the count by 1 else 0. So this entire SUM result for each rating is grouped under a particular name, and the same is repeated for each case.
```
select rating, count(*)
from film
group by rating;

// Transforming the rows in the output of the above query into columns in the below query.
select
	sum(case when rating='NC-17' then 1 else 0 end) as "NC-17",
	sum(case when rating='PG-13' then 1 else 0 end) as "PG-13",
	sum(case when rating='PG' 	 then 1 else 0 end) as "PG",
	sum(case when rating='G' 	 then 1 else 0 end) as "G",
	sum(case when rating='R' 	 then 1 else 0 end) as "R"
from film;
```

- COALESCE() - Returns first value of a list of values which is not null. There is no fixed number of arguments; any number can be passed, the first non-null will be returned. `coalesce(actual_arrival, scheduled_arrival)`. In case we do not want to give the alternate value as the column name but a fixed value instead, it can be done, but note that the data type of the two must be the same. Like here, the actual_arrival is of timestamp data type, so if our second argument is going to be a fixed default value in case of NUll actual_arrival, then that fixed value should be of the timestamp data type as well. For e.g: `coalesce(actual_arrival, 1970-01-01 0:00)`.

- If we still want to change the datatype, we can use `CAST`. syntax: `CAST (value/column AS data type)`.
```
select coalesce(CAST(actual_arrival - scheduled_arrival AS VARCHAR), 'Not Arrived')
from flights;
```

- Note that CASTing to different data type may not always work. For e.g., if it's a character data type column that we want to CAST into integer; if there is whitespace between the characters in the column values, it will not get CASTed into integer. Similarly if the input string contains numbers, e.g. abc123, it can't be cast into INT.

- REPLACE() - Replaces text from a string in a column with another text. We can even replace some text with nothing, i.e. to remove that said text. `replace(column, old_text, new_text)`.

- Using REPLACE with CAST. This is useful when we want to CAST a column containing a mix of characters and numbers into INT for e.g. We could remove the characters from the column using REPLACE, and then cast the result to INT. Of course this depends on whether our requirement is actually to remove those characters, but just to demonstrate a use case.

```
select
cast(replace(flight_no, 'PG', '') AS INT)
from flights;
```

- [Day 5 - SQL-1](https://github.com/vishpant76/15-days-postgres/blob/main/Section-5/day-5-sql-part-1.sql) and [Day 5 - SQL-2](https://github.com/vishpant76/15-days-postgres/blob/main/Section-5/day-5-sql-part-2.sql).
