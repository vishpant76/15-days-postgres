### Day 7 - UNION and Subqueries

- UNION - combining multiple SELECT statements. Combining rows. Three things to remember:
    + How columns are matched? Columns are NOT matched by their names, but by their order. Even if the first column of one table has a name different from the first column of the second table, as long as they are in the same order, they would match. If the names of columns are different, the first table's column's name will be used in the result set.
    + So it's important that the tables being combined via UNION, have their columns mentioned in the same order in the query (the data types must match). Number of columns must match.
    + If there are duplicates, only one record will be there in the result. However, if we want to keep all records from both tables, including all duplicate rows, we can use `UNION ALL`.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/b7792b86-4fdd-4da1-b900-a898a3025c78)

---

- 
