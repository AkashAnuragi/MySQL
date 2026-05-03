
-- _______________________________________________ PROJECT 2: Banking System ____________________________________________

-- Scenario : Design a banking database with accounts, transactions, and loans. 
CREATE DATABASE banking_db; 

USE banking_db; 

CREATE TABLE customers ( 
customer_id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(100), 
email VARCHAR(100) UNIQUE 
); 

CREATE TABLE accounts ( 
account_id INT PRIMARY KEY AUTO_INCREMENT, 
customer_id INT, 
balance DECIMAL(12,2), 
account_type VARCHAR(20), 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 

CREATE TABLE transactions ( 
transaction_id INT PRIMARY KEY AUTO_INCREMENT, 
account_id INT, 
type VARCHAR(10), 
amount DECIMAL(10,2), 
transaction_date DATE, 
FOREIGN KEY (account_id) REFERENCES accounts(account_id) 
); 

CREATE TABLE loans ( 
loan_id INT PRIMARY KEY AUTO_INCREMENT, 
customer_id INT, 
loan_amount DECIMAL(12,2), 
interest_rate DECIMAL(5,2), 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 


INSERT INTO customers (name, email) VALUES
    ('Akash Anuragi',  'akash@gmail.com'),
    ('Priyanka Verma',   'priyanka@gmail.com'),
    ('Rahul Ojha',   'rahul@gmail.com'),
    ('Ayushi Garg',    'ayushi@gmail.com'),
    ('Sagar Singh', 'sagar@gmail.com');
 
INSERT INTO accounts (customer_id, balance, account_type) VALUES
    (1, 25000.00, 'Savings'),
    (2, 50000.00, 'Current'),
    (3, 15000.00, 'Savings'),
    (4, 75000.00, 'Savings'),
    (5, 5000.00,  'Current');
    -- customer_id 5 account will have NO transactions → used in Q7
 
INSERT INTO transactions (account_id, type, amount, transaction_date) VALUES
    (1, 'Deposit',    10000.00, '2025-05-01'),
    (1, 'Withdrawal',  3000.00, '2025-05-10'),
    (2, 'Deposit',    20000.00, '2025-05-02'),
    (2, 'Deposit',    15000.00, '2025-05-15'),
    (3, 'Deposit',     8000.00, '2025-05-05'),
    (3, 'Withdrawal',  2000.00, '2025-05-20'),
    (4, 'Deposit',    30000.00, '2025-05-07');
 
INSERT INTO loans (customer_id, loan_amount, interest_rate) VALUES
    (1, 100000.00, 8.50),
    (3,  50000.00, 9.00),
    (5, 200000.00, 7.75);
    
    
-- Basic: 1. List all customers  
SELECT * FROM customers;

-- 2. Show all savings accounts  
SELECT c.name AS Customer_Name, a.* FROM accounts a  
JOIN customers c ON c.customer_id = a.customer_id
WHERE account_type = "SAVINGS"
ORDER by c.name;

-- Intermediate 3. Find total balance per customer  
SELECT c.name AS Customer_Name, SUM(a.balance) AS Total_Balance FROM customers c 
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
ORDER by total_balance DESC;

-- 4. Show all transactions for a given account 
SELECT * FROM transactions 
WHERE account_id =1 --  you can find any transactions by  given account_id
ORDER BY transaction_date DESC;

-- Advanced 5. Find customers with highest total deposits  
SELECT c.name AS Customer_name, SUM(t.amount) AS Total_amount FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.type = "Deposit" 
GROUP BY c.customer_id, c.name 
Order BY total_amount DESC;


-- 6. Calculate interest for each loan  
SELECT c.name AS Customer_Name, l.loan_amount, l.interest_rate,    
ROUND(l.loan_amount * l.interest_rate / 100, 2) AS annual_interest FROM loans l
JOIN customers c ON l.customer_id = c.customer_id;

-- 7. Detect accounts with no transactions 
SELECT a.account_id, c.name AS customer_name, a.account_type, a.balance FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- Advanced Logic  8. Trigger → Prevent withdrawal if balance < amount  
DELIMITER $$
 
CREATE TRIGGER before_withdrawal
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE current_balance DECIMAL(12,2);
 
    IF NEW.type = 'Withdrawal' THEN
        SELECT balance INTO current_balance
        FROM accounts
        WHERE account_id = NEW.account_id;
 
        IF current_balance < NEW.amount THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Insufficient balance: withdrawal blocked.';
        END IF;
    END IF;
END$$
 
DELIMITER ;

INSERT INTO transactions (account_id, type, amount, transaction_date)
VALUES (1, 'Withdrawal', 30000, '2025-06-01');  -- Insufficient balance: withdrawal blocked.

INSERT INTO transactions (account_id, type, amount, transaction_date)
VALUES (1, 'Withdrawal', 10000, '2025-06-01');  -- transaction done ho jayega

-- 9. Procedure → Transfer money between accounts  
-- 10. View → customer_financial_summary 
SHOW TABLES;
    
    SELECT * FROM customers;
    SELECT * FROM accounts;
    SELECT * FROM transactions;
    SELECT *  FROM loans;
 