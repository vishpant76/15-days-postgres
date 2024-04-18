### Section 3 - Day 3

- Aggregate functions: SUM(), AVG(), MIN(), MAX(), COUNT(), ROUND(). E.g.: `round(avg(amount), 3)` - round off to 3 decimal digits.

- Coding Exercise 12: Aggregate Functions

![OAgSdwQZCZ](https://github.com/vishpant76/15-days-postgres/assets/18080911/f4a80190-f9cf-49bc-b769-4dba48cf9d9e)

---

- Group By - To **group** our aggregations **By** specific columns. Any column(s) not going inside aggregate functions, must be included in Group By.

- Exercise 13 - Group By. Don't get confused between COUNT() and SUM(), as you did in this exercise. Count will only count the number of transactions, i.e. number of records in each group; it won't calculate the sum of quantity in each group, hence sum(quantity) should be used here. Also refer to this [useful discussion](https://chat.openai.com/c/4728053a-7d79-4e8a-866b-033e88f56983) with CG. [Shared Link](https://chat.openai.com/share/06483faf-5f83-4137-925c-36e45e1b20e3)

![2sfjh2fPYi](https://github.com/vishpant76/15-days-postgres/assets/18080911/c4c7e493-e2a2-4d98-8b81-cdc3c25188e1)

---

- Challenge 2 - A good one - See the day-3-sql file for details. But this is a good e.g. that clears the difference between the usage of count() and sum().

```
select * from payment;
select staff_id, count(amount), sum(amount)
from payment
where amount != 0
group by staff_id
order by sum(amount) desc;
```

- Group By on Multiple columns: E.g - Which of the employees (staff_id) has had the highest amount of payments with one specific customer (customer_id). See [CG response](https://chat.openai.com/c/1eb62d9c-c543-4570-8618-db0d08c84fdf) for a more thorough interpretation.
```
select staff_id, customer_id, sum(amount), count(*)
from payment
group by staff_id, customer_id
order by count(*) desc;
```

- Coding Exercise 14 - Understand why count() and sum() were used here, and not max. Understanding the problem statement is the key. See SQL file for sql.

- HAVING - to filter GROUP BY aggregations.

- Coding Exercise 15 - Slightly tricky wording of the problem statement, but managed to figure it out.

![hRfphw08Au](https://github.com/vishpant76/15-days-postgres/assets/18080911/c564f617-06aa-4e1b-900a-b9b275da53ba)

---

- NOTE: Aggregate functions are not allowed in WHERE clause as they won't make any sense there..

- Challenge 4 - This was slightly more complicated but good for practice. Refer the SQL file for problem statement details.

```
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
```

- Second project introduced at this point in the Course - Flight Database. NOTE: Not adding the sql to git repo due to hits huge size. But check out the GDrive folder to get the sql if required in future.
