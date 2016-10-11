-- Listing 3-5 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates the improved TOP keyword with a variable
DECLARE @i INT;
SELECT @i = 20;
SELECT TOP (@i) PERCENT FirstName, 
    MiddleName, 
    LastName
FROM Person.Contact
ORDER BY FirstName, 
    MiddleName, 
    LastName;
GO