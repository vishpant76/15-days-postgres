### Section 12 - Grouping Sets, Rollups, Self-Joins

- Grouping Sets - Allows us to define all of the different combinations that our data should be grouped by in one query. A [good article](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-grouping-sets/) read more on grouping sets.

- A couple of good problems added to Anki deck.

- ROLLUP: Hierarchy will be created between the columns. The first column we use in SELECT, must also be the first (highest) level of the hierarchy, and the susbequent columns should also follow the same. It's because in the roll up function the order really matters.

- CUBE - Order doesn't matter. No hierarchical relationship between the columns. CUBE can have all possible combinations of the grouping sets.

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/38585b95-5205-466a-a397-73de3f895529)

---

- 
