USE Company;

SELECT * FROM products;

-- Get all the categories in Uppercase


	SELECT UPPER(category) FROM products;



-- Get all the categories in Lowercase

	SELECT LOWER(category) FROM products;



-- Join Product_name adn category text with hypen.

	SELECT CONCAT(product_name,' - ',category) AS Product_detail
	FROM products;


-- Extract the first 5 characters from product_name

	SELECT SUBSTRING(product_name, 1, 5) AS short_name
	FROM products;

	SELECT SUBSTRING(category, 3, LEN(category)) AS shorts_cat 
	FROM products;

-- Count length


	SELECT product_name, LEN(product_name) AS COUNT_OF_CHAR
	FROM products;


--Remove leading and trailing spaces from string


	 SELECT LEN(TRIM('  Monitor    ')) AS Trimmed_Text;
	 SELECT LEN('  Monitor    ') AS Trimmed_Text;


-- Replace the word "phone" with "device" in product names


	SELECT REPLACE(product_name, 'phone','device') AS updated
	FROM products;


-- Get the first 3 characters from category

	
	SELECT LEFT(category, 3) AS Catergory_Capital
	FROM products;

	SELECT UPPER(LEFT(category, 3)) AS Catergory_Capital
	FROM products;

