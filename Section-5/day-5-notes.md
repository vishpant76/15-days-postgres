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
