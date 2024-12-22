SELECT FruitId, FruitName  #using select statement 
FROM Fruit;

SELECT * FROM Fruit  # using select and where and setting unit id to 1
WHERE UnitId = 1;

SELECT * FROM Fruit
WHERE UnitId = 
	(SELECT UnitId 
    FROM Units 
    WHERE UnitName = 'Piece');
    
    SELECT Fruit.* FROM Fruit   # using inner join
INNER JOIN Units
ON Fruit.UnitId = Units.UnitId
WHERE Units.UnitName = 'Piece';

# using operators such as lesser, greater not equal and lesser than equal to operator.

SELECT * FROM Fruit
WHERE Inventory > 10;

SELECT * FROM Fruit
WHERE Inventory < 10;

SELECT * FROM Fruit
WHERE Inventory <> 10;

SELECT * FROM Fruit
WHERE Inventory <= 10;

SELECT * FROM Fruit
WHERE Inventory >= 10;

SELECT * FROM Fruit
WHERE Inventory > 10 
AND DateEntered > '2015-01-15';

# using or, and, not operator

SELECT * FROM Fruit
WHERE UnitId = 1 OR UnitId = 2;

SELECT * FROM Fruit
WHERE DateEntered 
BETWEEN '2015-01-25' AND '2015-02-25';

SELECT * FROM Fruit
WHERE NOT (FruitName = 'Apple');

# creating database and using it.

create database employeedb;
use employeedb;

# drop table employee;
# truncate table employee;

CREATE TABLE employee( # table ceation
emp_id INT,
frist_name VARCHAR(40),
last_name VARCHAR(40),
birth_date DATE,
sex VARCHAR(1),
salary FLOAT,
branch_id INT,
PRIMARY KEY(emp_id)
);

INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL); # inserting into table.

UPDATE employee # updating table
SET branch_id = 1
WHERE emp_id = 100;

# insertion statemt to insert data into the table.

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000,1);
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, NULL);

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

# insertion statemt to insert data into the table.

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000,2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 2);
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, NULL);

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

# insertion statemt to insert data into the table.

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 3);

# select statement to display the contents. 
SELECT * FROM employee;

SELECT * FROM employee # using order by clause and DESc
ORDER BY salary DESC;

SELECT * FROM
employee
ORDER BY sex, frist_name, last_name;

SElECT * FROM # using like operator and __10%
employee
WHERE birth_date LIKE '____-10%';

SELECT * from employee   #using order by clause and like operator
WHERE frist_name LIKE 'An%'
ORDER BY frist_name, last_name;

SELECT * from employee
WHERE frist_name LIKE 'An%'
ORDER BY frist_name, last_name DESC;


UPDATE employee    #updating the table
SET frist_name = 'Nicky'
WHERE branch_id = 2;

SELECT    # to find the char length.
	last_name, 
    CHAR_LENGTH(last_name),
    CHARACTER_LENGTH(last_name)
FROM employee;


SELECT   # to find the char length using concat_ws
	frist_name, 
	last_name,
    CONCAT_WS(',',frist_name, last_name)
FROM employee;



SELECT     # to find the char length.
	last_name, 
    CHAR_LENGTH(last_name) 'Character Count',
    LENGTH(last_name) 'Latin1 (Bytes)',
    LENGTH(CONVERT(last_name USING ucs2)) 'UCS-2 (Bytes)',
    LENGTH(CONVERT(last_name USING utf32)) 'UTF-32 (Bytes)'
FROM employee;

SELECT last_name   # using group by clause
FROM employee
GROUP BY last_name;

SELECT last_name, COUNT(*) 
FROM employee
GROUP BY last_name;


CREATE TABLE customer (     # creating table customer
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

INSERT INTO customer (first_name, last_name, email) # inserting data into table
VALUES 
    ('John', 'Doe', 'john.doe@example.com'),
    ('Jane', 'Smith', 'jane.smith@example.com'),
    ('Michael', 'Brown', 'michael.brown@example.com'),
    ('Emily', 'Johnson', 'emily.johnson@example.com');
    
    select * from customer; # select statement
    select * from employee;
    
SELECT 	customer_id AS 'Customer ID',  #inner join and used group by
		first_name AS 'First Name'
FROM customer
	INNER JOIN employee ON
	customer_id = customer_id
GROUP BY customer_id;

SELECT last_name, COUNT(*)    #used group by and having clause
FROM employee
GROUP BY last_name
HAVING COUNT(*) > 3;


SELECT 	customer_id AS 'Customer ID',    #used group by and having clause and also order by 
		first_name AS 'First Name'
FROM customer
	INNER JOIN employee ON
	customer_id = customer_id
GROUP BY customer_id
HAVING SUM(Salary) > 100
ORDER BY SUM(Salary) DESC;

SELECT COUNT(*)  #using count
FROM employee;

SELECT COUNT(*)   #using count and like operator
FROM customer
WHERE first_name like 'B%';

SELECT * 
FROM customer
WHERE first_name like 'B%';
    
    SELECT COUNT(last_name) 
FROM employee;

SELECT COUNT(DISTINCT last_name)    #using count and distinct to identify uniquely
FROM customer;

SELECT last_name, COUNT(*)  # using group by and having clause
FROM employee
GROUP BY last_name;

SELECT last_name, COUNT(*) 
FROM customer
GROUP BY last_name
HAVING COUNT(*) > 3;

# using distinct and like operator
SELECT frist_name 
FROM employee
WHERE frist_name LIKE 'An%';

SELECT DISTINCT first_name 
FROM customer
WHERE first_name LIKE 'An%';

SELECT COUNT(DISTINCT first_name)   # using distinct and like operator
FROM customer
WHERE first_name LIKE 'An%';

SELECT COUNT(DISTINCT first_name) # using distinct and like operator
FROM customer
WHERE first_name LIKE 'An%';

SELECT DISTINCT first_name, last_name
FROM customer
WHERE first_name LIKE 'jo%';

SELECT COUNT(DISTINCT first_name)   # using count operator
FROM customer;

SELECT COUNT(DISTINCTROW first_name)   # using count operator
FROM customer;

SELECT SUM(salary)  # using sum
FROM employee;

SELECT         # using count operator
ROUND(SUM(Salary) / 60) 
AS 'Total pay'
FROM employee;

SELECT SUM(salary)   # using count operator
FROM employee
WHERE emp_id = 1;

SELECT 	customer_id AS 'Customer ID',    # inner join, using group by and order by clause as well.
		first_name AS 'First Name'
FROM customer
	INNER JOIN employee ON
	customer_id = customer_id
GROUP BY customer_id
HAVING SUM(Salary) > 100
ORDER BY SUM(Salary) DESC;
