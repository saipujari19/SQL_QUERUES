--BASIC SQL QUERIES


--CREATE TABLE EmployeeDemographics(
--Employee_id int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--)


--CREATE TABLE EmployeeSalary(
--Employee_id int,
--JobTitle varchar(50),
--Salary int
--)

--INSERT INTO EmployeeDemographics VALUES
--(1001, 'jim', 'Halpert', 30, 'Male'),
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')

--INSERT INTO EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)

--SELECT *
--FROM EmployeeDemographics


--SELECT Employee_id, Age
--FROM EmployeeDemographics


--SELECT  TOP 5 *
--FROM EmployeeDemographics  --TOP IS USED TO SELECT ONLY CERTAIN AMOUNT OF DATA WHEN THERE ARE MILLIONS OF DATA.



SELECT DISTINCT(Gender)    -- to extract unique values we use this. in this case male and female are the only unique.
FROM EmployeeDemographics

SELECT COUNT(Age)           -- count something in a column.
FROM EmployeeDemographics



SELECT COUNT(Age) AS AgeCount         -- count something in a column. AS is used because we dont have the column name.
FROM EmployeeDemographics



SELECT AVG(Salary)       
FROM EmployeeSalary



SELECT MIN(Salary)       
FROM EmployeeSalary


SELECT MAX(Salary)       
FROM EmployeeSalary


SELECT *       -- WHEN WE ARE IN DIFFERENT DATABSE AND TRYING TO ACCESS THE TABLE OF OTHER DATABASE WE CAN USE THIS.
FROM dbo.EmployeeSalary

SELECT * FROM EmployeeSalary
WHERE Salary > 1000

SELECT * FROM EmployeeSalary     -- not equal
WHERE Salary <> 1000

SELECT * FROM EmployeeDemographics   -- for and both needs to be correct. for or any one should be correct.
WHERE Age >= 25 AND Gender = 'Male'


SELECT * FROM EmployeeDemographics         -- LIKE OPERATOR IS USED TO START WITH OR FROM THERE.
WHERE FirstName LIKE 'J%'


SELECT * FROM EmployeeDemographics         -- LIKE OPERATOR IS USED TO START WITH OR BETWEEN WITH THE PERCENT % SIGN.
WHERE LastName LIKE 'J%am%'


SELECT * FROM EmployeeDemographics         -- IN OPERATOR IS USED INSTEAD OF MULTIPLE EQAUL TO OPERATOR
WHERE LastName IN ('Martin', 'Scott')

SELECT Gender,Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender, Age


SELECT Gender,Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE Age> 30
GROUP BY Gender, Age


SELECT * FROM EmployeeDemographics     --BY DEFAULT IT IS ASEC. BUT FOR DESC WE NEED TO MENTION.
ORDER BY Age DESC, Gender DESC          -- EVEN COLUMN NUMBER CAN BE USED INSTEAD OF NAMES (4 - AGE) (5 - GENDER)

SELECT * FROM 
EmployeeDemographics
ORDER BY 4 DESC, 5 DESC

--SELECT Gender, COUNT(Gender) AS GenderCount
--FROM EmployeeDemographics
--WHERE Age> 31
--GROUP BY Gender
--ORDER BY Gender DESC


--Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
--SELECT DISTINCT CITY
--FROM STATION
--WHERE MOD(ID, 2) = 0;

--SELECT EmployeeDemographics.Employee_id, FirstName, LastName, Salary
--FROM EmployeeDemographics
--INNER JOIN
--EmployeeSalary
--ON EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
--WHERE FirstName <> 'Michael'
--ORDER BY Salary DESC


SELECT JobTitle, Salary
FROM EmployeeDemographics
INNER JOIN
EmployeeSalary
ON EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
WHERE JobTitle = 'Salesman'


SELECT JobTitle, AVG(Salary) AS Total
FROM EmployeeDemographics
INNER JOIN
EmployeeSalary
ON EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

--SELECT Employee_id, FirstName, Age -- this is working, but not a correct form as the data are jumbled.
--FROM EmployeeDemographics
--UNION  
--SELECT Employee_id, JobTitle, Salary
--FROM EmployeeSalary
--ORDER BY Employee_id


--CASE STATEMENT

