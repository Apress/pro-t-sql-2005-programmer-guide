-- Listing 12-11 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'/processing-instruction()') AS Processing_Instr
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO