#1 The SELECT statement allows you to describe to MySQL exactly what data you want it to retrieve.

SELECT * FROM Fruit;

# 2.	Tell MySQL to return only those columns that you want to return. 
#This is done by naming only those columns that you'd like to have returned.
SELECT FruitId, FruitName 
FROM Fruit;

#3 We can add the WHERE clause to narrow the result set down to only those records that you're interested in.

SELECT * FROM Fruit
WHERE UnitId = 1;

# 4 Using sub queries this will enable us to use the actual unit name (rather than its ID) because the second table contains this in the UnitName field:

SELECT * FROM Fruit
WHERE UnitId = 
	(SELECT UnitId 
    FROM Units 
    WHERE UnitName = 'Piece');
    
# 5 We could rewrite our subquery using the Inner join and from clause.

SELECT Fruit.* FROM Fruit
INNER JOIN Units
ON Fruit.UnitId = Units.UnitId
WHERE Units.UnitName = 'Piece';

# 6  the > operator to select data that is greater than a given value.

SELECT * FROM Fruit
WHERE Inventory > 10;

# 7 the < operator to select data that is less than a given value.

SELECT * FROM Fruit
WHERE Inventory < 10;

# 8 the <> operator to select data that is both less than and greater than a given value.

SELECT * FROM Fruit
WHERE Inventory <> 10;

# 9 the >= operator to select data that is greater than or equal to a given value.

SELECT * FROM Fruit
WHERE Inventory >= 10;

# 10 the <= operator to select data that is less than or equal to a given value.

SELECT * FROM Fruit
WHERE Inventory <= 10;

# 11 We can add an AND operator to the WHERE clause in order to limit your selection to only those records that meet two conditions (or more if you include more AND operators).

SELECT * FROM Fruit
WHERE Inventory > 10 
AND DateEntered > '2015-01-15';

# 12 We can use an OR operator to broaden your selection to more than one criteria. As the name suggests, the OR clause lets you select data where the criteria is either this OR that. So, the AND operator limits your selection, and the OR operator broadens it.

SELECT * FROM Fruit
WHERE UnitId = 1 OR UnitId = 2;

# 13 the BETWEEN operator to select data that is between two given values.

SELECT * FROM Fruit
WHERE DateEntered 
BETWEEN '2015-01-25' AND '2015-02-25';

# 14 the NOT operator to select data that is not equivalent to a given condition.

SELECT * FROM Fruit
WHERE NOT (FruitName = 'Apple');

# 15 If we run the following code against the FruitShop database using the view.

CREATE VIEW vFruitInventory AS
SELECT 
    Fruit.FruitName,
    Fruit.Inventory,
    Units.UnitName
FROM
	Fruit INNER JOIN Units ON
    Fruit.UnitId = Units.UnitId;
    
# 16 using the select statement.

SELECT * FROM vFruitInventory;

SELECT FruitName 
FROM vFruitInventory
WHERE Inventory <= 10;

SELECT * 
FROM Fruit
WHERE FruitId = 1;

# 17 We can modify a view by using the ALTER VIEW statement. Let's add the Fruit.FruitId field to the view.

ALTER VIEW vFruitInventory AS
SELECT 
	Fruit.FruitId,
    Fruit.FruitName,
    Fruit.Inventory,
    Units.UnitName
FROM
	Fruit INNER JOIN Units ON
    Fruit.UnitId = Units.UnitId;
    
# 18 Creating or replacing the view.

CREATE OR REPLACE VIEW vFruitInventory AS
SELECT 
    Fruit.FruitName,
    Fruit.Inventory,
    Units.UnitName
FROM
	Fruit INNER JOIN Units ON
    Fruit.UnitId = Units.UnitId;
    
CREATE OR REPLACE VIEW vFruitInventory AS
SELECT 
	Fruit.FruitId,
    Fruit.FruitName,
    Fruit.Inventory,
    Units.UnitName
FROM
	Fruit INNER JOIN Units ON
    Fruit.UnitId = Units.UnitId;
    
# 19. dropping the view table.

DROP VIEW vFruitInventory;

# creating the database and using the database
Create DATABASE country_city_db;

USE country_city_db;

# creating the table.

CREATE TABLE country (
    country_id SMALLINT(5) PRIMARY KEY,
    country VARCHAR(50) NOT NULL
    
);

