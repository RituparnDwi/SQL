Use compnay2

select * from [user]

-----To Rename the 'name' column to 'Full Nmae'---

EXEC sp_rename '[user].name', 'Full name', 'column'

---To change 'age' columnn datatype 'INT' to 'SMALLINT'----

ALTER TABLE [user]
ALTER COLUMN age SMALLINT;

---To add a NOT NULL constraint to city column---

ALTER TABLE [user]
ALTER COLUMN city VARCHAR(50) NOT NULL