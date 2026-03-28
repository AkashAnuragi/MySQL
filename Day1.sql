-- DAY 1 CLASSIFICATION OF SQL
-- DDL, DML, DCL, TCL
-- TODAY WE LEARN ONLY DDL(Data Definition Language)
-- Create, Alter, Drop 

-- 1 Create 
-- Create Database
 Create Database School;
 
 -- Opening Database
 use School;
 
 -- Creating Table
 CREATE table student(
 Rollno int Not null primary key,
 Name  varchar(20),
 Gender Char(1),
 Marks int,
 DOB date);
 
 -- View Table 
 Show tables;
 
 -- Describe table (View a table structure)
 Desc student;
 
  -- 2. DROP
 -- Removing Database
 DROP database school;
 
 -- Drop Table
DROP table student;

-- Alter
-- it is used for modifying the structue of existing table
-- we can --> ADD, DELETE, CHANGE, RENAME Table or Column

-- ADD
Alter table student 
ADD age int(3);

-- ADD multiple column
alter table student
add (age int(3), address varchar(110));
-- Delete
Alter table student
Drop column age;

-- Modify
Alter table student
modify 	name varchar(110);

-- CHANGE       
alter table student
CHANGE stud_name name varchar(100);
--  Modify can change only data type whereas CHANGE syntax change name and datatype both...alter

desc students;

-- Rename
-- Rename column name
Alter table student
Rename column name to stud_Name;

-- Rename Table name 
Alter table Student RENAME to students;