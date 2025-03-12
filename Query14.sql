# Primary key - Not allow duplicacy
Create table unique_table (
stu_id int not null primary key,
name varchar(20),
age int
);

insert into unique_table(stu_id, name, age)
values(101,'Akash',24),
(102,'Sagar',23),
(103,'Kartik',20),
(104,'Harsh',24);