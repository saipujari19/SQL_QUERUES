
-- Use the Births database
USE Births;

-- Step 1: Add a constraint to ensure state values are one of the allowed values and cannot be null
ALTER TABLE BirthData
MODIFY State VARCHAR(2) NOT NULL,
ADD CONSTRAINT chk_state CHECK (State IN ('MA', 'NH', 'VT', 'ME', 'RI', 'CT'));

-- Step 2: Add a composite primary key on (state, date)
ALTER TABLE BirthData
ADD PRIMARY KEY (State, Date);

-- Step 3: Add a constraint to ensure the date is after 1986-12-31
ALTER TABLE BirthData
ADD CONSTRAINT chk_date CHECK (Date > '1987-1-1');

-- Step 4: Add a constraint to ensure births are greater than or equal to 0
ALTER TABLE BirthData
ADD CONSTRAINT chk_births CHECK (Births >= 0);



-- Describe the structure of the BirthData table after adding constraints
DESCRIBE BirthData;



-- Step 3: Inserting the provided data into the BirthData table
INSERT INTO BirthData (State, Date, Births) VALUES ('MA', '1986-10-05', 314);
-- This will fail because 'NY' is not allowed by the state constraint
INSERT INTO BirthData (State, Date, Births) VALUES ('NY', '1986-10-10', 123);
-- This will fail because NULL is not allowed in the state column
INSERT INTO BirthData (State, Date, Births) VALUES (NULL, '1986-10-12', 300);
INSERT INTO BirthData (State, Date, Births) VALUES ('MA', '1987-01-02', 205);
-- This will fail because 'NY' is not allowed by the state constraint and date is after 1987-01-01
INSERT INTO BirthData (State, Date, Births) VALUES ('NY', '1987-01-03', 153);
-- This will fail because births cannot be negative
INSERT INTO BirthData (State, Date, Births) VALUES ('MA', '1987-01-03', -123);
INSERT INTO BirthData (State, Date, Births) VALUES ('MA', '1986-10-03', 555);
INSERT INTO BirthData (State, Date, Births) VALUES ('CT', '1986-10-04', 321);


 
-- Select rows with birthdates between 1986-09-01 and 1986-12-31
SELECT * 
FROM BirthData
WHERE Date BETWEEN '1986-09-01' AND '1986-12-31';
