
/* 
Description:
	Queries for retrieving customer and account data based on specific conditions, including customers 
    living on addresses ending in "Ln" (Lane), calculating balances with a 5% increase, and generating 
    summary statistics (sum, average, min, max) for account balances. It also groups data by product codes,
    identifies unique state codes, and filters results for specific customer characteristics.
*/

-- Use the created BankDB database. All subsequent operations will be performed on this database.
USE BankDB;

-- 1. Query to display customers who live in Lane from the customer table

-- Retrieve all customer data where the address ends in 'Ln' 
SELECT *  -- Select all columns to display full customer information
FROM customer  -- From the 'customer' table
WHERE address LIKE '%Ln';  -- Filter rows with addresses ending in 'Ln'

-- 2. Query to display available balances with a 5% increase

-- Select customer ID, original balance, and calculate balance with a 5% increase
SELECT cust_id,  -- Select the customer ID
       avail_balance,  -- Retrieve the current available balance
       FORMAT(avail_balance * 1.05, 2) AS 'Increased_Balance'  -- Increase balance by 5%, format with 2 decimal places
FROM account  -- From the 'account' table
ORDER BY avail_balance DESC;  -- Sort results by available balance in descending order

-- 3. Query to summarize available balances

-- Retrieve summary statistics for available balances in the 'account' table
SELECT COUNT(*) AS 'Number of Rows',  -- Total number of accounts
       FORMAT(SUM(avail_balance), 2) AS 'Total_Available_Balance',  -- Total balance of all accounts
       FORMAT(AVG(avail_balance), 2) AS 'Average_Available_Balance',  -- Average account balance
       FORMAT(MIN(avail_balance), 2) AS 'Minimum_Available_Balance',  -- Minimum account balance
       FORMAT(MAX(avail_balance), 2) AS 'Maximum_Available_Balance'  -- Maximum account balance
FROM account;  -- From the 'account' table

-- 4. Query to find unique state codes

-- Select distinct state codes from customer data
SELECT DISTINCT state  -- Retrieve unique state codes from customer addresses
FROM customer;  -- From the 'customer' table

-- 5. Query to filter customers from New Hampshire with cust_type_cd = 'I'

-- Retrieve data for specific customers from New Hampshire with a customer type code 'I'
SELECT *  -- Select all customer details for filtered results
FROM customer  -- From the 'customer' table
WHERE state = 'NH'  -- Filter for New Hampshire state
  AND cust_type_cd = 'I';  -- And filter where customer type code is 'I'

-- 6. Query to concatenate address information

-- Display complete address information as a single string
SELECT cust_id,  -- Select the customer ID
       CONCAT(address, ', ', city, ', ', state, '  ', postal_code) AS 'Full_Address'  -- Concatenate address, city, state, and postal code with proper formatting
FROM customer;  -- From the 'customer' table

-- 7. Query to group by product code and summarize balances

-- Group accounts by product code and calculate balance totals
SELECT product_cd,  -- Select product code
       COUNT(*) AS 'Number of Rows',  -- Number of accounts per product
       FORMAT(SUM(avail_balance), 2) AS 'Total_Available_Balance',  -- Total available balance for each product
       FORMAT(SUM(pending_balance), 2) AS 'Total_Pending_Balance'  -- Total pending balance for each product
FROM account  -- From the 'account' table
GROUP BY product_cd  -- Group results by product code
ORDER BY product_cd;  -- Sort results by product code

-- 8. Query to filter groups with more than 3 accounts

-- Show product codes with more than three accounts, including summary balances
SELECT product_cd,  -- Select product code
       COUNT(*) AS 'Number of Rows',  -- Total number of accounts for each product code
       FORMAT(SUM(avail_balance), 2) AS 'Total_Available_Balance',  -- Sum of available balances
       FORMAT(SUM(pending_balance), 2) AS 'Total_Pending_Balance'  -- Sum of pending balances
FROM account  -- From the 'account' table
GROUP BY product_cd  -- Group results by product code
HAVING COUNT(*) > 3  -- Only display product codes with more than 3 accounts
ORDER BY product_cd;  -- Sort results by product code
