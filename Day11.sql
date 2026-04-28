CREATE DATABASE company_practice; 

USE company_practice; 

-- Departments Table 
CREATE TABLE departments ( 
    dept_id INT PRIMARY KEY, 
    dept_name VARCHAR(50) NOT NULL, 
    location VARCHAR(50) 
); 
 -- Employees Table 
CREATE TABLE employees ( 
    emp_id INT PRIMARY KEY, 
    emp_name VARCHAR(50) NOT NULL, 
    salary DECIMAL(10,2), 
    dept_id INT, 
    manager_id INT, 
    hire_date DATE, 
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) 
);

-- Sample Data 
INSERT INTO departments VALUES 
(1, 'HR', 'Delhi'), 
(2, 'IT', 'Noida'), 
(3, 'Sales', 'Mumbai'), 
(4, 'Finance', 'Bangalore'); 
 
INSERT INTO employees VALUES 
(101, 'Amit', 50000, 1, NULL, '2020-01-15'), 
(102, 'Neha', 75000, 2, 101, '2019-03-10'), 
(103, 'Raj', 60000, 2, 102, '2021-06-20'), 
(104, 'Simran', 45000, 3, 101, '2022-02-11'), 
(105, 'Karan', 80000, 2, 102, '2018-07-05'), 
(106, 'Priya', 55000, 4, 101, '2023-01-25');

/*

PART 2 – VIEW Practice Questions 
Basic Level 
Create a view showing employee name and salary. 
View Name: v_employee_salary 

CREATE VIEW v_employee_salary AS
SELECT emp_name, salary
FROM employees;

SELECT * FROM v_employee_salary;

 
Create a view showing employee name and department name. 
View Name: v_employee_department 

CREATE VIEW v_employee_department AS
SELECT e.emp_name, d.dept_name FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

SELECT * FROM v_employee_department;

 
Create a view for employees earning more than 60,000. 
View Name: v_high_salary
CREATE VIEW v_high_salary AS
SELECT emp_id, emp_name, salary FROM employees
WHERE salary > 60000;

SELECT * FROM v_high_salary;


Create a department-wise total salary view. 
View Name: v_dept_total_salary 
Output: 
• dept_name 
• total_salary 

CREATE VIEW  v_dept_total_salary AS
SELECT d.dept_name,SUM(e.salary) as Total_Salary FROM employees e 
JOIN departments d ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT * FROM v_dept_total_salary;

Create a secure view that hides salary but shows: 
• emp_id 
• emp_name 
• dept_name 

CREATE VIEW v_secure_emp AS
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

SELECT * FROM v_secure_emp;

Update salary of Amit using v_employee_salary. 

 SET SQL_SAFE_UPDATES = 0;
 
UPDATE v_employee_salary
SET salary = 55000
WHERE emp_name = 'Amit';

Drop view safely if exists. 
DROP VIEW IF EXISTS v_employee_salary;

PART 3 – CTE Practice Questions 
Basic CTE 
Use CTE to find employees earning above average salary. 
WITH avg_sal AS (SELECT AVG(salary) as avg_salary FROM employees)
SELECT emp_name, salary FROM employees, avg_sal
WHERE salary > avg_salary;

Use CTE to calculate average salary per department. 
WITH dept_avg AS ( SELECT d.dept_name,AVG(e.salary) AS avg_salary FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name)
SELECT * FROM dept_avg;

Use CTE to find highest salary in each department. 
WITH dept_max_sal AS ( SELECT d.dept_name, MAX(e.salary) AS max_salary FROM employees e 
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name)
SELECT * FROM dept_max_sal;

Intermediate CTE 
Use two CTEs: 
• One for IT employees 
• One for employees earning above 70,000 
Return common records. 
WITH it_emp AS ( SELECT e.emp_id, e.emp_name, e.salary FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    WHERE d.dept_name = 'IT'
),
high_sal AS (
    SELECT emp_id, emp_name, salary  FROM employees
    WHERE salary > 70000
)
SELECT it.emp_id, it.emp_name, it.salary FROM it_emp it
INNER JOIN high_sal hs ON it.emp_id = hs.emp_id;

Rank employees by salary using CTE and ROW_NUMBER(). 
WITH ranked AS ( SELECT emp_name, salary, 
ROW_NUMBER() OVER (ORDER BY salary DESC) AS rnk FROM employees
)
SELECT * FROM ranked;

Get top 2 highest paid employees in each department. 
WITH ranked_dept AS (
    SELECT e.emp_name, d.dept_name, e.salary, ROW_NUMBER() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS rnk
    FROM employees e  JOIN departments d ON e.dept_id = d.dept_id )
SELECT emp_name, dept_name, salary FROM ranked_dept WHERE rnk <= 2;

Find difference between highest and lowest salary using CTE. 
WITH sal_range AS ( SELECT MAX(salary) AS max_sal, MIN(salary) as min_sal FROM employees)
SELECT max_sal,min_sal, (max_sal -min_sal) AS sal_diff FROM sal_range;
*/




SELECT * FROM Departments;
SELECT * FROM employees;