# Update Operator
SET SQL_SAFE_UPDATES = 0;
UPDATE students
SET stud_name = 'Akash Anuragi'
WHERE stud_name = 'Akash';
SET SQL_SAFE_UPDATES = 1;