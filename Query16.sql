# The UNIQUE constraint ensures that all values in a column are different.
Create table contacts(
name varchar(20) not null,
phone varchar(10) not null unique
);