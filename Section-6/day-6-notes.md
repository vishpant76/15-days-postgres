### Section 6 - Day 6 - JOINS

- INNER JOIN

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/2b960de7-639e-45c0-8dae-98ab95a1948d)

---

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/7b40ddcd-c9c7-48b3-8c13-a4dfc1ecf26d)

---
- Challenge problem: How many people choose seats in the category: Business, Economy, or Comfort? The wrong solution is there in sql file, but below is the correct one for this.

```
select * from flights;
select fare_conditions, count(*)
from boarding_passes bp
inner join flights f
on bp.flight_id = f.flight_id
inner join seats s
on f.aircraft_code = s.aircraft_code AND s.seat_no = bp.seat_no
group by fare_conditions;
```

- FULL OUTER JOIN

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/4d26ddda-150f-45b8-bed5-9f555b9df923)

--- 

- FULL OUTER JOIN on boarding passes and tickets tables.
```
select * from boarding_passes b
full outer join tickets t
on b.ticket_no = t.ticket_no;
```

- FULL OUTER JOIN with WHERE. Suppose we want to find out those records where ticket has been sold but there is no boarding pass. The other way to say it: the ticket_no column in boarding_passes table is NULL. This essentially means that although that ticket_no exists in tickets table, it's not there in boarding_passes table.

```
select * from boarding_passes b
full outer join tickets t
on b.ticket_no = t.ticket_no
where b.ticket_no is null;
```
> Full outer join = "all rows which are matched based on join condition" + "all rows from left table which did not find match in right table" + "all rows from right table which did not find match in left table". In the above example, it displays all the rows from table A which did not find any match in table B hence, it shows NULL against columns of B table. Logically you can say that customers have bought the tickets however they haven't web check-in yet and hence, the boarding pass is NOT issue for them.

- LEFT OUTER JOIN: Takes all of the rows from table A (LEFT table), along with the overlapping with table B, but not those rows that are exclusive to table B (right table).

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/fe71116a-fcb7-4ef9-98b1-9de19cda466c)

---

- Find all aircrafts that have not been used in any flights.
```
select * from aircrafts_data a
LEFT JOIN flights f
ON a.aircraft_code = f.aircraft_code
where f.aircraft_code is null;
```

- Challenge: Which seat has been chosen most frequently? All seats should be included even if they have never been chosen before. Are there seats that have never been booked before? Refer [day-6-sql-part-1](https://github.com/vishpant76/15-days-postgres/blob/main/Section-6/day-6-sql-part-1.sql) sql file for the solutions discussed in video, but they are wrong solutions. Refer the comments in the end of the file for more on this. Skipping for now, may be get back later. All this data is present in the demo database (flights).

- RIGHT JOIN: All of the data rows from the second (right) table included, and the data exclusive to left table will not be included.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/91b2e7b0-41ab-4ea4-be7e-056846e03d9c)

---

- Multiple Join conditions: A tip on performance issues: Using AND in a JOIN to have multiple join conditions is faster than using a simple WHERE.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/fb6c15d7-5c42-441e-a152-0a80817c564c)

---

- Postgres supports the concept of composite primary keys in tables, i.e. the primary consists of multiple columns. See [here](https://chat.openai.com/c/8bb0761e-fd59-4abe-9f39-1af256071f24) for more.

- Get the average price (amount) for the different seat_no. Using inner join here, but this could probably also be solved with LEFT JOIN as instructor showed in video. But wonder how the null records would influence the average??
```
SELECT
  seat_no,
  ROUND(AVG(amount), 2)
FROM
  ticket_flights t
  INNER JOIN boarding_passes b ON t.ticket_no=b.ticket_no
  AND t.flight_id=b.flight_id
GROUP BY
  seat_no
ORDER BY
  2 desc;
```

- Joining Multiple tables: If using INNER JOIN between multiple tables, table order doesn't matter.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/7f58e0ee-c154-4d0c-9b8c-0b8a4cc4c9bf)

--- 

- But the order matters in case of LEFT/RIGHT outer JOIN between multiple tables.

- JOINS challenge: Which customers are from Brazil? Get the first, lastname, email, country for all customers of Brazil. See the [day-6-sql-part-2](https://github.com/vishpant76/15-days-postgres/blob/main/Section-6/day-6-sql-part-2.sql) file for solution. It doesn't matter if you use INNER or LEFT join here as there are no customers that do not have an associated address_id. Refer [this discussion](https://chat.openai.com/c/17ef4d20-b5ae-4b22-aa10-8d14c0d8dfc1) for more.

- Few more challenges were covered at the end of Day 6. Refer the SQL-Part2 file for them.

- [Day 6 - SQL - Part-1](https://github.com/vishpant76/15-days-postgres/blob/main/Section-6/day-6-sql-part-1.sql) and [Day 6 - SQL - Part-2](https://github.com/vishpant76/15-days-postgres/blob/main/Section-6/day-6-sql-part-2.sql).
