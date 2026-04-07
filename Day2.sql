-- Day 2 
-- Today we learn DML Command. 
-- DML(Data Manipualtion Language)--> Insert, Update, Delete
desc students;
select * from students;
-- 1. Insert Values
INSERT INTO students values(101, "Akash","M",89,"2002-12-12",23,"NOida");

-- OR 
INSERT INTO students (rollno, name, gender, dob, age, address)VALUES (102, 'Sagar', 'M', '2001-01-21', 24, 'Meerut');

-- Insert multipe Values
INSERT INTO students values(106, "Kartik","M",49,"2003-02-22",25,"Manali"),
(107, "Aman","M",79,"1998-07-04",30,"Shimla");

-- 2. Update
UPDATE students set address = "Nodia" where rollno = 101;

-- 3. Delete
Delete from students; -- Delete all data
Delete from students where rollno =108  -- Delete specific data
