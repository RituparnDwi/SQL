CREATE DATABASE company;

CREATE TABLE employees(
	employee_id int PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	postiion VARCHAR(50),
	department VARCHAR(50),
	hire_date DATE,
	salary NUMERIC(10,2)
);

SELECT * FROM employees;

EXEC sp_rename 'employees.postiion','position','COLUMN';

TRUNCATE TABLE employees

insert into employees (employee_id, name, position, department, hire_date, salary)
		values(1101, 'Ajit Sharma', 'Data Analyst', 'Data Science', '2022-05-15', 65000.00),
			(1102, 'Priya Desai','Software Engineer', 'IT', '2021-09-20',75000.00),
			(1103, 'Rajesh Kumar', 'HR Manager', 'Human Resources', '2019-03-10', 82000.00),
			(1104, 'Sneha Patel', 'Marketing Specialist', 'Marketing', '2020-11-25', 58000.00),
			(1105, 'Vikram Singh', 'Sales Executive', 'Sales', '2023-02-12', 62000.00);

CREATE DATABASE compnay2;

CREATE TABLE employee2 (
		emp_id int primary key,
		name varchar(50),
		position varchar(50),
		department varchar(50),
		hire_date date,
		salary numeric(10,2)
);

insert into employee2(emp_id, name, position, department, hire_date, salary)
		values(1101, 'Ajit Sharma', 'Data Analyst', 'Data Science', '2022-05-15', 65000.00),
			(1102, 'Priya Desai','Software Engineer', 'IT', '2021-09-20',75000.00),
			(1103, 'Rajesh Kumar', 'HR Manager', 'Human Resources', '2019-03-10', 82000.00),
			(1104, 'Sneha Patel', 'Marketing Specialist', 'Marketing', '2020-11-25', 58000.00),
			(1105, 'Vikram Singh', 'Sales Executive', 'Sales', '2023-02-12', 62000.00),
			(1106, '', 'Admin', 'Formatting', '2025-04-21', 25000.00),
			(1107, '', 'Consultant', 'Recruiter', '2024-05-28', 30000.00);

select * from employee2

TRUNCATE TABLE employee2;

ALTER TABLE employee2
ALTER COLUMN name VARCHAR(50) NOT NULL

DELETE FROM employee2
WHERE emp_id = 1107

DROP TABLE IF EXISTS employee2;

ALTER TABLE employee2
DROP COLUMN Salary;


---Create a Table user----

IF NOT EXISTS (SELECT * FROM sys.tables 
	WHERE name = 'user')
BEGIN
	CREATE TABLE [user] (
			user_id INT PRIMARY KEY,
			name VARCHAR(50) NOT NULL,
			email VARCHAR(255),
			age INT CHECK (age >= 18),
			city VARCHAR(50)
	);
END

----Deleting Table----

DROP TABLE IF EXISTS [user];

----INSERT into Table-----

INSERT INTO [user] (user_id, name, email, age, city)
	VALUES	(1011, 'Rajesh', 'rajesh@gmail.com', 25, 'Mumbai'),
			(1012, 'Priya', 'priya@yahoo.com', 30, 'Delhi'),
			(1013, 'Ankit', 'ankit@gmail.com', 28, 'Bangalore'),
			(1014, 'Sneha', 'sneha@hotmail.com', 35, 'Pune'),
			(1015, 'Vikram', 'vikram@gmail.com', 22, 'Hyderabad');

SELECT * FROM [user]

select name, city from [user]

UPDATE [user]
SET age = 28
WHERE name = 'Rajesh';

select * from [user] order by age

UPDATE [user]
SET city = 'Chennai'
WHERE age >= 30

UPDATE [user]
SET age = age + 1
WHERE email LIKE '%@gmail.com'