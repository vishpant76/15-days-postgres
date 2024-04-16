### Section 1 - Day 1

- Basic SELECT
- SELECT with ORDER BY
- How ORDER BY DESC works when multiple columns are in ORDER BY clause.

- DISTINCT - means `distinct` in terms of all selected columns. So if multiple columns in select statement, and 'distinct' is used, as long as there is difference with one of the columns, the row will be displayed. In multiple columns case, the combination of columns needs to be distinct.

- LIMIT - limits the number of rows you want. Always comes last in the select statement.

- Using DISTINCT with COUNT.
```
select
count (DISTINCT first_name)
from actor;
```

- [SQL for Day 1](https://github.com/vishpant76/15-days-postgres/blob/main/Section-1/day-1.sql)
