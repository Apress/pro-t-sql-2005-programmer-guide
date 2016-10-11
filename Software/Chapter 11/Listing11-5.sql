-- Listing 11-5 from Chapter 11
USE AdventureWorks;
GO

SELECT 1 AS Tag,
    NULL AS Parent,
    ProductID AS [Products!1!ProductID!element],
    Name AS [Products!1!ProductName],
    ProductNumber AS [Products!1!ProductNumber],
    NULL AS [Products!2!Quantity]
FROM Production.Product
WHERE ProductID = 770
UNION ALL
SELECT 2 AS Tag,
    1 AS Parent,
    NULL,
    NULL,
    NULL,
    Quantity
FROM Production.ProductInventory
WHERE ProductID = 770
    FOR XML EXPLICIT;