### User Management, Indexes, Partioning, Query Optimization

- Create User - When we create a new db, there is always a _public_ schema included. Under this public schema, when we create new users, they will always be able to use the public schema, i.e. they can create objects in that schema and access those objects. But we can revoke certain privileges for the users if needed. Role = User + Login.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/63ddcea7-217c-4c85-b5f1-8ca121d7072f)

---

> [!IMPORTANT]
> The above point does not apply to Postgresql v15 and higher. Under public schema, new users can no longer create objects if they have not been granted explicit permissions.


> In PostgreSQL 15 and later versions, a change was made to the default permissions of the public schema, affecting how permissions are handled. Previously, any user could create objects in the public schema by default. However, starting with PostgreSQL 15, this behavior has been altered for security reasons.

> By default, non-superuser accounts are no longer able to create tables in the public schema of databases they don't own. This change aims to prevent the public schema from becoming cluttered with unused tables and to enhance security, as the public schema was a potential vector for privilege escalation attacks.

> To work around this you can either use your superuser or grant the necessary permissions explicitely to the user. For instance, after creating your database and user, you should connect to the database as a superuser or as the database owner and execute a command similar to: `GRANT ALL ON SCHEMA public TO your_user;`

> This command grants the specified user the ability to create objects in the public schema. It's important to perform this step after the database and user creation but before attempting to create any objects in the database. This change in PostgreSQL 15 requires administrators to be more deliberate about granting permissions, which can be seen as an improvement in database security and management practices.



- Grant and Revoke Privileges: Refer slide #591 onward in the [course ppt](https://drive.google.com/drive/u/0/folders/1kodcTUSkHaby0EvKZ64hvgi9eMGbF6hI) for different options for granting and revoking privileges. General syntax is below:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/daa47d2f-c4fa-4147-a2b5-a300f49a57b8)

---

- Different privileges along with the object types to which they arey applicable:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/08b52762-c17f-4d97-ac83-0e71de0e945b)

---

- Indexes: Although we see the data as a tabular representation when we query something, in the background, the data is actually stored in blocks; it is placed in rows, wherever there is space available. Data is stored without any particular order. So this is not so efficient when we read the data. Full table scan - read-inefficent. Using indexes on a column, allows us to avoid a full table scan.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/76359fb9-aa39-43c9-b39e-86209a945692)

---

- A few more points:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/39d9860c-1a88-4ef4-90a0-63caeb0db4aa)

---

- B-tree indexes - [Page 616 in the ppt](https://drive.google.com/drive/u/0/folders/1kodcTUSkHaby0EvKZ64hvgi9eMGbF6hI) - Usually applied on PKs, because PKs will have high cardinality, i.e. unique values.
> when you define a primary key on a table, an index is created automatically to enforce the uniqueness constraint and to speed up queries that use the primary key column(s). This index is called a "primary key index."

- Bitmap index - [Page 617 in the ppt](https://drive.google.com/drive/u/0/folders/1kodcTUSkHaby0EvKZ64hvgi9eMGbF6hI) - Good for low cardinality; for e.g. one column takes only 2-3 different possible values. Basically a mapping is created between the possible column values and the rows where the association exists.

- B-tree and bitmap index guidelines - [Slide 620](https://drive.google.com/drive/u/0/folders/1kodcTUSkHaby0EvKZ64hvgi9eMGbF6hI)

- Don't use indexes on small tables; generally preferred on large tables. Also, they should be created on those columns that are used as filter columns. If a table involves many write operations, then also creating index might be a bad idea.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/2803c899-219c-4ecb-9409-f3252c3f0d5e)

---

- Execution Plan - Play around with "Explain" and "Explain Analyze" in PgAdmin, especially when comparing queries with and without indexes.

- [Day-15-SQL](https://github.com/vishpant76/15-days-postgres/blob/main/Section-15/day-15-sql.sql)
