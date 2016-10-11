-- Listing 3-10 from Chapter 3
USE AdventureWorks;
GO
-- Alternate method of retrieving random sample of rows
SELECT TOP (10) PERCENT FirstName, 
    MiddleName, 
    LastName
FROM HumanResources.vEmployee
ORDER BY NEWID();
GO