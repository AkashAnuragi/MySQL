-- Transaction Exercises (MySQL)
-- Schema 1: Bank System
CREATE TABLE accounts (
 account_id INT PRIMARY KEY,
 account_name VARCHAR(50),
 balance DECIMAL(10,2)
);
INSERT INTO accounts VALUES
(1, 'Alice', 5000),
(2, 'Bob', 3000),
(3, 'Charlie', 7000)