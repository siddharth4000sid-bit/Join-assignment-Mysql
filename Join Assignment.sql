Drop database if exists join_database;
CREATE DATABASE join_database;
USE join_database;

-- create two tables table1 and table2

CREATE TABLE table1 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    phone_number VARCHAR(15)
);

CREATE TABLE table2 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10, 2),
    address VARCHAR(100)
);

-- Insert Data into the Tables

-- Insert data into table1
INSERT INTO table1 (id, first_name, last_name, city, phone_number) VALUES
(1, 'Rahul', 'Sharma', 'Delhi', '9876543210'),
(2, 'Priya', 'Verma', 'Mumbai', '8765432109'),
(3, 'Amit', 'Patel', 'Ahmedabad', '7654321098'),
(4, 'Anjali', 'Singh', 'Kolkata', '6543210987'),
(5, 'Vijay', 'Kumar', 'Bangalore', '5432109876');

-- Insert data into table2
INSERT INTO table2 (id, first_name, last_name, city, salary, address) VALUES
(3, 'Amit', 'Patel', 'Ahmedabad', 75000.00, 'Street 21, Ahmedabad, Gujarat'),
(4, 'Anjali', 'Singh', 'Kolkata', 82000.00, 'Park Street, Kolkata, West Bengal'),
(5, 'Vijay', 'Kumar', 'Bangalore', 92000.00, 'MG Road, Bangalore, Karnataka'),
(6, 'Sanjay', 'Reddy', 'Hyderabad', 70000.00, 'Banjara Hills, Hyderabad, Telangana'),
(7, 'Megha', 'Iyer', 'Chennai', 88000.00, 'Anna Nagar, Chennai, Tamil Nadu');


-- Find people whose IDs appear in both table1 and table2
-- Use WHERE to keep only people whose salary is greater than 75000.
-- Display ID, first name, city, phone number and salary. Use ORDER BY to show the highest salary first.

SELECT
    table1.id,
    table1.first_name,
    table1.city,
    table1.phone_number,
    table2.salary
FROM table1
INNER JOIN table2
ON table1.id = table2.id
WHERE table2.salary > 75000
ORDER BY table2.salary DESC;

-- LEFT JOIN with a city filter
-- Use a LEFT JOIN to show people from table1 whose city is Delhi, Kolkata or Bangalore.
-- Display ID, first name and city from table1, along with salary and address from table2.
-- Keep people even when they have no match in table2. Filter using WHERE and sort by the table1 ID in ascending order
SELECT
    table1.id,
    table1.first_name,
    table1.city,
    table2.salary,
    table2.address
FROM table1
LEFT JOIN table2
ON table1.id = table2.id
WHERE table1.city IN ('Delhi', 'Kolkata', 'Bangalore')
ORDER BY table1.id ASC;

-- RIGHT JOIN with sorting and a row limit
-- Use a RIGHT JOIN to show people from table2 whose salary is at least 80000. Include them even if they have no match in table1

-- Display ID and first name from table2, salary and the phone number from table1.
-- Use WHERE to filter, ORDER BY to sort salary from highest to lowest, and LIMIT to show only the first 2 rows.

SELECT
    table2.id,
    table2.first_name,
    table2.salary,
    table1.phone_number
FROM table1
RIGHT JOIN table2
ON table1.id = table2.id
WHERE table2.salary >= 80000
ORDER BY table2.salary DESC
LIMIT 2;


-- Write a MySQL-compatible query that returns all people from both tables, including people found in only one table

-- Show matching IDs once. Display one combined ID, first name, phone number and salary.
-- Combine outer-join results to produce the full result. Sort the final combined result by ID in ascending order.

SELECT
    table1.id,
    table1.first_name,
    table1.phone_number,
    table2.salary
FROM table1
LEFT JOIN table2
ON table1.id = table2.id

union

SELECT
    table2.id,
    table2.first_name,
    table2.salary,
    table1.phone_number
FROM table1
RIGHT JOIN table2
ON table1.id = table2.id
ORDER BY id ASC;


-- Create every possible pair between a person from table1 and a person from table2 using CROSS JOIN.
-- Display both IDs and both first names. Use aliases so that the output columns are easy to identify.
-- Sort first by the table1 ID and then by the table2 ID, both ascending. Use LIMIT to display the first 10 pairs. How many pairs exist before LIMIT is applied?

SELECT
    t1.id AS table1_id,
    t1.first_name AS table1_first_name,
    t2.id AS table2_id,
    t2.first_name AS table2_first_name
FROM table1 t1
CROSS JOIN table2 t2
ORDER BY
    t1.id ASC,
    t2.id ASC
LIMIT 10;

SELECT COUNT(*) AS total_pairs
FROM table1
CROSS JOIN table2;

