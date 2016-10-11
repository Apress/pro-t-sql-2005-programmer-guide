-- Listing 12-12 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'//comment()') AS Comments
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO