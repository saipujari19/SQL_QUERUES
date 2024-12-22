/* 

Description: 	
	Analyzing the BirthData table in the Births database performing data transformation. It starts with 
    altering column types, moving date information to a new column and then, deleting the old column. 
    The script then runs several analytical queries to understand the births’ count along with states, 
    year, month and specific date values. 
    
*/

-- Switching to the database Births
USE Births;

-- Modifying the Date Column to a VARCHAR Data Type
ALTER TABLE BirthData MODIFY Date VARCHAR(10);

-- Adding a New Column BirthDate with a DATE Data Type
ALTER TABLE BirthData ADD BirthDate DATE;

-- Disables safe updates
SET SQL_SAFE_UPDATES = 0;

-- Updating the 'BirthDate' column with dates from the 'Date' column in the YYYY-MM-DD Format 
UPDATE BirthData SET BirthDate = STR_TO_DATE(Date, '%Y-%m-%d');

-- Enable safe updates
SET SQL_SAFE_UPDATES = 1;

-- Dropping the original 'Date' column from the table
ALTER TABLE BirthData DROP COLUMN Date;

-- 1. Counting the Number of Rows in the Table
SELECT FORMAT(COUNT(*), 0) AS "Number of Rows"
FROM BirthData;

-- 2. Counting the Rows for Each State
SELECT State, FORMAT(COUNT(*), 0) AS "Rows per State"
FROM BirthData
GROUP BY State;

-- 3. Calculating the Total Births per State per Year
SELECT State, YEAR(BirthDate) AS "Year", FORMAT(SUM(Births), 0) AS "Number of Births"
FROM BirthData
GROUP BY State, YEAR(BirthDate);

-- 4. Calculating the Total Births per Month in Massachusetts for 1985
SELECT MONTHNAME(BirthDate) AS "Month", FORMAT(SUM(Births), 0) AS "Number of Births"
FROM BirthData
WHERE State = 'MA' AND YEAR(BirthDate) = 1985
GROUP BY MONTHNAME(BirthDate)
ORDER BY SUM(Births) DESC;

-- 5. Calculating the Average Births per Day in Each Month for 1985 in Massachusetts
SELECT MONTHNAME(BirthDate) AS "Month", 
    FORMAT(SUM(Births) / COUNT(DAY(BirthDate)), 2) AS "Average Births per Day"
FROM BirthData
WHERE State = 'MA' AND YEAR(BirthDate) = 1985
GROUP BY MONTHNAME(BirthDate);

-- 6. Identifying the Months with Total Births Less Than 25,000
SELECT YEAR(BirthDate) AS "Year", MONTHNAME(BirthDate) AS "Month", 
    State, FORMAT(SUM(Births), 0) AS "Number of Births"
FROM BirthData
GROUP BY YEAR(BirthDate), MONTHNAME(BirthDate), State
HAVING 
    SUM(Births) < 25000;

-- 7. Retrieving Birthdates Between 1985-07-14 and 1985-07-15, Ordered by State
SELECT 
    State, 
    CONCAT(LEFT(DATE_FORMAT(BirthDate, '%a'), 3), ' ', DATE_FORMAT(BirthDate, '%Y-%m-%d')) AS "Date", 
    FORMAT(Births, 0) AS "Number of Births"
FROM BirthData
WHERE BirthDate BETWEEN '1985-07-14' AND '1985-07-15'
ORDER BY State, BirthDate;


