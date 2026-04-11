/*
Setup Tables  
First, create sample tables: 
CREATE TABLE Departments ( 
dept_id INT PRIMARY KEY, 
dept_name VARCHAR(50) 
); 
CREATE TABLE Employees ( 
emp_id INT PRIMARY KEY, 
emp_name VARCHAR(50), 
dept_id INT, 
salary INT, 
FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) 
); 
CREATE TABLE Projects ( 
project_id INT PRIMARY KEY, 
project_name VARCHAR(50), 
emp_id INT, 
FOREIGN KEY (emp_id) REFERENCES Employees(emp_id) 
); 

Insert Sample Data 

INSERT INTO Departments VALUES 
(1, 'HR'), 
(2, 'IT'), 
(3, 'Finance'); 
INSERT INTO Employees VALUES 
(101, 'Amit', 1, 30000), 
(102, 'Neha', 2, 50000), 
(103, 'Raj', 2, 45000), 
(104, 'Simran', 3, 40000), 
(105, 'Karan', NULL, 35000); 
INSERT INTO Projects VALUES 
(1, 'Website', 102), 
(2, 'App', 103), 
(3, 'Audit', 104), 
(4, 'Recruitment', 101); 

Basic Level 
1. Show all employees along with their department names.  
SELECT e.emp_name, d.dept_name FROM employees e INNER JOIN Departments d  ON e.dept_id = d.dept_id; 

2. List all employees who do not belong to any department.  
select e.emp_name, d.dept_name from employees e LEFT JOIN Departments d  ON e.dept_id = d.dept_id
WHERE d.dept_id is null; 

3. Display all departments and their employees (including empty departments).  
select e.emp_name, d.dept_name from employees e LEFT JOIN Departments d  ON e.dept_id = d.dept_id; 

4. Retrieve employee names and their salaries along with department names. 
select e.emp_name, d.dept_name, e.salary from employees e LEFT JOIN Departments d  ON e.dept_id = d.dept_id; 
 
5. Show all projects with assigned employee names.  
select e.emp_name, p.project_name from employees e INNER JOIN Projects p  ON e.emp_id = p.emp_id; 

6. List employees who are not assigned to any department.  
select e.emp_name, p.project_name from employees e LEFT JOIN Projects p  ON e.emp_id = p.emp_id
where p.emp_id is null; 
7. Display all employees and project names (including employees without 
projects).  
select e.emp_name, p.project_name from employees e LEFT JOIN Projects p  ON e.emp_id = p.emp_id 
UNION 
select e.emp_name, p.project_name from employees e RIGHT JOIN Projects p  ON e.emp_id = p.emp_id; 

8. Show departments that have no employees. 
select e.emp_name, d.dept_name from employees e LEFT JOIN Departments d  ON e.dept_id = d.dept_id
WHERE e.id is null; 

Intermediate Level 
9. Find employees working in the "HR" department.  
select e.emp_name, d.dept_name from employees e INNER JOIN Departments d  ON e.dept_id = d.dept_id
WHERE dept_name = 'HR';

10. Display employee name, department name, and project name.  
select e.emp_name, d.dept_name,project_name from employees e  JOIN Departments d  ON e.dept_id = d.dept_id
JOIN Projects p ON e.emp_id = p.project_id;

11. List employees who are assigned to more than one project.  
select e.emp_id, e.emp_name from Employees e  JOIN Projects p  ON e.emp_id = p.project_id
GROUP BY e.emp_id,e.emp_name HAVING count(project_id)>1;

12. Show the total number of employees in each department.  
select d.dept_id, d.dept_name, Count(e.emp_id) as total_emp from  Departments d LEFT JOIN Employees e  ON e.dept_id = d.dept_id
GROUP BY d.dept_id,d.dept_name;

13. Find departments with more than 2 employees.  
select d.dept_id, d.dept_name, Count(e.emp_id) as total_emp from  Departments d LEFT JOIN Employees e  ON e.dept_id = d.dept_id
GROUP BY d.dept_id,d.dept_name having total_emp>2;

14. Display employees who are not assigned to any project.  
SELECT e.emp_id, e.emp_name FROM Employees e LEFT JOIN Projects p ON e.emp_id = p.emp_id WHERE p.project_id IS NULL;

15. Show all projects that do not have any employee assigned.  
SELECT project_id, project_name FROM Projects WHERE emp_id IS NULL;

16. List employees whose salary is greater than 40,000 along with their department.  
SELECT e.emp_id, e.emp_name, e.salary, d.dept_name FROM Employees e JOIN Departments d ON e.dept_id = d.dept_id WHERE e.salary > 40000;

17. Display employee names along with their manager (self join if applicable).  


Advanced Level 
18. Find the highest salary in each department.  
19. Show the second highest salary in each department.  
20. Display employees earning more than the average salary of their department.  
21. Find departments where the average salary is greater than 45,000.  
22. List employees who work in the same department as 'Amit'.  
23. Show employees who are working on the same project.  
24. Find employees who are not working on any project but belong to a department.  
25. Display department-wise total and average salary.  
26. List employees whose salary is the highest in the company.  
27. Show departments that have no projects assigned. 

*/

use assignment2;
desc employees;
desc departments;
desc projects;
select * from Departments;
select * from Employees;


select d.dept_id, d.dept_name, Count(e.emp_id) as total_emp from  Departments d LEFT JOIN Employees e  ON e.dept_id = d.dept_id
GROUP BY d.dept_id,d.dept_name having total_emp>2;
