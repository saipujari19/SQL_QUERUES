-- Create the BookList database if it does not exist and switch to it
CREATE DATABASE IF NOT EXISTS BookList;
USE BookList;
 
-- Create the Author table to store author details
CREATE TABLE Author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,       -- Unique ID for each author
    author_fn VARCHAR(50) NOT NULL,                -- First name of the author (mandatory)
    author_ln VARCHAR(50) NOT NULL                 -- Last name of the author (mandatory)
);

-- Create the Genre table to store genre descriptions
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,       -- Unique ID for each genre
    genre_desc VARCHAR(50) NOT NULL                -- Description of the genre (mandatory)
);

-- Create the Book table to store book details
CREATE TABLE Book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each book
    author_id INT,                                 -- References the Author table
    genre_id INT,                                  -- References the Genre table
    book_title VARCHAR(100) NOT NULL,             -- Title of the book (mandatory)
    pages INT CHECK (pages > 0),                  -- Number of pages (must be positive)
    retail_price DECIMAL(10, 2) DEFAULT 10.00,    -- Default retail price is $10.00
    quantity_in_stock INT DEFAULT 0,              -- Default stock quantity is 0
    year_of_publication YEAR NOT NULL,            -- Year the book was published (mandatory)
    FOREIGN KEY (author_id) REFERENCES Author(author_id), -- Foreign key constraint to Author table
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)     -- Foreign key constraint to Genre table
);

-- Create the Summary table to store summary information by genre
CREATE TABLE Summary (
    genre_id INT,                                  -- References the Genre table
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically captures the current time
    value DECIMAL(10, 2),                         -- Placeholder for computed value
    PRIMARY KEY (genre_id),                       -- Unique key for each genre
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) -- Foreign key constraint to Genre table
);

-- Create a trigger to format author names to uppercase before inserting into the Author table
DELIMITER $$
CREATE TRIGGER before_insert_author
BEFORE INSERT ON Author
FOR EACH ROW
BEGIN
    SET NEW.author_fn = UPPER(NEW.author_fn); -- Convert the first name to uppercase
    SET NEW.author_ln = UPPER(NEW.author_ln); -- Convert the last name to uppercase
END$$
DELIMITER ;

-- Create a trigger to format genre descriptions to lowercase before inserting into the Genre table
DELIMITER $$
CREATE TRIGGER before_insert_genre
BEFORE INSERT ON Genre
FOR EACH ROW
BEGIN
    SET NEW.genre_desc = LOWER(NEW.genre_desc); -- Convert the genre description to lowercase
END$$
DELIMITER ; 

-- Create a trigger to compute total value after a book is inserted into the Book table
DELIMITER $$
CREATE TRIGGER after_insert_book
AFTER INSERT ON Book
FOR EACH ROW
BEGIN
    DECLARE total_value DECIMAL(10,2) DEFAULT 0; -- Variable to hold the computed value
    SET total_value = NEW.retail_price * NEW.quantity_in_stock; -- Calculate the total value of the inserted book
    -- The value can be used for further operations (e.g., updating another table)
END$$
DELIMITER ;