CREATE TABLE city (
    city_id SMALLINT(5) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    country_id SMALLINT(5) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

# inserting the data into the table

INSERT INTO country (country_id, country) VALUES
(1, 'United States'),
(2, 'Canada'),
(3, 'Mexico');

INSERT INTO city (city_id, city, country_id) VALUES
(1, 'New York', 1),
(2, 'Los Angeles', 1),
(3, 'Toronto', 2),
(4, 'Mexico City', 3);

# 20 using inner join

SELECT city, country
FROM city
INNER JOIN country ON
city.country_id = country.country_id;

# 21 using alias

SELECT city, country
FROM city a
INNER JOIN country b ON
a.country_id = b.country_id;

# 22 we use the COUNT() aggregate function to count the number of cities for each country, then the GROUP BY clause to group the results by country.

SELECT country, COUNT(city)
FROM country a
INNER JOIN city b
ON a.country_id = b.country_id
GROUP BY country;

# creating the database. and using it.

CREATE DATABASE customer_actor_db;
USE customer_actor_db;

# creating the table.

CREATE TABLE customer (
    customer_id SMALLINT(5) PRIMARY KEY,
    store_id TINYINT(3) NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(50) NOT NULL,
    address_id SMALLINT(5) NOT NULL,
    active TINYINT(1) DEFAULT 1
    
);

CREATE TABLE actor (
    actor_id SMALLINT(5) PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL
    
);

# inserting data into table

INSERT INTO customer (customer_id, store_id, first_name, last_name, email, address_id, active) VALUES
(1, 1, 'John', 'Doe', 'johndoe@example.com', 101, 1),
(2, 2, 'Jane', 'Smith', 'janesmith@example.com', 102, 1);

INSERT INTO actor (actor_id, first_name, last_name) VALUES
(1, 'Tom', 'Hanks'),
(2, 'Meryl', 'Streep');

# 23 using left join, right join and inner join and order by clause

SELECT 
	c.customer_id, 
    c.first_name, 
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer c
LEFT JOIN actor a 
ON c.last_name = a.last_name
ORDER BY c.last_name;

SELECT 
	c.customer_id, 
    c.first_name, 
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer c
RIGHT JOIN actor a 
ON c.last_name = a.last_name
ORDER BY c.last_name;

SELECT 
	c.customer_id, 
    c.first_name, 
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer c
INNER JOIN actor a 
ON c.last_name = a.last_name
ORDER BY c.last_name;

# creating and using database
CREATE DATABASE film_db;
USE film_db;

# creating the table
CREATE TABLE actor (
    actor_id SMALLINT(5) PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL
);

CREATE TABLE film (
    film_id SMALLINT(5) PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE film_actor (
    actor_id SMALLINT(5) NOT NULL,
    film_id SMALLINT(5) NOT NULL,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

CREATE TABLE payment (
    payment_id SMALLINT(5) PRIMARY KEY,
    customer_id SMALLINT(5) NOT NULL,
    amount DECIMAL(5,2) NOT NULL,
    payment_date DATETIME NOT NULL
);

CREATE TABLE ace_goldfinger_actors (
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);

# inserting data into the table
INSERT INTO actor (actor_id, first_name, last_name) VALUES
(1, 'Tom', 'Hanks'),
(2, 'Meryl', 'Streep'),
(3, 'Brad', 'Pitt');

INSERT INTO film (film_id, title) VALUES
(1, 'Ace Goldfinger'),
(2, 'The Matrix'),
(3, 'Inception');

INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1),
(2, 1),
(3, 2);

INSERT INTO payment (payment_id, customer_id, amount, payment_date) VALUES
(1, 101, 19.99, '2023-11-16'),
(2, 101, 9.99, '2023-11-17'),
(3, 102, 14.99, '2023-11-16'),
(4, 102, 29.99, '2023-11-17');

# 24.using the sub query

SELECT * FROM actor
WHERE actor_id IN 
	(SELECT actor_id FROM film_actor
	WHERE film_id = 2);


# 25 nested sub query    
SELECT * FROM actor
WHERE actor_id IN 
	(SELECT actor_id FROM film_actor
	WHERE film_id = 
		(SELECT film_id FROM film 
		WHERE title = 'Ace Goldfinger')
	);
    

INSERT INTO ace_goldfinger_actors (first_name, last_name)
    SELECT first_name, last_name FROM actor a
		INNER JOIN film_actor fa ON
			a.actor_id = fa.actor_id
		WHERE fa.film_id = 
			(SELECT film_id FROM film 
			WHERE title = 'Ace Goldfinger');
            


-- Create a fresh table
DROP TABLE IF EXISTS ace_goldfinger_actors;
CREATE TABLE ace_goldfinger_actors
(first_name VARCHAR(45), last_name VARCHAR(45));

-- Insert Data (from the following subqueries)
INSERT INTO ace_goldfinger_actors (first_name, last_name)
	
    -- Subquery
    SELECT first_name, last_name FROM actor a
		INNER JOIN film_actor fa ON
			a.actor_id = fa.actor_id
		WHERE fa.film_id = 
			
            -- Nested Subquery
			(SELECT film_id FROM film 
			WHERE title = 'Ace Goldfinger');
    
-- Check the data that we just inserted
SELECT * FROM ace_goldfinger_actors;

# 28 derived tables
SELECT AVG(a) FROM 
	(SELECT 
		customer_id,
		SUM(amount) a
	FROM payment
	GROUP BY customer_id) AS totals;