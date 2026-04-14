CREATE DATABASE trigger_exercises; 
USE trigger_exercises;

-- Customers table 
CREATE TABLE customers ( 
customer_id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(50), 
email VARCHAR(100), 
city VARCHAR(50) 
); 

-- Accounts table 
CREATE TABLE accounts ( 
account_id INT PRIMARY KEY AUTO_INCREMENT, 
customer_id INT, 
balance DECIMAL(10,2), 
account_type VARCHAR(20), 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 

-- Transactions table 
CREATE TABLE transactions ( 
transaction_id INT PRIMARY KEY AUTO_INCREMENT, 
account_id INT, 
amount DECIMAL(10,2), 
transaction_type VARCHAR(10), -- 'DEPOSIT' or 'WITHDRAW' 
transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
FOREIGN KEY (account_id) REFERENCES accounts(account_id) 
); 

-- Audit log table 
CREATE TABLE audit_log ( 
log_id INT PRIMARY KEY AUTO_INCREMENT, 
table_name VARCHAR(50), 
action_type VARCHAR(20), 
record_id INT, 
action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 

-- Backup table for deleted accounts 
CREATE TABLE deleted_accounts ( 
account_id INT, 
customer_id INT, 
balance DECIMAL(10,2), 
account_type VARCHAR(20), 
deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 


Trigger Exercise Questions 
Exercise 1: BEFORE INSERT 
Prevent creating an account with negative balance

DELIMITER $$
create trigger trg_pre_neg_bal
  before insert on accounts
  for each row
begin
  if new.balance < 0 then
    signal sqlstate '45000'
      set message_text = 'Balance cannot be negative';
  end if;
end$$
DELIMITER ;

desc accounts;

DELIMITER $$
create trigger trg_min_balance
  before insert on accounts
  for each row
begin
  if new.balance < 1000 then
    set new.balance = 1000;
  end if;
end$$
DELIMITER ;

INSERT INTO customers(name, email, city)
VALUES ('Akash', 'akash@gmail.com', 'Noida');

INSERT INTO customers(name, email, city)
VALUES ('Rahul', 'rahul@gmail.com', 'Delhi');

INSERT INTO accounts(customer_id, balance, account_type)
VALUES (1, 500, 'SAVINGS');

SELECT * FROM accounts;
INSERT INTO accounts(customer_id, balance, account_type)
VALUES (3, 400, 'SAVINGS');

insert into accounts (customer_id, balance,account_type) values(1,101,-12,'Saving');
