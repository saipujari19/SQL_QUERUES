#1. using previously created database
USE BankDB;

# 2. shoeing the account_id, product.name, customer.fed_id, branch.name, and the concatenated employee.fname and employee.lname using inner join.

SELECT 
  a.account_id,
  p.name AS product_name,
  c.fed_id,
  b.name AS branch_name,
  CONCAT(e.fname, ' ', e.lname) AS opened_by
FROM account a
INNER JOIN product p ON a.product_cd = p.product_cd
INNER JOIN customer c ON a.cust_id = c.cust_id
INNER JOIN branch b ON a.open_branch_id = b.branch_id
INNER JOIN employee e ON a.open_emp_id = e.emp_id;

# 3. SELECT all employee data, to show the emp_id, concatenated fname and lname, and the number of accounts and all the employees are listed.


SELECT
    e.emp_id,
    CONCAT(e.fname, ' ', e.lname) AS full_name,
    COUNT(a.account_id) AS accounts_opened
FROM
    employee e
LEFT JOIN account a ON e.emp_id = a.open_emp_id
GROUP BY
    e.emp_id, e.fname, e.lname;
    
# 4. Using a subquery annd SELECT statement to select all accounts where there are transactions for the account in the transaction table

SELECT *
FROM account a
WHERE EXISTS (
    SELECT 1
    FROM transaction t
    WHERE t.account_id = a.account_id
);

# 5. Showing the total account balance for all accounts for each customer, followed by the details of the balance in each account.


SELECT
    c.cust_id,
    SUM(a.avail_balance) AS total_balance
FROM
    customer c
JOIN account a ON c.cust_id = a.cust_id
GROUP BY
    c.cust_id;

WITH CustomerBalances AS (
    SELECT
        c.cust_id,
        SUM(a.avail_balance) AS total_balance
    FROM
        customer c
    JOIN account a ON c.cust_id = a.cust_id
    GROUP BY
        c.cust_id
)

SELECT
    cb.cust_id,
    cb.total_balance,
    a.account_id,
    a.avail_balance
FROM
    CustomerBalances cb
JOIN account a ON cb.cust_id = a.cust_id;

# 6. Creating a view that contains all accounts, which includes all account data. 
     # used product_cd keys to product to obtain name, cust_id keys to customer to obtain fed_id, 
	#open_branch_id keys to branch to obtain name, open_emp_id keys to employee to obtain fname and lname 
CREATE VIEW v_account_details AS
SELECT
    a.account_id,
    a.product_cd,
    p.name AS product_name,
    a.cust_id,
    c.fed_id,
    a.open_date,
    a.close_date,
    a.last_activity_date,
    a.status,
    a.open_branch_id,
    b.name AS branch_name,
    a.open_emp_id,
    CONCAT(e.fname, ' ', e.lname) AS opened_by,
    a.avail_balance,
    a.pending_balance
FROM
    account a
INNER JOIN product p ON a.product_cd = p.product_cd
INNER JOIN customer c ON a.cust_id = c.cust_id
INNER JOIN branch b ON a.open_branch_id = b.branch_id
INNER JOIN employee e ON a.open_emp_id = e.emp_id;

# 7. using SELECT to all accounts from view where avail_balance > $10,000

SELECT *
FROM v_account_details
WHERE avail_balance > 10000;
