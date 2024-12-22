-- Switch to the "BookList" database to ensure all operations are performed in the correct context
USE BookList;

-- Insert new authors into the Author table
INSERT INTO Author (author_fn, author_ln) VALUES 
('Haruki', 'Murakami'),    -- Author 1
('Kazuo', 'Ishiguro'),     -- Author 2
('Margaret', 'Atwood');    -- Author 3

-- Insert new genres into the Genre table
INSERT INTO Genre (genre_desc) VALUES 
('Contemporary Fiction'),  -- Genre 1
('Dystopian'),             -- Genre 2
('Literary Fiction');      -- Genre 3

-- Insert 10 books with updated details into the Book table
INSERT INTO Book (author_id, genre_id, book_title, pages, retail_price, quantity_in_stock, year_of_publication)
VALUES 
(1, 1, 'Norwegian Wood', 296, 13.99, 25, 1987),
(1, 3, 'Kafka on the Shore', 505, 16.50, 20, 2002),
(2, 2, 'Never Let Me Go', 288, 14.00, 15, 2005),
(2, 2, 'The Remains of the Day', 258, 12.50, 12, 1989),
(3, 1, 'The Handmaid\'s Tale', 311, 15.99, 18, 1985),
(3, 2, 'Oryx and Crake', 376, 17.50, 22, 2003),
(1, 3, '1Q84', 925, 22.99, 10, 2009),
(2, 1, 'Klara and the Sun', 320, 18.00, 14, 2021),
(3, 3, 'Alias Grace', 468, 16.00, 20, 1996),
(1, 1, 'Dance Dance Dance', 400, 14.50, 30, 1988);

-- Select all data from all tables to verify the inserted records
SELECT * FROM Author;
SELECT * FROM Genre;
SELECT * FROM Book;
SELECT * FROM Summary;

-- Display all data sorted by author last name, with additional computed columns
SELECT 
    CONCAT(a.author_fn, ' ', a.author_ln) AS full_name, 
    a.author_id,
    g.genre_desc,
    g.genre_id,
    b.book_title,
    b.book_id,
    b.pages,
    b.year_of_publication,
    b.retail_price,
    b.quantity_in_stock,
    (b.retail_price * b.quantity_in_stock) AS extended_value
FROM 
    Book b
JOIN 
    Author a ON b.author_id = a.author_id
JOIN 
    Genre g ON b.genre_id = g.genre_id
ORDER BY 
    a.author_ln;

-- Find the last book written by each author based on the year of publication
SELECT 
    CONCAT(a.author_fn, ' ', a.author_ln) AS full_name,
    a.author_id,
    b.book_title,
    b.pages,
    b.year_of_publication
FROM 
    Book b
JOIN 
    Author a ON b.author_id = a.author_id
WHERE 
    (b.author_id, b.year_of_publication) IN 
    (SELECT author_id, MAX(year_of_publication) 
     FROM Book 
     GROUP BY author_id);

-- Count the number of books written by each author
SELECT 
    CONCAT(a.author_fn, ' ', a.author_ln) AS full_name, 
    a.author_id, 
    COUNT(b.book_id) AS number_of_books
FROM 
    Author a
LEFT JOIN 
    Book b ON a.author_id = b.author_id
GROUP BY 
    a.author_id;

-- Display total stock by genre and individual book details with quantities
SELECT 
    g.genre_desc AS GENRE, 
    '' AS TITLE, 
    '' AS QIS, 
    SUM(b.quantity_in_stock) AS TOTAL
FROM 
    Genre g
JOIN 
    Book b ON g.genre_id = b.genre_id
GROUP BY 
    g.genre_desc
UNION
SELECT 
    g.genre_desc AS GENRE, 
    b.book_title AS TITLE, 
    b.quantity_in_stock AS QIS, 
    NULL AS TOTAL
FROM 
    Genre g
JOIN 
    Book b ON g.genre_id = b.genre_id
ORDER BY 
    GENRE, TITLE;

-- Create a stored procedure to calculate and insert inventory value by genre into the Summary table
DELIMITER $$

CREATE PROCEDURE InsertInventorySummary()
BEGIN
    -- Clear the previous summary data
    DELETE FROM Summary;
    
    -- Insert new summary data, grouped by genre
    INSERT INTO Summary (genre_id, value)
    SELECT 
        genre_id, 
        SUM(quantity_in_stock * retail_price) AS total_inventory_value
    FROM 
        Book
    GROUP BY 
        genre_id;
END$$

DELIMITER ;

-- Execute the stored procedure to update the Summary table
CALL InsertInventorySummary();

-- Display the summary table with genre descriptions and computed inventory values
SELECT 
    g.genre_desc, 
    s.value  
FROM  
    Summary s
JOIN 
    Genre g ON s.genre_id = g.genre_id;
