### Day 14 - User def functions, Stored Procedures, and Transactions

- User def functions: Makes use of PL/pgSQL. parameters must be declared with data type in the function.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/1afcc15c-a14a-4dad-ae62-87ce81d139e1)

---

- Some interesting e.g of PL/pgSQL and user defined functions done in sql file.

- Transactions
  + Not visible in other sessions (e.g. other users). Even if it is same user, but opens a new SQL window while the current transaction is ongoing in the first window, the transaction will not be visible in that new window as it will be treated as a separate session.
  + Once we commit the transaction, then it will be visible to other users/sessions.

- Rollbacks - If we have multiple operations, and if we want to rollback to a particular operation instead of rollbacking everything, use SAVEPOINT. SAVEPOINT only work within current transaction.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/90f5fe98-c43e-49a5-90ff-395df975bcd9)

---

- Deleting SAVEPOINT:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/5b2ef4fe-61d2-4d26-a5a3-2876e72b350c)

---

- Rollback ends a transaction. But Rollback to SAVEPOINT - we are still within the current transaction.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/bd15faa1-3ad8-426c-bf49-189efb309900)

---

- Stored Procedures: Downside of user created functions - they cannot execute transactions. That's where stored procedures are useful.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/2287ef7c-44a9-43c0-bd7d-b4955ddc6246)

---

- Syntax is similar to that of functions. NOTE: Unlike functions, the parameters in the procedure definition, do not have a datatype defined. Also, there is no RETURNS statement because a stored procedure DOES NOT return anything. We could optionally use RETURN to immediately stop the procedure, but we cannot RETURN an expression/value.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/eb894ba1-ed85-4573-9760-21b4f93bc901)

---

- [Day-12-SQL](https://github.com/vishpant76/15-days-postgres/blob/main/Section-14/day-12-sql.sql)
