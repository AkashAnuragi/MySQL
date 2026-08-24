create database clauses_Exercise1;
use clauses_Exercise1;

CREATE TABLE employees(
emp_id  INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(23),
 department VARCHAR(40),
 salary INT(10),
 age INT,
 city VARCHAR(10)
);

desc employees;

INSERT INTO employees(name,department,salary,age,city) VALUES
('Rahul','IT',60000,28, 'Delhi'),
('Neha','HR',45000,32, 'Mumbai'),
('Amit','IT',80000,35, 'Delhi'),
('Priya','Finance',70000,29, 'Pune'),
('Karan','HR',40000,25, 'Delhi');

INSERT INTO employees(name,department,salary,age) VALUES
('Akash','IT',60000,28);

SELECT * FROM employees;

/*   
WHERE Clause Questions 
1. IT department ke employees dikhao 
2. Salary 50000 se zyada walon ka data nikalo
3. Delhi city ke employees dikhao 
4. Age 30 se kam employees list karo 
5. Salary 60000 aur 80000 ke beech wale employees dikhao
  */
  
SELECT * FROM employees WHERE department = "IT";
SELECT * FROM employees WHERE salary >50000;
SELECT * FROM employees WHERE city = 'Delhi';
SELECT * FROM employees WHERE age <30;
SELECT * FROM employees WHERE salary BETWEEN 60000 and 80000;

/*
AND / OR Clause Questions 
6. IT department AND salary > 70000 wale employees 
7. HR OR Finance department ke employees 
8. City Delhi AND age > 30 
9. Salary < 50000 OR age < 28 
10. IT department AND city Delhi AND salary > 50000 
*/

SELECT * FROM employees WHERE department = 'IT' AND salary > '70000';
SELECT * FROM employees WHERE department = 'HR' OR department = 'Finance';
SELECT * FROM employees WHERE city = 'Delhi' AND age > 30;
SELECT * FROM employees WHERE salary < 50000 OR age <28;
SELECT * FROM employees WHERE department = 'IT' AND city ='Delhi' AND salary > 50000;

/* 
 ORDER BY Clause Questions 
 11. Employees ko salary ke according ascending order me dikhao 
 12. Employees ko salary ke according descending order me dikhao 
 13. Employees ko age ke according sort karo 
 14. Department ke basis par sort karo, phir salary descending 
 15. Delhi city ke employees ko salary descending order me dikhao 
*/
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY age ASC;
SELECT * FROM employees ORDER BY Department ASC, salary DESC;
SELECT * FROM employees WHERE city = 'Delhi' ORDER BY salary DESC;

/*
GROUP BY Clause Questions 
16. Har department ka total number of employees nikalo 
17. Har department ka average salary nikalo 
18. City-wise employee count nikalo 
19. Department-wise maximum salary find karo 
20. City-wise minimum salary nikalo 
*/
SELECT department,COUNT(*) as No_of_Emp FROM employees GROUP BY department;
SELECT department, AVG(salary) as Avg_salary FROM employees GROUP BY department;
SELECT City,COUNT(*) as No_of_Emp FROM employees GROUP BY City;
SELECT department,MAX(salary) as Max_salary FROM employees GROUP BY department;
SELECT City,MIN(salary) as Min_Salary FROM employees GROUP BY City;

/* 
HAVING Clause Questions 
21. Sirf un departments ko dikhao jinka average salary > 60000 
22. Sirf un cities ko dikhao jahan employees > 1 
23. Departments jahan maximum salary > 70000 
24. City-wise group banao aur sirf wahi dikhao jahan average age > 30 
25. Department-wise total salary dikhao jahan total salary > 100000
*/

SELECT department, AVG(salary) as Avg_salary FROM employees GROUP BY department HAVING Avg_Salary >60000;
SELECT City,COUNT(*) as No_of_Emp FROM employees GROUP BY City HAVING No_of_Emp > 1;
SELECT department,MAX(salary) as Max_salary FROM employees GROUP BY department HAVING Max_Salary >70000;
SELECT City,AVG(age) as Avg_Age FROM employees GROUP BY City HAVING Avg_Age >30;
SELECT department, SUM(salary) as Total_salary FROM employees GROUP BY department HAVING Total_salary>100000;

/*
LIMIT Clause Questions 
26. Top 3 highest paid employees dikhao 
27. First 2 records dikhao 
28. Salary descending order me sirf top 1 employee 
29. HR department ke first 2 employees 
30. Lowest salary wale 3 employees 
*/
SELECT * FROM employees ORDER BY salary DESC LIMIT 3;
SELECT * FROM employees LIMIT 2;
SELECT * FROM employees ORDER BY salary DESC LIMIT 1;
SELECT * FROM employees where department = 'HR' LIMIT 2;
SELECT * FROM employees ORDER BY salary ASC LIMIT 3;

/*
OFFSET Clause Questions 
31. Salary descending order me 2nd highest salary wala employee 
32. First 2 records skip karke next 2 records dikhao 
33. Top 5 salaries me se 3rd aur 4th employee 
34. IT department ke first record skip karke next record dikhao 
35. Age ascending order me first 1 skip karke next 3 dikhao 
*/
SELECT * FROM employees ORDER BY salary DESC LIMIT 1 OFFSET 1;
SELECT * FROM employees LIMIT 2 OFFSET 2;
SELECT * FROM employees ORDER BY salary DESC LIMIT 2 OFFSET 2;
SELECT * FROM employees WHERE department = 'IT' ORDER BY salary DESC LIMIT 1 OFFSET 1;
SELECT * FROM employees ORDER BY age ASC LIMIT 3 OFFSET 1;

/* 
Mixed Clauses (Real Interview Type) 
36. Department-wise average salary nikalo aur sirf wahi dikhao jahan avg salary > 50000, order by avg salary desc 
37. Delhi city ke employees ka department-wise count dikhao 
38. HR ya IT department ke employees ko salary descending order me dikhao, sirf top 2 
39. City-wise employee count dikhao jahan count > 1 
40. Highest paid employee from each department find karo 
*/
SELECT department, AVG(salary) AS avg_salary FROM employees
GROUP BY department HAVING AVG(salary) > 50000
ORDER BY avg_salary DESC;
















