/*

*/

USE amazon;
SHOW TABLES;
SELECT * FROM employee;
SELECT * FROM emp_log;

DELIMITER \\
CREATE TRIGGER check_salary
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
IF NEW.esal < OLD.esal THEN
SIGNAL SQLSTATE 	'45000'
SET MESSAGE_TEXT = "salary can't be decreased";
END IF;
END \\ DELIMITER;

UPDATE employee SET esal = 95000 WHERE eid = 102;



