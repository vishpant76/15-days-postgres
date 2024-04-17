### Section 2 - Day 2

- WHERE
- WHERE with AND/OR
- BETWEEN - Includes the lower and upper bound values in the result set. NOT BETWEEN - Does not include the lower and upper bound values in the result set.

- Using BETEWEEN with dates. Notice the date format.
```
select payment_id, amount
from payment
where payment_date between '2020-01-24' and '2020-01-26';
```

- NOTE: When we say `between '2020-01-24' and '2020-01-26'`, the upper bound date value is internally transformed into `'2020-01-26 00:00'`, i.e. until the midnight of 26th Jan, 2020. So unless there is a record where the date column is the midnight of 26th, all the records in the result set would be until 25th Date only. To get around this, we need to add some offset value depending on the requirement. So if you wanted the entire 26th Day data to be queried, you would use `between '2020-01-24' and '2020-01-27'` instead, but if you only wanted the data until the afternoon of 26th, you would use `between '2020-01-24' and '2020-01-26 12:00'`. Still some confusion around this based on the Coding Exercise 9. Also check out [CG reply](https://chat.openai.com/c/1383734c-fff9-440e-a627-966c08800975).

- Coding Exercise 10

![PV0dg4bKUs](https://github.com/vishpant76/15-days-postgres/assets/18080911/c36afe56-adf7-4b82-a0ee-86a33eae8451)

- Challenge 4 - a good one. There have been 6 complaints of customers about their payments. customer_ids specified in the query below. The concerned payments are all the payments of these customers with amounts as specified in the query below and in Jan 2020. Notice how we have used the upper bound as 1st Feb 2020 in the between clause for date. Because otherwise the 31st Jan records would not have come in the output had we used the upper bound 31-Jan.
```
select * from payment
where customer_id in (12, 25, 67, 93, 124, 234)
and
amount in (4.99, 7.99, 9.99)
and payment_date between '2020-01-01' and '2020-02-01';
```

- LIKE - pattern matching with wildcard characters. %, _ etc. ILIKE - to ignore case sensitivity?

- Challenge 5:  How many customers are there with a first name that is 3 letters long and either an X or a Y as the last letter in the last name?

```
select count(*) from customer
where first_name like '___' and (last_name like '%X' or last_name like '%Y');
```

An aliter for this would be to use ARRAY (`WHERE last_name ILIKE ANY (ARRAY['__x', '__Y']);`), but this is something I haven't explored yet. See [CG response](https://chat.openai.com/c/9cc548e4-d4fb-4793-a7fe-1845229740c0) for more info. Basically, this construct is particularly useful when you want to filter rows based on multiple possible values without having to write separate conditions for each value.

- Final challenges - the last question: How many payments are there where the amount is either 0 or is between 3.99 and 7.99 and the transaction happened on 2020-05-01. Notice how we have made use of `between` for the date.

```
select count(*)
from payment
where (amount=0 or amount between 3.99 and 7.99)
and payment_date between '2020-05-01' and '2020-05-02';
```

- [SQL for Day 2](https://github.com/vishpant76/15-days-postgres/blob/main/Section-2/day-2-sql.sql)