--SELECT FirstName, LastName, Age,
--CASE
-- WHEN Age = 38 THEN 'Stanley' -- this place it works, becaue it becomes the first statement
-- WHEN Age > 30 THEN 'Old'    -- for the multiple statements it only delivers the first case statement. 
-- --WHEN Age = 38 THEN 'Stanley' -- here it wont work
-- --WHEN Age BETWEEN 27 AND 30 THEN 'Young'
-- ELSE 'Youth'
--END
--FROM EmployeeDemographics
--WHERE Age IS NOT NULL
--ORDER BY Age;



SELECT FirstName, LastName,JobTitle, Salary,
CASE
 WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10 )
 WHEN JobTitle = 'Accoutant' THEN Salary + (Salary * .05)
 WHEN JobTitle = 'HR' THEN Salary + (Salary * .00001 )
 ELSE Salary + (Salary * .03)
 END AS Salaryafterraise
FROM EmployeeDemographics
JOIN
EmployeeSalary 
ON EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id

-- HAVING CLAUSE



SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
 JOIN
EmployeeSalary
ON EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
WHERE COUNT(JobTitle) > 1 -- An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list, 
--and the column being aggregated is an outer reference.
GROUP BY JobTitle



SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
 JOIN
EmployeeSalary
ON EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1 


SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
 JOIN
EmployeeSalary
ON EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary) DESC

UPDATE EmployeeDemographics
SET FirstName = 'Tin'
WHERE Employee_id = 1001

DELETE FROM EmployeeDemographics where Employee_id = 1001


INSERT INTO EmployeeDemographics VALUES
(1001, 'jim', 'Halpert', 30, 'Male')


INSERT INTO EmployeeDemographics VALUES
(1010, 'jim', 'king', 35, 'Female')


SELECT * FROM EmployeeDemographics 
ORDER BY Employee_id ASC

UPDATE EmployeeDemographics
SET FirstName = 'Tin'
WHERE Employee_id = 1010


--ALIASING OR AS

SELECT FirstName AS FName  -- WE CAN USE AS OR JUST KEEP SPACE 
FROM EmployeeDemographics 

SELECT FirstName + ' ' + LastName  AS FULLNAME
 FROM EmployeeDemographics

 
SELECT AVG(Age) AS AVGAGE
 FROM EmployeeDemographics

-- ALIASING FOR THE TABLE NAME 
SELECT DEMO.Employee_id, SAL.Salary
FROM EmployeeDemographics AS DEMO
JOIN 
EmployeeSalary AS SAL
ON DEMO.Employee_id = SAL.Employee_id


SELECT * 
FROM EmployeeDemographics DEMO
JOIN EmployeeSalary SAL
ON DEMO.Employee_id = SAL.Employee_id

--PARTITION BY
SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TOTALGENDER
FROM EmployeeDemographics DEMO
JOIN EmployeeSalary SAL
ON DEMO.Employee_id = SAL.Employee_id

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) AS TOTALGENDER
FROM EmployeeDemographics DEMO
JOIN EmployeeSalary SAL
ON DEMO.Employee_id = SAL.Employee_id
GROUP BY FirstName, LastName, Gender, Salary


SELECT FirstName, LastName, Gender, Salary
,COUNT(Gender) OVER (PARTITION BY Gender) AS TOTALGENDER
,AVG(Salary) OVER (PARTITION BY Salary) AS AVGSALARY
FROM EmployeeDemographics AS EMP
JOIN
EmployeeSalary AS SAL
ON EMP.Employee_id = SAL.Employee_id
WHERE Salary > '45000'



--CTE'S
--A Common Table Expression (CTE) in SQL is a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. 
--CTEs are defined using the WITH keyword and allow you to create a named, 
--reusable subquery within your SQL statement.


WITH CTE_EMPLOYEE AS 
(SELECT FirstName, LastName, Gender, Salary
,COUNT(Gender) OVER (PARTITION BY Gender) AS TOTALGENDER
,AVG(Salary) OVER (PARTITION BY Salary) AS AVGSALARY
FROM EmployeeDemographics AS EMP
JOIN
EmployeeSalary AS SAL
ON EMP.Employee_id = SAL.Employee_id
WHERE Salary > '45000')
SELECT * FROM  CTE_EMPLOYEE

--TEMP TABLES(TEMPERORY TABLE)

