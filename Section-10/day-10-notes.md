### Update, Delete, Views and Data Manipulation

- UPDATE, DELETE.

- CREATE TABLE AS: Useful when creating a table from a query - which could be a SELECT query using the existing tables.

- VIEWS: Problems with CREATE TABLE AS method: Although this allows us to create new tables from the query used on existing tables, it has two major problems:

    + Creating new table means extra physical storage will be needed.
    + Data can change! The new table that we created from existing tables will contain the data from those tables at that particular point in time. However, in future those existing tables may not have the same data: it may get updated/deleted/added, which won't get reflected in the newly created table after its creation.
 
- To address the above two issues, we use VIEWS. A view is a virtual table that is defined by a query. It doesn't store any data itself; instead, it's a saved SQL query that acts as a table when queried. Views can be used to simplify complex queries, enforce security, and provide a layer of abstraction over the underlying tables.

- So VIEWS do not exist physically like tables. They are just saved SQL queries that essentially work on the existing tables just like any other query, but their behavior is similar to that of tables since the result of that saved query behind the view, is eseentially a table like representation. Since the saved query behind the VIEW will operate on the existing tables, it will be dynamic in nature when we run the query to fetch results from VIEW, i.e. if any changes happen in the data in the underlying tables, they will be reflected via the VIEW.

- Creating view - similar to Create as table.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/5c184ab0-cf32-4a74-827b-143dca40e5d8)

---

- MATERIALIZED VIEW: Combines the benefits of having a physical table as well as VIEWS: Data is stored physically, and faster performance is ensured (even if the underlying query is complex). Periodic refresh is needed, as the data can't update automatically in MV.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/4b429f4f-1276-4f63-95a4-339b1f115023)

---

- Managing Views - Similar to other DDL operations. CREATE or REPLACE is only possible with Views and not MVs.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/7145719e-ba93-4fce-9442-fbb762b7fecc)

---

- Alter View:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/0fa62360-207b-4459-974b-0ebbfb6db2cb)

---

- IMPORT and EXPORT

- [Day 10 SQL](https://github.com/vishpant76/15-days-postgres/blob/main/Section-10/day-10-sql.sql)
