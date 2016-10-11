-- Listing 6-3 from Chapter 6
USE AdventureWorks;
GO
-- Demonstrates a stored procedure to recommend products
IF OBJECT_ID('dbo.GetProductRecommendations') IS NOT NULL
    DROP PROCEDURE dbo.GetProductRecommendations;
GO
CREATE PROCEDURE dbo.GetProductRecommendations (@ProductID INT = 776)
AS
BEGIN
    WITH RecommendedProducts (TotalQtyOrdered, 
        ProductID, 
        TotalDollarsOrdered, 
        ProductSubCategoryID)
    AS
    (
        SELECT SUM(od2.OrderQty) AS TotalQtyOrdered, 
            od2.ProductID, 
            SUM(od2.UnitPrice * od2.OrderQty) AS TotalDollarsOrdered,
            p1.ProductSubCategoryID
        FROM Sales.SalesOrderDetail od1
        INNER JOIN Sales.SalesOrderDetail od2
            ON od1.SalesOrderID = od2.SalesOrderID
        INNER JOIN Production.Product p1
            ON od2.ProductID = p1.ProductID
        WHERE od1.ProductID = @ProductID
            AND od2.ProductID <> @ProductID
        GROUP BY od2.ProductID, p1.ProductSubcategoryID
    )
    SELECT TOP 10 ROW_NUMBER() OVER (ORDER BY rp.TotalQtyOrdered DESC) AS Rank,
        rp.TotalQtyOrdered, 
        rp.ProductID, 
        rp.TotalDollarsOrdered, 
        p.[Name]
    FROM RecommendedProducts rp
    INNER JOIN Production.Product p
        ON rp.ProductID = p.ProductID
    WHERE rp.ProductSubcategoryID <>
        (
            SELECT ProductSubcategoryID
            FROM Production.Product
            WHERE ProductID = @ProductID
        )
    ORDER BY TotalQtyOrdered DESC;
    RETURN 0;
END;
GO
EXECUTE dbo.GetProductRecommendations 773;
GO