-- Listing 12-32 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'declare namespace ns =
    "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
    for $spec in //ns:ProductDescription/ns:Specifications/*,
    $feat in //ns:ProductDescription/*:Features/*:Warranty/node()
    return <detail> 
        {
            $spec/text() 
        } + { 
            $feat/. cast as xs:string? 
        } 
    </detail>')
AS Description
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO