-- Listing 12-13 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'//*:Specifications/node()') AS Specifications
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO