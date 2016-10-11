-- Listing 3-9 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates TABLESAMPLE
SELECT FirstName, 
    MiddleName, 
    LastName 
FROM Person.Contact 
TABLESAMPLE (10 PERCENT);
GO