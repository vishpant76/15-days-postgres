### Day 7 - UNION and Subqueries

- UNION - combining multiple SELECT statements. Combining rows. Three things to remember:
    + How columns are matched? Columns are NOT matched by their names, but by their order. Even if the first column of one table has a name different from the first column of the second table, as long as they are in the same order, they would match. If the names of columns are different, the first table's column's name will be used in the result set.
    + So it's important that the tables being combined via UNION, have their columns mentioned in the same order in the query (the data types must match). Number of columns must match.
    + If there are duplicates, only one record will be there in the result. However, if we want to keep all records from both tables, including all duplicate rows, we can use `UNION ALL`.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/b7792b86-4fdd-4da1-b900-a898a3025c78)

---

- Subqueries in WHERE: Refer the challenges in file [day-7-sql-part-1](https://github.com/vishpant76/15-days-postgres/blob/main/Section-7/day-7-sql-part-1.sql).

- Subqueries in FROM and SELECT: Refer the challenges in file [day-7-sql-part-2](https://github.com/vishpant76/15-days-postgres/blob/main/Section-7/day-7-sql-part-2.sql). Also added to Anki deck.

- Correlated Subqueries: Subquery gets evaluated for every single row. Subquery does not work independently. Because we are referencing our outer query in the WHERE clause of subquery (e1.city=e2.city).

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/8d19b593-07d6-468a-ae76-62c37a81af7f)

---

- [More explanation on working of Correlated Subqueries](https://chat.openai.com/c/53644251-09a3-49a8-88bb-4c931dd1422e). [Shared Link](https://chat.openai.com/share/1b294a2d-a989-47f0-a274-9e185d657990)

- Correlated subqueries can't be used in FROM clause, but can be used in WHERE and SELECT clause. Check out the SQL files in Day 7 for challenges.

- The Third Challenge in the video "Solution: More Challenges" in Day 7 has confusing wording. The problem asked for the "highest payment amount for each customer's first name", but in solution the instructor used the condition on customer_id instead of first_name.

```
select c1.customer_id, c1.first_name, p1.payment_id, amount
from customer c1
inner join payment p1
on p1.customer_id = c1.customer_id
where amount = (select max(amount) from payment p2
			   where p1.customer_id=p2.customer_id)
order by 1;
```

- [Day 7 SQL-1](https://github.com/vishpant76/15-days-postgres/blob/main/Section-7/day-7-sql-part-1.sql) and [Day 7 SQL-2](https://github.com/vishpant76/15-days-postgres/blob/main/Section-7/day-7-sql-part-2.sql).
