-- Listing 12-16 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'declare default element namespace
    "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
    //Specifications/node()')
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO