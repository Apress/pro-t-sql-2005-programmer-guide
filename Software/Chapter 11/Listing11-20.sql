-- Listing 11-20 from Chapter 11
USE AdventureWorks;
GO

DECLARE @xml XML;

SELECT @xml = (
    SELECT p.ProductNumber AS N'@Id',
        p.Name AS N'Name',
        p.Color AS N'Color',
        p.ListPrice AS N'ListPrice',
        p.SizeUnitMeasureCode AS N'Size/@UOM',
        p.Size AS N'Size',
        p.WeightUnitMeasureCode AS N'Weight/@UOM',
        p.Weight AS N'Weight',
        (
            SELECT COALESCE(SUM(i.Quantity), 0)
            FROM Production.ProductInventory i
            WHERE i.ProductID = p.ProductID
        ) AS N'QuantityOnHand'
    FROM Production.Product p
    WHERE FinishedGoodsFlag = 1
    ORDER BY p.Name
    FOR XML PATH (N'Product'),
        ROOT (N'Products')
);

SELECT @xml;
GO