CREATE TABLE #temp_Employee(
Employee_ID INT,
Jobtitle VARCHAR(50),
Salary INT
) 

SELECT * FROM #temp_Employee


--WHEN WE WANT TO INSERT THE DATA INTO THE TABLE FROM ANOTHER OR ALREDY CREATED TABLE.(EXCLUDING VALUES) 
INSERT INTO #temp_Employee 
SELECT * FROM EmployeeSalary


DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2(
Jobtitle VARCHAR(50),
Employeeperjob int,
Avgage int, 
Avgsalary int
)

INSERT INTO #temp_Employee2
SELECT Jobtitle, count(Jobtitle), avg(age), avg(salary)
FROM EmployeeDemographics
join
EmployeeSalary
on EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
group by JobTitle

SELECT * FROM #temp_Employee2

--STRING FUNCTIONS: TRIM, LTRIM, RTRIM, SUBSTRING, UPPER, LOWER, REPLACE
DROP TABLE IF EXISTS EmployeeErrors
CREATE TABLE EmployeeErrors(
EmployeeID VARCHAR(30),
FirstName VARCHAR(30),
LastName VARCHAR(30)
)

INSERT INTO EmployeeErrors VALUES
('1001   ', 'Jimbo', 'Halbert'),
('    1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired')



SELECT * FROM EmployeeErrors

SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors


SELECT LastName, REPLACE(LastName, '- Fired', '') as LastNameReplaced
FROM EmployeeErrors


SELECT SUBSTRING(LastName, 1,3) FROM EmployeeErrors

--FUZZY MATCH USING A SUBSTRING

SELECT ERR.FirstName, SUBSTRING(ERR.FirstName, 1,3), DEM.FirstName, SUBSTRING(DEM.FirstName,1,3)
FROM EmployeeErrors ERR
JOIN
EmployeeDemographics DEM
ON SUBSTRING(ERR.FirstName, 1,3) = SUBSTRING(DEM.FirstName,1,3)



SELECT ERR.FirstName, SUBSTRING(ERR.FirstName, 1,3), DEM.FirstName, SUBSTRING(DEM.FirstName,1,3)
FROM EmployeeErrors ERR
JOIN
EmployeeDemographics DEM
ON SUBSTRING(ERR.FirstName, 1,3) = SUBSTRING(DEM.FirstName,1,3)

SELECT UPPER(FirstName) FROM EmployeeErrors


SELECT LastName, LOWER(LastName) FROM EmployeeErrors

---STORE PROCEDURES

CREATE PROCEDURE TEST
AS
SELECT * 
FROM EmployeeDemographics


EXEC TEST

CREATE PROCEDURE temp_Employee
AS
CREATE TABLE #temp_Employee(
Employee_ID INT,
Jobtitle VARCHAR(50),
Salary INT
) 


INSERT INTO #temp_Employee
SELECT Jobtitle, count(Jobtitle), avg(age), avg(salary)
FROM EmployeeDemographics
join
EmployeeSalary
on EmployeeDemographics.Employee_id = EmployeeSalary.Employee_id
group by JobTitle

SELECT *
FROM #temp_Employee

EXEC temp_Employee

--SUB QUERY OR OUERY IN A QUERY(NESTED QUERY)

SELECT * FROM EmployeeSalary

--SUBQUERY IN SELECT
SELECT Employee_id, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AVGSALARY
FROM EmployeeSalary

--DOING IT WITH PARTITION BY

SELECT Employee_id, Salary, AVG(Salary) OVER() as AVGSALARY
FROM EmployeeSalary

--DOES NOT WORK WITH GROUP BY

SELECT Employee_id, Salary, AVG(Salary) as avgsalary
FROM EmployeeSalary
GROUP BY Employee_id, Salary
order by 1,2

--SUBQUERY IN FROM

SELECT Employee_id, AVGSALARY
FROM (
    SELECT Employee_id, 
           Salary, 
           AVG(Salary) OVER() AS AVGSALARY
    FROM EmployeeSalary
) AS SubQueryAlias

--WHERE CLAUSE
SELECT Employee_id, JobTitle,Salary
FROM EmployeeSalary
WHERE Employee_id IN 
(SELECT Employee_id 
FROM EmployeeDemographics 
WHERE Age > 30)