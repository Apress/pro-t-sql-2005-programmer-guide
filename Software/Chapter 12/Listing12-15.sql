-- Listing 12-15 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'declare namespace
    p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
    //p1:Specifications/node()')
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO