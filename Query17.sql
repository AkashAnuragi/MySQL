# CHECK Constraint
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CHECK (Age>=18) -- If you define a CHECK constraint on a column it will allow only certain values for this column.
);