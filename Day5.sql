use assignment3;
show tables;
select * from employees;

/*
MySQL Practice Exercise
Schema Creation
CREATE DATABASE assignment3;
USE assignment3;
CREATE TABLE employees (
 emp_id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(50),
 department VARCHAR(50),
 salary DECIMAL(10,2),
 age INT,
 city VARCHAR(50),
 joining_date DATE
);
Insert Sample Data
INSERT INTO employees (name, department, salary, age, city, joining_date) VALUES
('Amit', 'IT', 60000, 28, 'Delhi', '2022-03-15'),
('Riya', 'HR', 45000, 25, 'Mumbai', '2021-06-10'),
('John', 'IT', 75000, 32, 'Bangalore', '2020-01-20'),
('Sara', 'Finance', 50000, 29, 'Delhi', '2023-02-12'),
('David', 'IT', 80000, 35, 'Mumbai', '2019-11-05'),
('Neha', 'HR', 47000, 27, 'Delhi', '2022-07-19'),
('Raj', 'Finance', 52000, 31, 'Bangalore', '2021-09-23'),
('Priya', 'IT', 62000, 26, 'Delhi', '2023-01-01');

Exercises
Basic SELECT & WHERE
1. Display all employee details
SELECT * FROM Employees;

2. Show only employee names and salaries
SELECT name,salary FROM employees;

3. Find employees with salary > 60000
SELECT * FROM employees WHERE salary>60000;

4. Find employees from Delhi
SELECT * FROM employees where city ="Delhi";

5. Find employees aged between 25 and 30
SELECT * FROM employees WHERE age BETWEEN 25 and 30;

ORDER BY
6. Sort employees by salary (ascending)
SELECT * FROM employees ORDER BY  salary ASC;

7. Sort employees by age (descending)
SELECT * FROM employees ORDER BY  age DESC;

8. Show employees sorted by department, then salary
SELECT * FROM employees ORDER BY  department,salary ;

DISTINCT
9. List unique departments
SELECT DISTINCT department from employees;

10. List unique cities
SELECT DISTINCT city from employees;

LIMIT
11. Show top 3 highest paid employees
SELECT * from employees ORDER BY SALARY DESC LIMIT 3;

12. Show 2 youngest employees 
SELECT * from employees ORDER BY age ASC LIMIT 2;

Aggregate Functions
13. Find total number of employees
SELECT COUNT(*) FROM Employees;

14. Find average salary
SELECT AVG(salary) FROM Employees;

15. Find maximum salary
SELECT MAX(salary) FROM Employees;

16. Find minimum salary
SELECT MIN(salary) FROM Employees;

17. Find total salary of all employees
SELECT SUM(salary) FROM Employees;

GROUP BY
18. Count employees in each department
select department, COUNT(emp_id) from employees GROUP BY department;

19. Find average salary per department
select department, AVG(salary) from employees GROUP BY department;

20. Find total salary per city
select city, SUM(salary) from employees GROUP BY city;

HAVING
21. Show departments with more than 2 employees
select department, COUNT(emp_id) from employees GROUP BY department HAVING COUNT(emp_id) >2;

22. Show departments where average salary > 60000 
select department, AVG(salary) from employees GROUP BY department HAVING AVG(salary) > 60000;

LIKE Operator
23. Find employees whose name starts with 'A'
SELECT name FROM employees 
WHERE name LIKE 'A%';

24. Find employees whose name ends with 'a'
SELECT name FROM employees 
WHERE name LIKE '%a';

25. Find employees whose name contains 'i'
SELECT name FROM employees 
WHERE name LIKE '%i%';

IN / NOT IN
26. Find employees from Delhi or Mumbai
SELECT name FROM employees 
WHERE  city in ('Delhi','Mumbai');

27. Find employees NOT in IT department
SELECT name,department FROM employees 
WHERE  Department NOT IN ('IT');

BETWEEN
28. Find employees with salary between 50000 and 70000
SELECT name,salary FROM employees 
WHERE  salary BETWEEN 5000 AND 70000;

29. Find employees who joined between 2021 and 2023
SELECT name,joining_date FROM employees 
WHERE  joining_date BETWEEN '2021-01-01' AND '2023-12-31';

UPDATE
30. Increase salary of all IT employees by 10%
SET SQL_SAFE_UPDATES = 0;
UPDATE employees SET salary = salary* 1.10;

DELETE
31. Delete employees with salary < 45000
DELETE FROM employees 
WHERE salary < 45000;

CASE Statement
32. Categorize employees:
• Salary > 70000 → 'High'
• 50000–70000 → 'Medium'
• < 50000 → 'Low
SELECT name, salary,
    CASE 
        WHEN salary > 70000 THEN 'High'
        WHEN salary BETWEEN 50000 AND 70000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM employees;
*/

select * from employees;


