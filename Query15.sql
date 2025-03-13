#Auto increment
Create table stu_table (
stu_id int auto_increment,
name varchar(20),
age int,
primary key(stu_id)
);

insert into stu_table( name, age)
values('Akash',24),
('Sagar',23),
('Kartik',20),
('Harsh',24);