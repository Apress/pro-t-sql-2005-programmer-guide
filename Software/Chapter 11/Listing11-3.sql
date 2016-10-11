-- Listing 11-3 from Chapter 11
USE AdventureWorks;
GO

SELECT Product.ProductID,
    Product.Name,
    Product.ProductNumber,
    Inventory.Quantity
FROM Production.Product Product
INNER JOIN Production.ProductInventory Inventory
    ON Product.ProductID = Inventory.ProductID
WHERE Product.ProductID = 770
    FOR XML AUTO;