-- Listing 12-14 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'//Specifications/node()') AS Specifications
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO