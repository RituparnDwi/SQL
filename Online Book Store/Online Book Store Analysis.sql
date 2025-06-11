CREATE DATABASE OnlineBookStore;

-----Create Tables--------------

DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS [dbo].[Books];

CREATE TABLE Books(
	Book_ID	INT PRIMARY KEY,
	Title VARCHAR(255),
	Author VARCHAR(100),
	Genre VARCHAR(100),
	Published_Year INT,
	Price DECIMAL(10, 2),
	Stock INT
);

DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
	Customer_ID	INT PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(100),
	Country VARCHAR(100)
);

DROP TABLE IF EXISTS orders;

CREATE TABLE orders(
	Order_ID INT PRIMARY KEY,
	Customer_ID	INT REFERENCES customers(Customer_ID),
	Book_ID	INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);



----------Import Data into Books Table----------



SELECT * FROM [OnlineBookStore].[dbo].[Books];


----------Import Data into customer Table----------


BULK INSERT customers
FROM 'G:\Data analyst\SQl dataset\All Excel Practice Files\Customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);


SELECT * FROM customers;



----------Import Data into orders Table----------


SELECT * FROM [OnlineBookStore].[dbo].[Orders]


---------------------------------------------------------------------------------------------------------------------
--------------------------------------------Basic Queries------------------------------------------------------------

 ----Q1) Retrieve all books in the "Fiction" genre

	SELECT Title, Genre FROM [OnlineBookStore].[dbo].[Books]
	WHERE Genre = 'Fiction'


 ----Q2) Find books published after the year 1950
 
	 SELECT Title, Published_Year FROM [OnlineBookStore].[dbo].[Books]
	 WHERE Published_Year > 1950;

 
 ----Q3) List all customers from the Canada
 
	SELECT Name, Country FROM customers
	WHERE Country = 'Canada'
 
 
 ----Q4) Show orders placed in November 2023
 
	SELECT Order_ID, Order_Date FROM [OnlineBookStore].[dbo].[Orders]
	WHERE MONTH(Order_Date) = 11 AND YEAR(Order_Date) = 2023
 
 
 ----Q5) Retrieve the total stock of books available
 
	SELECT SUM(Stock) AS TotalStock
	FROM [OnlineBookStore].[dbo].[Books]

 
	 SELECT Genre, SUM(Stock) AS TotalStock
	 FROM [OnlineBookStore].[dbo].[Books]
	 GROUP BY Genre


 ----Q6) Find the details of the most expensive book
 
 
	 SELECT * FROM [OnlineBookStore].[dbo].[Books]
	 WHERE Price = (SELECT MAX(Price) FROM [OnlineBookStore].[dbo].[Books])
 
 
 
	 SELECT * FROM (
				SELECT *, RANK() OVER (ORDER BY Price DESC) AS PriceRank
				FROM [OnlineBookStore].[dbo].[Books]
				) AS Subquery
			WHERE PriceRank = 1;
 

 ----Q7) Show all customers who ordered more than 1 quantity of a book
 
 
	 SELECT C.Name, O.Quantity
	 FROM customers C
	 INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON C.Customer_ID = O.Order_ID
	 AND O.Quantity > 1

 
 ----Q8) Retrieve all orders where the total amount exceeds $20
 
 
	 SELECT Order_ID, Total_Amount
	 FROM [OnlineBookStore].[dbo].[Orders] 
	 WHERE Total_Amount > 20


 ----Q9) List all genres available in the Books table
 
	 SELECT DISTINCT Genre
	 FROM [OnlineBookStore].[dbo].[Books]

 
 ----Q10) Find the book with the lowest stock
 
	 SELECT TOP 1 * 
	 FROM [OnlineBookStore].[dbo].[Books]
	 ORDER BY Stock ASC
 
 ----Q11) Calculate the total revenue generated from all orders


	 SELECT SUM(Total_Amount) AS TotalRevenue
	 FROM [OnlineBookStore].[dbo].[Orders]

	 SELECT SUM(B.Price * O.Quantity) AS Total_Revenue
	 FROM [OnlineBookStore].[dbo].[Books] B
	 INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON B.Book_ID = O.Order_ID
 
 --------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------Advance Queries--------------------------------------------------------

 ----Q1) Retrieve the total number of books sold for each genre
 
	 SELECT B.Genre, SUM(O.Quantity)
	 FROM [OnlineBookStore].[dbo].[Books] B
	 INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON B.Book_ID = O.Book_ID
	 GROUP BY B.Genre

 
 ----Q2) Find the average price of books in the "Fantasy" genre
 
	
	SELECT Genre, AVG(Price) AS AveragePrice
	FROM [OnlineBookStore].[dbo].[Books]
	WHERE Genre = 'Fantasy'
	GROUP BY Genre
	

 ----Q3) List customers who have placed at least 2 orders
 
	 SELECT C.Name, COUNT(O.Order_ID) AS Number_of_Orders
	 FROM customers C 
	 INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON C.Customer_ID = O.Customer_ID
	 GROUP BY C.Name 
	 HAVING COUNT(O.Order_ID) >= 2;
 
 
 ----Q4) Find the most frequently ordered book
 
	
	SELECT TOP 1
	C.Name, COUNT(O.Order_ID) AS Most_Orders
	FROM customers C 
	INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON C.Customer_ID = O.Customer_ID
	GROUP BY C.Name
	ORDER BY Most_Orders DESC;
	 
 
 ----Q5) Show the top 3 most expensive books of 'Fantasy' Genre 

	
	SELECT TOP 3
	Title, Genre, Price FROM 
	[OnlineBookStore].[dbo].[Books]
	WHERE Genre = 'Fantasy'
	ORDER BY Price DESC


 ----Q6) Retrieve the total quantity of books sold by each author
 
 
	SELECT B.Author, SUM(O.Quantity) 
	FROM [OnlineBookStore].[dbo].[Books] B
	INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON B.Book_ID = O.Book_ID
	GROUP BY B.Author
 
 
 ----Q7) List the cities where customers who spent over $30 are located
 
 
	SELECT C.City, SUM(O.Quantity * B.Price) AS TotalSpent 
	FROM customers C
	INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON C.Customer_ID = O.Customer_ID
	INNER JOIN [OnlineBookStore].[dbo].[Books] B ON O.Book_ID = B.Book_ID
	GROUP BY C.City
	HAVING SUM(O.Quantity * B.Price) > 30


	SELECT 
		City,
		SUM(TotalSpent) AS TotalSpent
	FROM (
		SELECT 
			C.Customer_ID,
			C.City, 
			SUM(O.Quantity * B.Price) AS TotalSpent 
		FROM customers C
		INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON C.Customer_ID = O.Customer_ID
		INNER JOIN [OnlineBookStore].[dbo].[Books] B ON O.Book_ID = B.Book_ID
		GROUP BY C.Customer_ID, C.City
	) AS Subquery
	GROUP BY City
	HAVING SUM(TotalSpent) > 30


 ----Q8) Find the customer who spent the most on orders
 
	
	SELECT TOP 1 
	C.Customer_ID, C.Name, SUM(O.Quantity * B.Price) AS TotalSpent 
	FROM customers C
	INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON C.Customer_ID = O.Customer_ID
	INNER JOIN [OnlineBookStore].[dbo].[Books] B ON O.Book_ID = B.Book_ID
	GROUP BY C.Customer_ID, C.Name
	ORDER BY TotalSpent DESC;

	
	
	SELECT TOP 1
		Name,
		SUM(TotalSpent) AS MostSpent
	FROM (
		SELECT 
			C.Customer_ID,
			C.Name, 
			SUM(O.Quantity * B.Price) AS TotalSpent 
		FROM customers C
		INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON C.Customer_ID = O.Customer_ID
		INNER JOIN [OnlineBookStore].[dbo].[Books] B ON O.Book_ID = B.Book_ID
		GROUP BY C.Customer_ID, C.Name
	) AS Subquery
	GROUP BY Name
	ORDER BY MostSpent DESC;


 -----Q9) Calculate the stock remaining after fulfilling all order

	SELECT B.Genre, O.Quantity, SUM(B.Stock - O.Quantity) AS Availabe_Stock
	FROM [OnlineBookStore].[dbo].[Books] B
	INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON B.Book_ID = O.Book_ID
	GROUP BY B.Genre, O.Quantity
	ORDER BY Availabe_Stock


	
	SELECT B.Genre, SUM(O.Quantity) AS TotalQuantityOrdered, 
	SUM(B.Stock) - SUM(O.Quantity) AS Availabe_Stock
	FROM [OnlineBookStore].[dbo].[Books] B
	INNER JOIN [OnlineBookStore].[dbo].[Orders] O ON B.Book_ID = O.Book_ID
	GROUP BY B.Genre
	ORDER BY Availabe_Stock