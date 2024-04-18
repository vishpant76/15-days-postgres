### Section 3 - Day 3

- Aggregate functions: SUM(), AVG(), MIN(), MAX(), COUNT(), ROUND(). E.g.: `round(avg(amount), 3)` - round off to 3 decimal digits.

- Coding Exercise 12: Aggregate Functions

![OAgSdwQZCZ](https://github.com/vishpant76/15-days-postgres/assets/18080911/f4a80190-f9cf-49bc-b769-4dba48cf9d9e)

---

- Group By - To **group** our aggregations **By** specific columns. Any column(s) not going inside aggregate functions, must be included in Group By.

- Exercise 13 - Group By. Don't get confused between COUNT() and SUM(), as you did in this exercise. Count will only count the number of transactions, i.e. number of records in each group; it won't calculate the sum of quantity in each group, hence sum(quantity) should be used here. Also refer to this [useful discussion](https://chat.openai.com/c/4728053a-7d79-4e8a-866b-033e88f56983) with CG. [Shared Link](https://chat.openai.com/share/06483faf-5f83-4137-925c-36e45e1b20e3)

![2sfjh2fPYi](https://github.com/vishpant76/15-days-postgres/assets/18080911/c4c7e493-e2a2-4d98-8b81-cdc3c25188e1)

---

- 
