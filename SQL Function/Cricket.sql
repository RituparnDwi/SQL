CREATE DATABASE Cricket


----------------------------TABLE MATCH1--------------------------

CREATE TABLE Match1
	(Player_Id VARCHAR(10) PRIMARY KEY,
	 P_Name VARCHAR(100),
	 Runs INT,
	 Popularity INT);

SELECT * FROM Match1 

DROP TABLE Match1

-------check column size----------

SELECT COLUMN_NAME,  DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Match1' AND COLUMN_NAME = 'Player_Id';


INSERT INTO Match1(Player_Id, P_Name, Runs, Popularity) VALUES
	('PL1', 'Virat', 50, 10),
	('PL2', 'Rohit', 41, 7),
	('PL3', 'Jadeja', 33, 6),
	('PL4', 'Dhoni', 35, 15),
	('PL5', 'Dhawan', 45, 12),
	('PL6', 'Yadav', 66, 10),
	('PL7', 'Raina', 32, 9),
	('PL8', 'Binny', 44, 11),
	('PL9', 'Rayudu', 63, 12),
	('PL10', 'Rahane', 21, 10),
	('PL11', 'A. Patel', 12, 9),
	('PL12', 'B. Kumar', 30, 7);

----------------------------TABLE MATCH2--------------------------

CREATE TABLE Match2
	(Player_Id VARCHAR(10) PRIMARY KEY,
	 Player_Name VARCHAR(100),
	 Runs INT,
	 Charisma INT);

SELECT * FROM Match2 

DROP TABLE Match2

----------------------------------check column size------------------------

SELECT COLUMN_NAME,  DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Match2' AND COLUMN_NAME = 'Player_Id';

--------------------------------------------------------------------------

INSERT INTO Match2(Player_Id, Player_Name, Runs, Charisma) VALUES
	('PL1', 'Virat', 50, 55),
	('PL2', 'Rohit', 41, 30),
	('PL3', 'Jadeja', 33, 24),
	('PL4', 'Dhoni', 35, 59),
	('PL13', 'Yuraaj', 33, 50),
	('PL6', 'Yadav', 66, 35),
	('PL14', 'Tendulkar', 74, 80),
	('PL8', 'Binny', 44, 32),
	('PL9', 'Rayudu', 63, 39),
	('PL15', 'Dravid', 65, 55),
	('PL16', 'Yusuf', 40, 40);

-------------------------------------------------Query----------------------------------------------
--# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.

SELECT Match1.P_Name, Match1.Player_Id, Match2.Player_Name, Match2.Player_Id
FROM Match1
INNER JOIN Match2 ON Match1.Player_Id = Match2.Player_Id

SELECT P_Name FROM Match1
UNION
SELECT Player_Name FROM Match2

--# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
--#  scored runs more than 50

SELECT Player_Id, P_Name, Runs
FROM Match1
WHERE Runs > 50

----# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.

SELECT * FROM Match1
WHERE LEFT(P_Name, 1) = 'y' AND RIGHT(P_Name, 1) = 'v'

----# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.

SELECT * FROM Match1
WHERE RIGHT(P_Name, 1) != 't'

---------------------------------------table3---------------------------------------------

-- --------------------------------------------------------
---# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------

CREATE TABLE Match3(
	Pla_Id VARCHAR(10) PRIMARY KEY, 
	Pla_Name VARCHAR(60),
	Run_s INT,
	Popularit_y INT,
	Charism_a INT
);

ALTER TABLE Match3
ALTER COLUMN Popularit_y DECIMAL(10,2)

INSERT INTO Match3(Pla_Id, Pla_Name, Run_s, Popularit_y, Charism_a) VALUES
	('PL1', 'Virat', 50, 10, 55),
	('PL2', 'Rohit', 41, 7, 30),
	('PL3', 'Jadeja', 33, 6, 24),
	('PL4', 'Dhoni', 35, 15, 59),
	('PL6', 'Yadav', 66, 10, 35),
	('PL8', 'Binny', 44, 11, 32),
	('PL9', 'Rayudu', 63, 12, 39);

SELECT * FROM Match3

----------# Q5. Write a MySQL query to add a column PC_Ratio to the table that contains the divsion ratio 
----------# of popularity to charisma .(Hint :- Popularity divide by Charisma)

ALTER TABLE Match3
ADD PC_Ratio DECIMAL(10, 2);

UPDATE Match3
SET PC_Ratio = Popularit_y / Charism_a * 1.0;


---# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.

SELECT TOP 5 Pla_Name, PC_Ratio
FROM Match3
ORDER BY PC_Ratio DESC;

----# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.

SELECT * 
FROM Match3
WHERE Pla_Name LIKE '%D%'

----# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.

SELECT Pla_Id, PC_Ratio
FROM Match3
WHERE PC_Ratio BETWEEN 0.12 AND 0.25

-------------------------------------------TABLE4-----------------------------

CREATE TABLE New_Cricket(
	Playe1_Id VARCHAR(10),
	Playe1_Name VARCHAR(60),
	Runs1 INT,
	Popularity DECIMAL(10, 2),
	Player1_Id VARCHAR(10),
	Player1_Name VARCHAR(60),
	Runs2 INT,
	Charisma DECIMAL(10,2)
);	

DROP TABLE New_CriCKET

INSERT INTO New_Cricket VALUES
	('PL1', 'Virat', 50, 10, 'PL1', 'Virat', 50, 55),
	('PL2', 'Rohit', 41, 7, 'PL2', 'Rohit', 41, 30),
	('PL3', 'Jadeja', 33, 6, 'PL3', 'Jadeja', 33, 24),
	('PL4', 'Dhoni', 35, 15, 'PL4', 'Dhoni', 35, 59),
	('PL6', 'Yadav', 66, 10, 'PL6', 'Yadav', 66, 35),
	('PL8', 'Binny', 44, 11, 'PL8', 'Binny', 44, 32),
	('PL9', 'Rayudu', 63, 12,'PL9', 'Rayudu', 63, 39),
	('PL5', 'Dhawan', 45, 12, NULL, NULL, NULL, NULL),
	('PL7', 'Raina', 32, 9, NULL, NULL, NULL, NULL),
	('PL10', 'rahane', 21, 10, NULL, NULL, NULL, NULL),
	('PL11', 'A. Patel', 12, 9, NULL, NULL, NULL, NULL),
	('PL12', 'B. Kumar', 30, 7, NULL, NULL, NULL, NULL);


SELECT * FROM New_Cricket

-- --------------------------------------------------------
----# Dataset Used: new_cricket.csv
-- --------------------------------------------------------
---# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.
 
SELECT Player1_Id, Player1_name
FROM New_Cricket
WHERE Charisma IS NULL;

--# Q10. Write a MySQL query to display all the NULL values  in the column Charisma imputed with 0.

SELECT ISNULL(Charisma, 0)
FROM New_Cricket

SELECT 
	Player1_Id,
	Player1_name,
	COALESCE(Charisma, 0) AS Charisma
FROM New_Cricket;


---# Q11. Separate all Player_Id into single numeric ids (example PL1 to be converted as 1, PL2 as 2 , ... PL12 as 12 ).
 
SELECT 
	SUBSTRING(Player1_Id,3, 1) AS Sep_Id,
	Player1_name
FROM New_Cricket;

SELECT Player1_Id, 
	CAST(REPLACE(Player1_Id, 'PL', '') AS INT) AS Numeric_id
FROM New_Cricket;

-----# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.

SELECT Player1_Id, Player1_name, Charisma
FROM New_Cricket
WHERE Charisma > 25

-----------------------------------------------------------------------------------------------------
------------------------Table5-----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

-- --------------------------------------------------------
---# Dataset Used: churn1.csv 
-- --------------------------------------------------------

CREATE TABLE churn1(
	customerID VARCHAR(40) PRIMARY KEY,
	gender VARCHAR(10),
	SeniorCitizen TINYINT,
	Partner VARCHAR(20),
	Dependents VARCHAR(10),
	tenure INT,
	CallService VARCHAR(10),
	MultipleConnections VARCHAR(50),
	InternetConnection VARCHAR(50),
	OnlineSecurity VARCHAR (50),
	OnlineBackup VARCHAR (50),
	DeviceProtectionService VARCHAR (50),
	TechnicalHelp VARCHAR (50),
	OnlineTV VARCHAR (50),
	OnlineMovies VARCHAR (50),
	Agreement VARCHAR (50),
	BillingMethod VARCHAR (50),
	PaymentMethod VARCHAR (50),
	MonthlyServiceCharges FLOAT,
	TotalAmount FLOAT,
	Churn VARCHAR (50)
);

DROP TABLE churn1

SELECT * FROM churn1;

ALTER TABLE churn1
REBUILD WITH (IGNORE_DUP_KEY = ON);

INSERT INTO churn1 (customerID,gender,SeniorCitizen,Partner,Dependents,tenure,CallService,MultipleConnections,InternetConnection,OnlineSecurity,OnlineBackup,DeviceProtectionService,TechnicalHelp,OnlineTV,OnlineMovies,Agreement,BillingMethod,PaymentMethod,MonthlyServiceCharges,TotalAmount,Churn)
SELECT customerID,gender,SeniorCitizen,Partner,Dependents,tenure,CallService,MultipleConnections,InternetConnection,OnlineSecurity,OnlineBackup,DeviceProtectionService,TechnicalHelp,OnlineTV,OnlineMovies,Agreement,BillingMethod,PaymentMethod,MonthlyServiceCharges,TotalAmount,Churn
FROM OPENROWSET (
	BULK 'H:\New Folder\churn1.csv',
	FORMATFILE = 'H:\New Folder\churn1.csv',
	FIRSTROW = 2
) AS DATA;


BULK INSERT churn1
FROM 'H:\New Folder\churn1.csv'
WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n'
	);


---# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount 
---# for those paymentmethod is through Electronic check mode.


SELECT MIN(MonthlyServiceCharges) AS LowestMonthlyCharge, MAX(TotalAmount) AS MaxTotalAmount
FROM churn1
WHERE PaymentMethod = 'Electronic check';


-----# Q14. Rename the table churn1 to “Churn_Details”.

EXEC sp_rename 'churn1', 'Churn_Details';					-------# For SQL server 

RENAME TABLE 'churn1', TO 'Churn_Details';					-------# For MySQL server


-----# Q15. Write a query to create a display a column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.


SELECT TotalAmount, MonthlyServiceCharges,
ISNULL(TotalAmount, 0) + ISNULL(MonthlyServiceCharges, 0) AS New_Amount
FROM churn1;


-----# Q16. Rename column new_Amount to Amount.


EXEC sp_rename 'churn1.New_Amount', 'Amount'


-----# Q17. Drop the column “Amount” from the table “Churn_Details”.


ALTER TABLE churn1
DROP COLUMN amount;

----# Q18. Write a query to extract the customerID, InternetConnection and gender 
----# from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ 
----# at the second position.


SELECT customerID, gender, InternetConnection 
FROM churn1
WHERE InterConnection = '_i%';


----# Q19. Find the records where the tenure is 6x, where x is any number.


SELECT * FROM churn1
WHERE tenure LIKE '6_';


------# Q20. Write a query to display the player names in capital letter 
------# and arrange in alphabatical order along with the charisma, display 0 for whom the charisma value is NULL.

SELECT UPPER(Playe1_Name) AS Cap_Name,
ISNULL(Charisma, 0) AS Charisma
FROM New_Cricket
ORDER BY UPPER(Playe1_Name) ASC


