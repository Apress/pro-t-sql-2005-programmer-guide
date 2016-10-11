-- Listing 12-33 from Chapter 12
USE AdventureWorks;
GO

SELECT CatalogDescription.query(N'declare namespace ns =
    "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription";
    for $spec in //ns:ProductDescription/ns:Specifications,
    $color in $spec/Color
    return <color> 
        {
            $color/text() 
        } 
    </color>') AS Color
FROM Production.ProductModel
WHERE ProductModelID = 19;
GO