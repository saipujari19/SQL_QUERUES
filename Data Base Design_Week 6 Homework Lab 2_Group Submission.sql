/*
created an audit table to log deleted transactions, ensuring accountability by storing details of deleted rows with timestamps.
 A trigger automatically logged deletions, and a stored procedure calculated a customer's total available balance from their accounts for efficient reporting.

*/
-- Using the BankDB database
USE BankDB;

-- Dropping the AuditTxDelete table if it exists
DROP TABLE IF EXISTS AuditTxDelete;

-- 1. Creating the AuditTxDelete table to log deleted transactions
CREATE TABLE AuditTxDelete (
    txn_id INTEGER UNSIGNED NOT NULL,
    txn_date DATETIME NOT NULL,
    account_id INTEGER UNSIGNED NOT NULL,
    txn_type_cd ENUM('DBT', 'CDT'),
    amount DOUBLE(10,2) NOT NULL,
    teller_emp_id SMALLINT UNSIGNED,
    execution_branch_id SMALLINT UNSIGNED,
    funds_avail_date DATETIME,
    DeleteTimeStamp TIMESTAMP,
    CONSTRAINT fk_audit_account_id FOREIGN KEY (account_id) REFERENCES account (account_id),
    CONSTRAINT fk_audit_teller_emp_id FOREIGN KEY (teller_emp_id) REFERENCES employee (emp_id),
    CONSTRAINT fk_audit_branch_id FOREIGN KEY (execution_branch_id) REFERENCES branch (branch_id),
    CONSTRAINT pk_audit_transaction PRIMARY KEY (txn_id)
);

-- Dropping the trigger if it already exists
DROP TRIGGER IF EXISTS before_delete_transaction;

-- 2. Creating a trigger to log transaction deletions in AuditTxDelete table
DELIMITER //
CREATE TRIGGER before_delete_transaction
BEFORE DELETE ON transaction
FOR EACH ROW
BEGIN
    -- Inserting details of the deleted transaction into AuditTxDelete
    INSERT INTO AuditTxDelete (
        txn_id,
        txn_date,
        account_id,
        txn_type_cd,
        amount,
        teller_emp_id,
        execution_branch_id,
        funds_avail_date,
        DeleteTimeStamp
    ) VALUES (
        OLD.txn_id,
        OLD.txn_date,
        OLD.account_id,
        OLD.txn_type_cd,
        OLD.amount,
        OLD.teller_emp_id,
        OLD.execution_branch_id,
        OLD.funds_avail_date,
        CURRENT_TIMESTAMP
    );
END //
DELIMITER ;

-- 3(1). Viewing the data in the transaction table
SELECT * FROM transaction;

-- 3(2). Deleting a single transaction record
DELETE FROM transaction LIMIT 1;

-- 3(3). Viewing the data in the transaction table after deletion
SELECT * FROM transaction;

-- 3(4). Viewing the audit log of deleted transactions
SELECT * FROM AuditTxDelete;

-- Dropping the procedure if it already exists
DROP PROCEDURE IF EXISTS Get_Customer_Total_Balance;

-- 4. Creating a stored procedure to calculate the total balance of a customer
DELIMITER //
CREATE PROCEDURE Get_Customer_Total_Balance(
    IN cust_id INT,
    OUT total_balance FLOAT
)
BEGIN
    -- Calculating the sum of available balances for the given customer ID
    SELECT SUM(avail_balance) INTO total_balance
    FROM account
    WHERE cust_id = cust_id;
END //
DELIMITER ;

-- Initializing the output variable for the procedure
SET @total_balance = 0;

-- 5. Calling the procedure to calculate the total balance for a customer
CALL Get_Customer_Total_Balance(1, @total_balance);

-- 6. Formatting and displaying the total available balance
SELECT CONCAT('$', FORMAT(@total_balance, 2)) AS Total_Available_Balance;
