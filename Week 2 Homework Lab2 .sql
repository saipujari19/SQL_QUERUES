/* Description: 
 Create a database named StudentsDB, and a table called Students that has columns student_id, 
 first_name, last_name, date_of_birth, and major. Inserting and importing data records. Updating specific 
 attributes for multiple records, deleting a record, and retrieving the updated data records.
*/
-- Drp the database
DROP DATABASE IF EXISTS StudentsDB;

-- Create the database named 'StudentsDB'
CREATE DATABASE IF NOT EXISTS StudentsDB;

-- Switch to using the 'StudentsDB' database
USE StudentsDB;

-- Create a table named 'Student' if it doesn't already exist
-- The table contains columns for student ID, first name, last name, date of birth, and major

CREATE TABLE IF NOT EXISTS Student(
  student_id INT AUTO_INCREMENT PRIMARY KEY,  
  first_name VARCHAR(50) NOT NULL,            
  last_name VARCHAR(50) NOT NULL,              
  date_of_birth DATE NOT NULL,                
  major VARCHAR(50) NOT NULL                  
);

-- Insert five rows of data into the 'Student' table
INSERT INTO Student (student_id, first_name, last_name, date_of_birth, major)
VALUES 
(1, 'John', 'Doe', '1999-05-12', 'Computer Science'),
(2, 'Jane', 'Smith', '2000-08-22', 'Mathematics'),
(3, 'Michael', 'Johnson', '1998-12-15', 'Physics'),
(4, 'Emily', 'Davis', '2001-03-10', 'Biology'),
(5, 'Daniel', 'Brown', '1997-07-30', 'Chemistry');

-- Select all rows from the 'Student' table to display the inserted data
SELECT * FROM Student;

-- Create a csv file and Import the data from the spreadsheet into the table

-- Select all rows from the 'Student' table to display the inserted data
SELECT * FROM Student;

 -- This SQL command updates the first name to 'Alex' and the last name to 'Smith' for the student with an ID of 1 in the Students table.
UPDATE Student
SET first_name = 'Alex', last_name = 'Smith'
WHERE student_id = 1; 

-- This command updates the 'major' attribute to 'Data Science' for students with IDs 2, 3, and 4 in the Students table.
UPDATE Student
SET major = 'Data Science'  
WHERE student_id IN (2, 3, 4);  

-- This command retrieves all updated rows and columns from the Students table.
SELECT * FROM Student;

-- This command deletes the row from the Students table where the student_id is 5.
DELETE FROM Student
WHERE student_id = 5;  

-- This command retrieves all updated rows and columns from the Students table.
SELECT * FROM Student;





