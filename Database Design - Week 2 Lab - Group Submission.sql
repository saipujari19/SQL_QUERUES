/* Description: The SQL script imports the data from the CSV file, counts number of rows in the table, 
provide instructions for disabling safe updates temporarily to allow modifying DayOfWeek values, changing 
Tues to Tue and Thurs to Thu. After updating, it counts rows where the birth count is below 50.
*/

-- Using the created 'Births' database for subsequent operations
USE Births;

-- Importing the data from the CSV file

-- Retrives all the inserted data records into the BirthData table
Select * FROM BirthData;

-- Count the number of rows in the BirthData table
SELECT COUNT(*) FROM BirthData;

-- Disables safe updates
SET SQL_SAFE_UPDATES = 0;

-- Update DayOfWeek values to three-character abbreviations
UPDATE BirthData
SET DayOfWeek = CASE 
    WHEN DayOfWeek = 'Tues' THEN 'Tue'
    WHEN DayOfWeek = 'Thurs' THEN 'Thu'
    ELSE DayOfWeek
END;
Select * FROM BirthData;

-- Enable safe updates
SET SQL_SAFE_UPDATES = 1;

-- Select statement to count rows with fewer than 50 births
SELECT COUNT(*) FROM BirthData WHERE Births < 50;