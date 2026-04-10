/* 
DDL Practical Questions 
1. Create a table Student with columns: 
o student_id (Primary Key) 
o name 
o age 
o email (unique)

CREATE DATABASE assignment1;
use assignment1;

create table student(
student_id  INT PRIMARY KEY,
name Varchar(50),
age INT,
email varchar(50) UNIQUE
);

2. Create a table Course with: 
o course_id 
o course_name 
o duration 

CREATE TABLE Course(
course_id int,
Course_name varchar(100),
duration int
);

3. Add a column phone_number to the Student table. 
ALTER TABLE Student add column phone_no int;

4. Change the datatype of age from INT to SMALLINT. 
ALTER TABLE student modify age smallint;

5. Rename the table Student to Students. 
RENAME TABLE student to Students;

6. Drop the column duration from the Course table. 
ALTER TABLE Course Drop column duration;

7. Add a CHECK constraint to ensure age >= 18. 
ALTER TABLE students modify column age smallint check (age >=18);

8. Create a table Employee with a foreign key referencing Course(course_id). 
CREATE TABLE employee (
    id INT,
    name VARCHAR(40),
    CONSTRAINT fk_student
    FOREIGN KEY (id) REFERENCES student(student_id)
);
9. Remove the foreign key constraint from the Employee table. 
ALTER TABLE employee
DROP FOREIGN KEY fk_student;

10. Delete all rows from Employee without deleting its structure.
TRUNCATE Employee;

DML Practical Questions 
1. Insert 5 records into the Students table. 
INSERT INTO  students (student_id,name,age,email,phone_no)values
(101,"Akash", 23, "akash132@gmail.com",0987654321),
(102,"Rohit",24,"rohit6543@gmail.com",543212345),
(103,"Aman",34,"aman7654@gmail.com",987656789),
(104,"Kartik",32,"kartik5432@gmail.com",654345234),
(105,"Yash",43,"Yash43@gmail.com",765432456);

2. Insert multiple records into Course using a single query. 
INSERT INTO  course(course_id, course_name)values
(1,"DSA"),
(2,"FSD"),
(3,"AL & ML"),
(4,"Data Science"),
(5, "Data Analytics");

3. Display all records from Students.
SELECT * FROM students;
 
4. Display only name and email from Students. 
SELECT name, email FROM students;

5. Update the email of a student whose student_id = 3.
UPDATE students SET  email = "amankumar543@gmail.com" where student_id = 103;
 
6. Increase age of all students by 1 year. 
update students set age = age+1;

7. Delete a student record where student_id = 5. 
DELETE from students where student_id = 105;

8. Display students whose age is greater than 20. 
SELECT age FROM students where age > 20;

9. Display students sorted by age in descending order. 
SELECT * FROM students ORDER BY age DESC;

10. Display only the first 3 records from Students.
SELECT * FROM students LIMIT 3;

*/
desc students;
desc Course;
desc employee;
select * from course;
SELECT * FROM students where age > 20;

SET SQL_SAFE_UPDATES = 0;



