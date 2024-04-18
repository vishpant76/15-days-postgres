-- DAY 3
-- GROUPING

SELECT SUM(AMOUNT)
FROM PAYMENT;


SELECT AVG(AMOUNT)
FROM PAYMENT;

-- Multiple aggregate functions can be used in single select statement. But you can't use an aggregate function along with a column without aggregate function.

SELECT SUM(AMOUNT),
	ROUND(AVG(AMOUNT),
		3)
FROM PAYMENT;

-- Challenge 1
-- Find out min, max, avg rounded, and sum of the replacement cost of the films.

SELECT MIN(REPLACEMENT_COST) AS MINIMUM,
	MAX(REPLACEMENT_COST) AS MAXIMUM,
	ROUND(AVG(REPLACEMENT_COST),
		2) AS AVERAGE,
	SUM(REPLACEMENT_COST) AS SUM
FROM FILM;

-- Group by

SELECT CUSTOMER_ID,
	MAX(AMOUNT),
	SUM(AMOUNT)
FROM PAYMENT
GROUP BY CUSTOMER_ID -- order by customer_id;
ORDER BY SUM(AMOUNT) DESC;

-- Challenge 2
-- Which of the two employees (staff_id) is responsible for more payments?
-- Which of the two is responsible for a higher overall payment amount?
-- How do these amounts change if we don't consider amounts equal to 0?

SELECT *
FROM PAYMENT;


SELECT STAFF_ID,
	COUNT(AMOUNT),
	SUM(AMOUNT)
FROM PAYMENT
WHERE AMOUNT != 0
GROUP BY STAFF_ID
ORDER BY SUM(AMOUNT) DESC;

-- Group by Multiple columns
-- Which of our employees has had the highest amount of payments with one specific customer.
-- So this means, within each group belonging to a particular staff_id, we need to find the customer_id with which the highest amount of payment was transacted. So we have to consider both the staff_id and the customer_id.

SELECT STAFF_ID,
	CUSTOMER_ID,
	SUM(AMOUNT),
	COUNT(*)
FROM PAYMENT
GROUP BY STAFF_ID,
	CUSTOMER_ID
ORDER BY COUNT(*) DESC;

-- EXtracting Date as a separate column from the timestamp

SELECT *,
	DATE(PAYMENT_DATE)
FROM PAYMENT;

-- Challenge 3
-- WHich employee had the highest sales amount in a single day?
-- select staff_id, max(amount), date(payment_date)
-- from payment
-- group by staff_id, date(payment_date)
-- order by max(amount) desc;

SELECT STAFF_ID,
	SUM(AMOUNT),
	DATE(PAYMENT_DATE)
FROM PAYMENT
GROUP BY STAFF_ID,
	DATE(PAYMENT_DATE)
ORDER BY SUM(AMOUNT) DESC;

-- WHich employee had the most sales in a single day? Not considering the amount=0 case.

SELECT STAFF_ID,
	COUNT(*),
	DATE(PAYMENT_DATE)
FROM PAYMENT
WHERE AMOUNT != 0
GROUP BY STAFF_ID,
	DATE(PAYMENT_DATE)
ORDER BY COUNT(*) DESC;

-- HAVING

SELECT STAFF_ID,
	COUNT(*),
	SUM(AMOUNT),
	DATE(PAYMENT_DATE)
FROM PAYMENT
WHERE AMOUNT != 0
GROUP BY STAFF_ID,
	DATE(PAYMENT_DATE)
HAVING COUNT(*) > 400
ORDER BY COUNT(*) DESC;

-- Challenge 4
-- In 2020, April 28, 29 and 30 were days with very high revenue, that's why we focus in this task on these days (filter accordingly).
-- What is the average payment amount grouped by customer and day - consider only the days/customers with more than 1 payment (per customer and day).
-- Order by average amount in descending order.

SELECT *
FROM PAYMENT;


SELECT CUSTOMER_ID,
	DATE(PAYMENT_DATE),
	ROUND(AVG(AMOUNT),
		2) AS AVG_AMT,
	COUNT(*)
FROM PAYMENT
WHERE DATE(PAYMENT_DATE) BETWEEN '2020-04-28' AND '2020-05-01'
GROUP BY CUSTOMER_ID,
	DATE(PAYMENT_DATE)
HAVING COUNT(*) > 1
ORDER BY ROUND(AVG(AMOUNT)) DESC;

