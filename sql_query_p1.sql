-- SQL Retail Sales Analysis - P1
create database sql_project_p1;
USE sql_project_p1;


-- Create TABLE
CREATE TABLE retail_sales
			(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age INT,
				category VARCHAR(15),
				quantiy INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);
		
-- Data Cleaning
SELECT * FROM retail_sales;
SELECT 
	COUNT(*)
	FROM retail_sales;
    
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE gender IS NULL;

SELECT * FROM retail_sales
WHERE age IS NULL;

SELECT * FROM retail_sales
WHERE category IS NULL;

SELECT * FROM retail_sales
WHERE quantiy IS NULL;

SELECT * FROM retail_sales
WHERE price_per_unit IS NULL;

SELECT * FROM retail_sales
WHERE cogs IS NULL;

SELECT * FROM retail_sales
WHERE total_sale IS NULL;

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;


DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
    
SELECT * FROM retail_sales;

-- Data Exploration 
-- How many Sales we have
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many UNIQUE Customers we have?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

-- DATA ANALYSIS
SELECT 
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales
WHERE 
    gender = 'Female'
GROUP BY 
    category
ORDER BY 
    total_sales DESC;

USE sql_project_p1;
CREATE TABLE customers AS
SELECT DISTINCT 
    customer_id,
    gender,
    age
FROM retail_sales
WHERE customer_id IS NOT NULL;

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

SELECT customer_id, COUNT(*) AS count
FROM customers
GROUP BY customer_id
HAVING count > 1;

DROP TABLE IF EXISTS customers;

CREATE TABLE customers AS
SELECT 
    customer_id,
    gender,
    age
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id) AS rn
    FROM retail_sales
    WHERE customer_id IS NOT NULL
) AS sub
WHERE rn = 1;

DROP TABLE IF EXISTS customers;

CREATE TABLE customers AS
SELECT 
    customer_id,
    gender,
    age
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id) AS rn
    FROM retail_sales
    WHERE customer_id IS NOT NULL
) AS sub
WHERE rn = 1;

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

SELECT 
    rs.transactions_id,
    rs.total_sale,
    c.customer_name,
    c.age
FROM retail_sales rs
INNER JOIN customers c 
    ON rs.customer_id = c.customer_id;
SELECT 
    rs.transactions_id,
    rs.total_sale,
    c.gender,
    c.age
FROM retail_sales rs
INNER JOIN customers c 
    ON rs.customer_id = c.customer_id
LIMIT 1000;

SELECT 
    rs.transactions_id,
    rs.customer_id,
    c.gender,
    c.age
FROM retail_sales rs
LEFT JOIN customers c 
    ON rs.customer_id = c.customer_id
LIMIT 1000;

SELECT 
    c.customer_id,
    c.gender,
    c.age,
    rs.transactions_id,
    rs.total_sale
FROM retail_sales rs
RIGHT JOIN customers c 
    ON rs.customer_id = c.customer_id
LIMIT 1000;

-- Optimizing Queries with Indexes  

-- Index for Joins
-- Index for faster joins on customers
CREATE INDEX idx_customer_id ON customers(customer_id);

-- Index for faster joins on retail_sales
CREATE INDEX idx_customer_id_rs ON retail_sales(customer_id);

CREATE INDEX idx_gender ON customers(gender);
CREATE INDEX idx_age ON customers(age);

-- If you're filtering sales by category or date
CREATE INDEX idx_category ON retail_sales(category);
CREATE INDEX idx_sale_date ON retail_sales(sale_date);

-- Index for GROUP BY or ORDER BY
CREATE INDEX idx_category_group ON retail_sales(category);
CREATE INDEX idx_customer_group ON retail_sales(customer_id);



-- End of Project













