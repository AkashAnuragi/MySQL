# Null 
Create Table marvel(
name varchar(20) not null,
age int not null
);

# Retrive all the Column  from table marvel
select * from marvel;

# Now Insert a data into the table
insert into marvel(name,age)
value('thor',454);  -- The NOT NULL constraint enforces a column to NOT accept NULL values.