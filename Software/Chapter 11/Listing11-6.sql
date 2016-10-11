-- Listing 11-6 from Chapter 11
USE AdventureWorks;
GO

SELECT p.ProductID AS "Product/@ID",
    p.Name AS "Product/Name",
    p.ProductNumber AS "Product/Number",
    i.Quantity AS "Product/Quantity"
FROM Production.Product p
INNER JOIN Production.ProductInventory i
    ON p.ProductID = i.ProductID
WHERE p.ProductID = 770
    FOR XML PATH;
