-- Listing 11-2 from Chapter 11
USE AdventureWorks;
GO

SELECT ProductID,
    Name,
    ProductNumber
FROM Production.Product
WHERE ProductID = 770
    FOR XML AUTO;