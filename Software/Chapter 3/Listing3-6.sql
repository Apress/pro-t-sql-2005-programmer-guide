-- Listing 3-6 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates the improved TOP with a subquery
SELECT TOP (SELECT COUNT(*) / 2 FROM Person.Contact)
    FirstName, 
    MiddleName, 
    LastName
FROM Person.Contact
ORDER BY FirstName, 
    MiddleName, 
    LastName;
GO