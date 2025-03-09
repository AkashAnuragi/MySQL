# The DEFAULT constraint is used to set a default value for a column
Create Table cartoon(
name varchar(20) not null  default " no name specified." ,
age int not null default 99
);

desc cartoon;