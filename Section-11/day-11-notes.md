### Day 11 - Window Functions

- [Window Functions](https://chat.openai.com/c/d09c4886-028d-46ae-991b-a91e8d9f2b7f) - Refer this discussion with CG. Some points:
    + No. of rows in the result set are not affected. i.e. unlike group by and other methods that change the rows after aggregation, with window function, the rows will be the same as earlier, but we can still aggregate the data and display it in an additional column for e.g. Similar to the correlated subquery use case in SELECT clause, but Window Functions are more powerful, performance and code complexity wise.
    + Use of OVER clause for the aggregated column.
  
  ![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/bc29ad83-4870-4193-81a7-e3432b0c7917)

  ---

- E.g of window functions: SUM(), COUNT(), RANK(), FIRST_VALUE(), LEAD(), LAG().

- General syntax:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/7d3b1983-c5f7-4983-b5b0-91bf1b3ff4b4)

---

- Some useful Questions added to anki deck.

- OVER() with ORDER BY: A good example of this usage is calculating running totals. Anki Card added. Refer [CG discussion](https://chat.openai.com/c/6cba7a91-e38a-4521-8db8-3f1e3d9b6266) for more.

- RANK() - An aggregate window function, ranking is created based on the particular ORDER.
- DENSE_RANK()
  
- Window Functions are not allowed in WHERE. It's because the Window function will be evaluated AFTER the WHERE clause. But we can use a subquery to do that.

- FIRST_VALUE() - see anki/SQL file for e.g.

- LEAD() - The value that comes afterwards, sort of like next value w.r.t to the current value of the column of the current row in a particular partition.

- LEAD, LAG challenge was pretty advanced. See SQL file and anki deck.

- [Day - 11 SQL](https://github.com/vishpant76/15-days-postgres/blob/main/Section-11/day-11-sql.sql).
