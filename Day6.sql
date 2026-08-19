/*
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

*/

-- Trigger Exercise Questions 
-- Exercise 1: BEFORE INSERT 
-- Prevent creating an account with negative balance

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

-- Exercise 3: AFTER INSERT
-- Log every new account creation in audit_log

DELIMITER $$
CREATE TRIGGER trg_log_new_account
  AFTER INSERT ON accounts
  FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, action_type, record_id)
  VALUES ('accounts', 'INSERT', NEW.account_id);
END $$
DELIMITER ;

-- Exercise 4: BEFORE UPDATE
-- Prevent account balance from becoming negative after update
DELIMITER $$

CREATE TRIGGER trg_prevent_neg_balance_update
  BEFORE UPDATE ON accounts
  FOR EACH ROW
BEGIN
  IF NEW.balance < 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Balance cannot go below zero';
  END IF;
END $$

DELIMITER ;

UPDATE accounts SET balance = -500 WHERE account_id = 1;


-- Exercise 5: AFTER UPDATE
-- Log old and new balance changes in audit_log
DELIMITER $$

CREATE TRIGGER trg_log_balance_change
  AFTER UPDATE ON accounts
  FOR EACH ROW
BEGIN
  IF OLD.balance != NEW.balance THEN
    INSERT INTO audit_log (table_name, action_type, record_id)
    VALUES (
      CONCAT('accounts | old=', OLD.balance, ' new=', NEW.balance),
      'UPDATE',
      NEW.account_id
    );
  END IF;
END $$

DELIMITER ;

INSERT INTO customers (name, email, city)
VALUES ('Manu', 'manu@gmail.com', 'Kota');

INSERT INTO accounts (customer_id, balance, account_type)
VALUES (1, 5000, 'SAVINGS');

UPDATE accounts
SET balance = 7000
WHERE account_id = 1;

SELECT * FROM audit_log;


-- Exercise 6: BEFORE DELETE
-- Backup account details into deleted_accounts before deletion

DELIMITER $$
CREATE TRIGGER trg_backup_deleted_account
  BEFORE DELETE ON accounts
  FOR EACH ROW
BEGIN
  INSERT INTO deleted_accounts
    (account_id, customer_id, balance, account_type)
  VALUES
    (OLD.account_id, OLD.customer_id, OLD.balance, OLD.account_type);
END $$
DELIMITER ;

INSERT INTO accounts (account_id, customer_id, balance, account_type)
VALUES (10, 1, 5000, 'SAVINGS');

DELETE FROM accounts WHERE account_id =10;
SELECT * FROM deleted_accounts;

-- Exercise 7: BEFORE DELETE
-- Prevent deletion of accounts with balance greater than 0

DELIMITER $$
CREATE TRIGGER trg_block_delete_with_balance
  BEFORE DELETE ON accounts
  FOR EACH ROW
BEGIN
  IF OLD.balance > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Cannot delete account with remaining balance';
  END IF;
END $$
DELIMITER ;

INSERT INTO accounts (account_id, customer_id, balance, account_type)
VALUES (10, 1, 5000, 'SAVINGS');

DELETE FROM accounts WHERE account_id = 10;  -- fail

UPDATE accounts
SET balance = 0
WHERE account_id = 10;

DELETE FROM accounts WHERE account_id = 10;  -- successfully Deleted


-- Exercise 8: AFTER INSERT (Transactions)
-- When a DEPOSIT happens, automatically increase account balance
DELIMITER $$
CREATE TRIGGER trg_process_deposit
  AFTER INSERT ON transactions
  FOR EACH ROW
BEGIN
  IF UPPER(NEW.transaction_type) = 'DEPOSIT' THEN
    UPDATE accounts
    SET balance = balance + NEW.amount
    WHERE account_id = NEW.account_id;
  END IF;
END $$
DELIMITER ;

INSERT INTO accounts (account_id, customer_id, balance, account_type)
VALUES (10, 1, 5000, 'SAVINGS');

INSERT INTO transactions (account_id, amount, transaction_type)
VALUES (10, 2000, 'DEPOSIT');

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 10;

SELECT * FROM accounts WHERE account_id = 10;

-- Exercise 9: AFTER INSERT (Transactions)
-- When a WITHDRAW happens:
-- - Deduct amount from balance
-- - Prevent withdrawal if insufficient balance

DELIMITER $$
CREATE TRIGGER trg_process_withdrawal
  BEFORE INSERT ON transactions
  FOR EACH ROW
BEGIN
  DECLARE curr_balance DECIMAL(10,2);

  IF UPPER(NEW.transaction_type) = 'WITHDRAW' THEN
    SELECT balance INTO curr_balance
    FROM accounts
    WHERE account_id = NEW.account_id;

    IF curr_balance < NEW.amount THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance';
    END IF;

    UPDATE accounts
    SET balance = balance - NEW.amount
    WHERE account_id = NEW.account_id;
  END IF;
END $$
DELIMITER ;

INSERT INTO transactions (account_id, amount, transaction_type)
VALUES (10, 2000, 'WITHDRAW');  -- WITHDRAW

INSERT INTO transactions (account_id, amount, transaction_type)
VALUES (10, 150000, 'WITHDRAW');  -- Insufficent Balance


-- Exercise 10: AFTER INSERT
-- Log every transaction in audit_log

DELIMITER $$
CREATE TRIGGER trg_log_transaction
  AFTER INSERT ON transactions
  FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, action_type, record_id)
  VALUES ('transactions', NEW.transaction_type, NEW.transaction_id);
END $$
DELIMITER ;

INSERT INTO transactions (account_id, amount, transaction_type)
VALUES (10, 1500, 'DEPOSIT');

SELECT * FROM accounts WHERE account_id = 10;

INSERT INTO transactions (account_id, amount, transaction_type)
VALUES (10, 500, 'WITHDRAW');

SELECT * FROM audit_log;


select * from transactions;

DROP TRIGGER trg_prevent_negative_update;
INSERT INTO customers(name, email, city)
VALUES ('Akash', 'akash@gmail.com', 'Noida');



INSERT INTO customers(name, email, city)
VALUES ('kajal', 'kajal@gmail.com', 'Delhi');

INSERT INTO accounts(customer_id, balance, account_type)
VALUES (4, -3420, 'SAVINGS');

SELECT * FROM accounts;
SELECT * FROM Customers;
INSERT INTO accounts(customer_id, balance, account_type)
VALUES (3, 400, 'SAVINGS');

insert into accounts (customer_id, balance,account_type) values(1,101,-12,'Saving');

SHOW TRIGGERS;

select * from audit_log;

SHOW TABLES;
