### Section 4 - Day 4 - Functions

- UPPER(), LOWER(), LENGTH().
- LEFT() and RIGHT() - extracts the text of the string starting from left or right. To get a character from somewhere in the middle, left() can be nested within right(). In the below nesting example, first 3 characters starting from the left are extracted from first_name, and then the last character of this substring is extracted (since right is outside). 

```
-- LEFT() - to extract the text of a string starting from left side. 
select left(first_name, 2), first_name
from customer;

-- RIGHT() - starting from right side.
select right(first_name, 2), first_name
from customer;

-- If we want to extract from somewhere in the middle, we can nest left and right.
select right(left(first_name, 3), 1), first_name
from customer;
```

- Concatenate operator - ||
- POSITION - we can specify what specific character/string we are searching and inside which column. This can be very useful when the result of position() is then passed as an argument to left() or right(). This way we can find the position of the particular character, and then use left() or right() to get the substring from/until that character in the main string. Note that POSITION() will return the position based on 1-based indexing. In the below query, we are able to query the susbtring starting from the left until the character just before @ in the email column.

```
select left(email, position('@' IN email)-1), email
from customer;
```

- Instead of a specific character, an entire string could also be passed to POSITION. It will then search for that string in the IN column and return its starting index. Then again we can use that information as an argument in another function like left() or right().
```
select left(email, position(last_name IN email)-2), email
from customer;
```

- SUBSTRING - `SUBSTRING (string FROM start [for length])`. The length part is optional. If not specified, it SUBSTRING() will return the result until the end of the main string.

```
select email,
substring(email from position('.' in email)+1 for length(last_name))
from customer;
```

- Suppose if we don't have the length(last_name) available. Then we can make use of POSITION to get that. Basically, we can calculate the length by subtracting the position of the '.' from the position of the '@' sign. Slightly more complex, but this is a very dynamic way to extract a string that is between 2 characters. Review this a few more times if in doubt, should make sense in due time.

```
select email,
substring(email from position('.' in email)+1 for POSITION('@' in email) - POSITION('.' in email) - 1)
from customer;
```
NTOE: position('.' in email): It finds the position of the "." character within the email column. It returns the index of the **first occurrence of "." in the email string**. There are apparently ways to deal with the cases where we may want to work on the other occurrences of that character, but not going into the details for now. Requires CTE and more advanced techniques (as per CG).

- This is a good, complex example showing the use of substring:
```
// ***lastCharofFirstName.FirstCharOfLastName***@email.com
select '***' || substring(email from position('.' in email) - 1 for 3) || '***' || substring(email from position('@' in email))
from customer;
```

- EXTRACT() - To extract parts of timestamp/date. Date/Time types:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/0857f7af-ede9-4113-89cf-dbad03e08dd1)

---

- Extract syntax: `EXTRACT(field from date/time/interval)`. Different field options available:

![image](https://github.com/vishpant76/15-days-postgres/assets/18080911/6ac64f20-eddf-4d12-a87a-51115c1465c0)

---

- The working of `extract` is still a bit confusing but refer the SQLs in Challenge #6 in the day-4-sql file. Also check out [this discussion](https://chat.openai.com/share/4ebecbcf-6274-456e-b85a-30d550e55d57) with CG for more.

- `TO_CHAR` function: Used to get custom formats timestamp/date/numbers. Output is always plain text. Syntax: `TO_CHAR (date/time/interval, format)`. There are many variants of the format, we can even use our own. Refer to documentation for the full list.
```
-- To Char function
select *, extract(month from payment_date), TO_CHAR(payment_date, 'DD-MM-YY')
from payment;

select sum(amount), to_char(payment_date, 'Dy, Month, YYYY')
from payment
group by to_char(payment_date, 'Dy, Month, YYYY');
```

- Intervals & Timestamps: See SQL below for examples.

- [Day-4-SQL](https://github.com/vishpant76/15-days-postgres/blob/main/Section-4/day-4-sql.sql)
