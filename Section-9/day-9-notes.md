### Day 9 - Managing Dbs and Tables

- DDL, DML, constraints, views, data types, PK/FK, etc.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/cccf70fd-4373-49c2-b2ab-494fec8f927f)

---

- `enum` - A value of a list of ordered values. 
```
create type mppa_rating as enum ('G', 'PG', [...]);
```

- Array data type - Use of ANY operator.

- Quiz:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/ad63b7b8-4086-47b0-ac92-726073add583)

---

- Quiz:
![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/b7fd4e25-3057-497a-b6be-5086a70792c9)

--- 

- Quiz:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/297aa9fb-c73a-45fa-af94-ea916713b188)

---

- Quiz:
![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/4788b9cd-d5a6-4e90-98cd-b659de01a64f)

---

- Constraints - added in Anki.

- Quiz:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/7182d579-5525-4786-9106-ed53f0430142)

---

- Quiz:
![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/8674e25d-d31b-40ff-87a1-6e7b48089f32)

---

- Primary and Foreign Key.

- Quiz:
![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/47fd0ee2-ae50-4999-9b76-c590d87b104d)

---

- Create table e.g.:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/847fbcfb-f2fe-4f48-af5b-aca12717130f)

---

- ALTER TABLE: Adding column to a table, if not exists.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/303821ca-ea77-41a4-a36e-f70feaf8d4c5)

---

- Other Alter statements. Multiple statements can be executed together, except the alter rename.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/6fb7df03-cc44-452e-be30-a7daff21b7e8)

---

- Alter rename must be executed separately, if ever needed.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/8977ac06-1719-4855-b9d3-65b9f9931a24)

---

- DROP - can be used to drop/delete any object (table, schema etc). Truncate - does not delete the table itself, but removes the data inside it.

- CHECK constraint:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/1ae91317-ee5b-4f8b-8356-0eb727f1c7dd)

---

- Check e.g.:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/0c93785d-5cdb-411b-814a-4ffe287c6aaa)

---

- Check constraint - Challenge. See SQL file for solution.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/892b0bd0-da87-423b-9eac-e74a8c710861)

---

- [Day 9 SQL](https://github.com/vishpant76/15-days-postgres/blob/main/Section-9/day-9-sql.sql).
