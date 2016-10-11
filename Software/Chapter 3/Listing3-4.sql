-- Listing 3-4 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates the EXCEPT operator
SELECT ContactID,
    LastName,
    FirstName, 
    MiddleName
FROM Person.Contact
WHERE LastName LIKE N'A%' 
EXCEPT
SELECT ContactID, 
    LastName, 
    FirstName, 
    MiddleName
FROM Person.Contact
WHERE LastName = N'Adams';
GO