/*

DESCRIPTION:
	Sets up a trigger BeforeInsertBirthData to automatically populate Year, Month, Day, and DayOfWeek columns
    based on the Date column whenever new rows are inserted into the BirthData table. It also creates a stored 
    procedure GetTotalBirths that calculates the total number of births for a specified state and outputs the 
    result. The procedure is tested using the state NH, and the result is stored in and displayed from a variable.

*/

-- Switch to the `births` database
USE births;

-- Drop the existing trigger if it exists to avoid errors during recreation
DROP TRIGGER IF EXISTS BeforeInsertBirthData;

-- Set the delimiter to allow defining a trigger
DELIMITER //

-- Create a trigger to execute logic before inserting rows into the `BirthData` table
CREATE TRIGGER BeforeInsertBirthData
BEFORE INSERT ON BirthData
FOR EACH ROW
BEGIN
    -- Extract and set the Year component from the Date column
    SET NEW.Year = YEAR(NEW.Date);

    -- Extract and set the Month component from the Date column
    SET NEW.Month = MONTH(NEW.Date);

    -- Extract and set the Day component from the Date column
    SET NEW.Day = DAY(NEW.Date);

    -- Extract and set the Day of the Week (e.g., Mon, Tue) from the Date column
    SET NEW.DayOfWeek = DATE_FORMAT(NEW.Date, '%a');
END;
//

-- Reset the delimiter to the default
DELIMITER ;

-- Insert rows into the `BirthData` table with Date, State, and Births
-- The trigger will automatically populate Year, Month, Day, and DayOfWeek
INSERT INTO BirthData (State, Date, Births)
VALUES
('NH', '1986-10-01', 211),
('NH', '1986-10-02', 205),
('NH', '1986-10-03', 310),
('NH', '1986-10-04', 410),
('NH', '1986-10-05', 153);

-- Select rows to verify the trigger worked correctly and set Year, Month, Day, and DayOfWeek
SELECT *
FROM BirthData
WHERE Date BETWEEN '1986-10-01' AND '1986-10-05'
  AND State = 'NH';

-- Drop the existing stored procedure if it exists to avoid errors during recreation
DROP PROCEDURE IF EXISTS GetTotalBirths;

-- Set the delimiter to allow defining a stored procedure
DELIMITER //

-- Create a stored procedure to calculate the total number of births for a given state
CREATE PROCEDURE GetTotalBirths(
    IN stateCode VARCHAR(2),      -- Input parameter: State code 
    OUT totalBirths INT           -- Output parameter: Total births in the state
)
BEGIN
    -- Calculate the sum of births for the specified state and store it in the output variable
    SELECT SUM(Births)
    INTO totalBirths
    FROM BirthData
    WHERE State = stateCode;
END;
//

-- Reset the delimiter to the default
DELIMITER ;

-- Declare a variable to store the total births output
SET @totalBirths = 0;

-- Call the stored procedure with input "NH" and store the result in @totalBirths
CALL GetTotalBirths('NH', @totalBirths);

-- Select the total births for state "NH" to display the result
SELECT FORMAT(@totalBirths, 0) AS Total_Births_NH;


