CREATE DATABASE College;

-- Step 1: Create the Courses table with PRIMARY KEY
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Duration INT DEFAULT 3
);

-- Step 2: Create the Students table with FOREIGN KEY to Courses
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Age INT NOT NULL DEFAULT 18,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Step 3: Insert two rows into Courses
INSERT INTO Courses (CourseID, CourseName) VALUES (101, 'Data Science'), (102, 'Software Engineering');

-- Step 4: Insert five rows into Students
INSERT INTO Students (StudentID, StudentName, Age, CourseID) VALUES
(1, 'Amit Verma', 20, 101),
(2, 'Sara Khan', 22, 102),
(3, 'Raj Patel', 19, 101),
(4, 'Priya Nair', 18, 102),
(5, 'Vikas Reddy', 21, 101);

-- Step 5: SELECT all rows from both tables
SELECT * FROM Courses;
SELECT * FROM Students; 
