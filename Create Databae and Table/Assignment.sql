USE compnay2;

IF NOT EXISTS (SELECT * FROM sys.tables
		WHERE name = 'Employee3')
BEGIN
	CREATE TABLE [Employee3] (
			employee_id INT PRIMARY KEY,
			first_name VARCHAR(50) NOT NULL,
			last_name VARCHAR(50) NOT NULL,
			department VARCHAR(50),
			salary DECIMAL(10, 2) CHECK (salary > 0),
			joining_date DATE NOT NULL,
			age INT CHECK (age >= 18)
	)
END

INSERT INTO [Employee3] (employee_id,first_name,last_name,department,salary,joining_date,age) VALUES
		(121, 'Amit', 'Sharma', 'IT', 60000.00, '2022-05-01', 29),
		(122, 'Neha', 'Patel', 'HR', 55000.00, '2021-08-15', 32),
		(123, 'Ravi', 'Kumar', 'Finance', 70000.00, '2020-03-10', 35),
		(124, 'Anjali', 'Verma', 'IT', 65000.00, '2019-11-22', 28),
		(125, 'Suresh', 'Reddy', 'Operations', 50000.00, '2023-01-10', 26),
		(126, 'Rajesh', 'Dwivedi', 'Clerk', 25000.00, '2023-05-27', 48),
		(127, 'Priya', 'Rajpoot', 'Teacher', 45000.00, '2018-03-12', 30),
		(128, 'Ankit', 'Agrawal', 'Professor', 70000.00, '2016-08-21', 32);

SELECT * FROM [Employee3]

-- Assignment Questions

--Q1: Retrieve all employees’ first_name and their departments.

SELECT first_name, department FROM [Employee3];

--Q2: Update the salary of all employees in the 'IT' department by increasing it by 10%.

UPDATE [Employee3]
SET salary = salary + (salary*0.1)
WHERE department = 'IT';

SELECT * FROM Employee3

--Q3: Delete all employees who are older than 34 years.

DELETE Employee3
WHERE age > 34

--Q4: Add a new column `email` to the `employee3` table.

ALTER TABLE [Employee3]
ADD Email VARCHAR(100);


SELECT * FROM Employee3

--Q5: Rename the `department` column to `dept_name`.

EXEC sp_rename '[Employee3].department', 'dept_name', 'column'

--Q6: Retrieve the names of employees who joined after January 1, 2021.

SELECT first_name, last_name, joining_date FROM [Employee3]
WHERE joining_date > '2021-01-01';

--Q7: Change the data type of the `salary` column to `INTEGER`.

ALTER TABLE [Employee3]
ALTER COLUMN salary INTEGER;

--Q8: List all employees with their age and salary in descending order of salary.

SELECT first_name, last_name, age, salary FROM [Employee3]
ORDER BY salary DESC;

--Q9: Insert a new employee with the following details: 
		-- ('Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30)

INSERT INTO [Employee3] (employee_id, first_name, last_name, dept_name, salary, joining_date, age)
VALUES(129, 'Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30);

select * from [Employee3]

--Q10: Update age of employee +1 to every employee 

UPDATE [Employee3]
SET age = age+1

SELECT * FROM [Employee3]