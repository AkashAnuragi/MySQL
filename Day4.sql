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
SELECT e.emp_name AS employee,
       m.emp_name AS manager
FROM Employees e
LEFT JOIN Employees m
ON e.manager_id = m.emp_id;

Advanced Level 
18. Find the highest salary in each department. 
SELECT  d.dept_name,MAX(e.salary) as Highest_salary FROM employees  e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
 
19. Show the second highest salary in each department.  
SELECT e.dept_id, MAX(e.salary) AS second_highest
FROM Employees e
WHERE e.salary < (
    SELECT MAX(e2.salary)
    FROM Employees e2
    WHERE e2.dept_id = e.dept_id
)
GROUP BY e.dept_id;


20. Display employees earning more than the average salary of their department. 
SELECT * FROM employees e1
where e1.salary > (SELECT AVG(salary) FROM employees e2  WHERE e1.dept_id = e2.dept_id);
 
21. Find departments where the average salary is greater than 45,000.  
SELECT dept_id, AVG(salary) FROM employees 
GROUP BY dept_id
HAVING AVG(salary) >45000;

22. List employees who work in the same department as 'Amit'.  
SELECT * FROM employees 
where dept_id = (SELECT dept_id FROM employees WHERE emp_name ='Amit');

23. Show employees who are working on the same project. 
SELECT e.emp_name, p.project_name
FROM Projects p
JOIN Employees e ON p.emp_id = e.emp_id
WHERE p.project_name IN (
    SELECT project_name
    FROM Projects
    GROUP BY project_name
    HAVING COUNT(emp_id) > 1
);

-- OR 

SELECT p1.emp_id, p1.project_name
FROM Projects p1
JOIN Projects p2 
ON p1.project_name = p2.project_name 
AND p1.emp_id <> p2.emp_id;

 
24. Find employees who are not working on any project but belong to a department.  
SELECT * FROM employees
WHERE dept_id IS NOT NULL 
AND 
emp_id NOT IN (SELECT emp_id from projects);


25. Display department-wise total and average salary.  
SELECT dept_id,  SUM(salary) AS Total_Salary, AVG(salary) AS Avg_Salary FROM employees 
GROUP BY dept_id;

26. List employees whose salary is the highest in the company.  
SELECT * FROM employees Order BY salary desc limit 1;

-- OR
select * from employees where salary = (select MAX(salary) from employees);

27. Show departments that have no projects assigned. 
SELECT d.*
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
LEFT JOIN Projects p ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

Foreign Key Focus 
28. Insert a record in Employees with a department_id that does not exist. What 
happens?  
INSERT INTO Employees VALUES (106, 'Rohit', 10, 30000);
Result:  Error
Because
The dept_id = 10 does not exist in the Departments table.
This violates the foreign key constraint, so the insertion fails.

29. Delete a department that is referenced by employees. What error occurs?  
The department is being used in the Employees table.
Due to referential integrity, the parent record cannot be deleted.

30. Update a department_id in Departments that is referenced in Employees. What 
happens?  
UPDATE Departments SET dept_id = 10 WHERE dept_id = 1;
Error
Because
Employees are still referencing dept_id = 1.
Updating it would break the foreign key relationship.

31. Modify foreign key to use ON DELETE SET NULL and test behavior.  
ALTER TABLE Employees
DROP FOREIGN KEY employees_ibfk_1;

ALTER TABLE Employees
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id)
REFERENCES Departments(dept_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

SELECT * FROM Employees WHERE dept_id = 1;

DELETE FROM Departments WHERE dept_id = 1;

SELECT * FROM Employees WHERE emp_id IN (101,106);


32. Modify foreign key to use ON UPDATE CASCADE and test updates.  
ALTER TABLE Employees
DROP FOREIGN KEY fk_dept;

ALTER TABLE Employees
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id)
REFERENCES Departments(dept_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

SELECT * FROM Employees WHERE dept_id = 2;

UPDATE Departments
SET dept_id = 20
WHERE dept_id = 2;

SELECT * FROM Employees WHERE emp_id IN (102,103);

33. Try inserting a project with a non-existing employee_id.  
INSERT INTO Projects VALUES (7, 'AI Project', 999);
Result:Error
Because
The emp_id = 999 does not exist in the Employees table.
This violates the foreign key constraint.

34. Delete an employee who is assigned to a project and observe behavior.  
DELETE FROM Employees WHERE emp_id = 102;
Result:Error
Because
This employee is referenced in the Projects table.
So, deletion is not allowed due to foreign key constraint.

35. Add a foreign key constraint after table creation and test violations. 
ALTER TABLE Projects
ADD CONSTRAINT fk_emp
FOREIGN KEY (emp_id)
REFERENCES Employees(emp_id);

Challenge Level  
36. Find employees who have worked on all projects.  
SELECT e.emp_id, e.emp_name
FROM employees e
JOIN works_on w ON e.emp_id = w.emp_id
GROUP BY e.emp_id, e.emp_name
HAVING COUNT(DISTINCT w.project_id) = (
    SELECT COUNT(*) FROM projects
);

37. List employees who share the same salary in the same department.  
SELECT e1.emp_id, e1.emp_name, e1.salary, e1.dept_id
FROM employees e1
JOIN employees e2 
  ON e1.salary = e2.salary 
  AND e1.dept_id = e2.dept_id
  AND e1.emp_id <> e2.emp_id;
  
38. Find the department with the highest total salary.
SELECT e.dept_id, dept_name
FROM Employees e JOIN departments d ON e.dept_id = d.dept_id
GROUP BY dept_id
ORDER BY SUM(salary) DESC
LIMIT 1;
  
39. Display top 3 highest-paid employees in each department.  
40. Show employees who are assigned to the maximum number of projects.  


41. Find departments where no employee earns less than 30,000.  	
SELECT dept_id FROM employees 
GROUP BY dept_id
HAVING MIN(Salary)>=30000;

42. List employees who are not in the IT department but work on IT projects.  
SELECT e.emp_id, e.emp_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
JOIN Projects p ON e.emp_id = p.emp_id
WHERE d.dept_name <> 'IT'
  AND p.project_name = 'IT';
  
43. Show project-wise employee count and average salary.  
SELECT p.project_name, 
       COUNT(e.emp_id) AS emp_count, 
       AVG(e.salary) AS avg_salary
FROM Projects p
JOIN Employees e ON p.emp_id = e.emp_id
GROUP BY p.project_name;

44. Find employees who have never worked on any project.  
SELECT * FROM employees 
WHERE emp_id NOT IN (
SELECT emp_id FROM projects);

45. Display employees who changed departments (if history table exists).  
SELECT emp_id
FROM Employee_Department_History
GROUP BY emp_id
HAVING COUNT(DISTINCT dept_id) > 1;

*/

use assignment2;
desc employees;
desc departments;
desc projects;
select * from Departments;
select * from Employees;
select * from Projects;

