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

- 
