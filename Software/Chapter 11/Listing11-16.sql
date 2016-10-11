-- Listing 11-16 from Chapter 11
USE AdventureWorks;
GO

SELECT ProductModelId, Name, Specs.query(N'.') AS Result
FROM Production.ProductModel
CROSS APPLY CatalogDescription.nodes(N'declare namespace
    ns = "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
    /ns:ProductDescription/ns:Specifications/Material/text()[contains(.,"Alloy")]')
AS NodeTable(Specs);
GO