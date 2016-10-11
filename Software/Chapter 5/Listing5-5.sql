-- Listing 5-5 from Chapter 5
-- This script needs the Numbers table.
USE AdventureWorks;
GO
-- Demonstrates a multistatement table-valued function (TVF)
IF OBJECT_ID('dbo.fnProductPullList') IS NOT NULL
    DROP FUNCTION dbo.fnProductPullList;
GO
CREATE FUNCTION dbo.fnProductPullList()
RETURNS @result TABLE (
    SalesOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    LocationID SMALLINT NOT NULL,
    Shelf NVARCHAR(10) NOT NULL,
    Bin TINYINT NOT NULL,
    QuantityInBin SMALLINT NOT NULL,
    QuantityOnOrder SMALLINT NOT NULL,
    QuantityToPull SMALLINT NOT NULL,
    PartialFillFlag CHAR(1) NOT NULL,
    PRIMARY KEY (SalesOrderID, ProductID, LocationID, Shelf, Bin))
WITH SCHEMABINDING
AS
BEGIN
    INSERT INTO @result (
        SalesOrderID, 
        ProductID, 
        LocationID, 
        Shelf, 
        Bin,
        QuantityInBin, 
        QuantityOnOrder, 
        QuantityToPull, 
        PartialFillFlag) 
    SELECT Order_Details.SalesOrderID, 
        Order_Details.ProductID, 
        Inventory_Details.LocationID, 
        Inventory_Details.Shelf, 
        Inventory_Details.Bin, 
        Inventory_Details.Quantity,
        Order_Details.OrderQty, 
        COUNT(*) AS PullQty,
        CASE WHEN COUNT(*) < Order_Details.OrderQty
            THEN 'Y'
            ELSE 'N'
        END AS PartialFillFlag
    FROM
    (
        SELECT ROW_NUMBER() OVER (PARTITION BY i.ProductID 
            ORDER BY i.ProductID, 
                i.LocationID, 
                i.Shelf, 
                i.Bin) AS Num,
            i.ProductID, 
            i.LocationID, 
            i.Shelf, 
            i.Bin, 
            i.Quantity
        FROM 
            (
                SELECT ProductID, 
                    LocationID, 
                    Shelf, 
                    Bin, 
                    Quantity
                FROM Production.ProductInventory
                INNER JOIN dbo.Numbers n
                    ON n.Num BETWEEN 1 AND Quantity
            ) i
        INNER JOIN Production.ProductInventory p
            ON i.ProductID = p.ProductID
                AND i.LocationID = p.LocationID
                AND i.Shelf = p.Shelf
                AND i.Bin = p.Bin
    ) Inventory_Details
    INNER JOIN
    (
        SELECT ROW_NUMBER() OVER (PARTITION BY o.ProductID
            ORDER BY o.ProductID, 
                o.SalesOrderID) AS Num,
            o.ProductID, 
            o.SalesOrderID, 
            o.OrderQty
        FROM 
            (
                SELECT ProductID, 
                    SalesOrderID, 
                    SalesOrderDetailID, 
                    OrderQty
                FROM Sales.SalesOrderDetail
                INNER JOIN dbo.Numbers n
                    ON n.Num BETWEEN 1 AND OrderQty
            ) o
        INNER JOIN Sales.SalesOrderDetail sod
            ON o.SalesOrderID = sod.SalesOrderID
                AND o.SalesOrderDetailID = sod.SalesOrderDetailID
                AND o.ProductID = sod.ProductID
    ) Order_Details
        ON Inventory_Details.ProductID = Order_Details.ProductID
            AND Inventory_Details.Num = Order_Details.Num
    GROUP BY Order_Details.SalesOrderID, 
        Order_Details.ProductID, 
        Inventory_Details.LocationID,
        Inventory_Details.Shelf, 
        Inventory_Details.Bin, 
        Inventory_Details.Quantity,
        Order_Details.OrderQty;
    RETURN;
END;
GO

SELECT p.Name AS ProductName, 
	p.ProductNumber, 
	p.Color, 
	ppl.SalesOrderID,
	ppl.ProductID,
	ppl.LocationID,
	ppl.Shelf,
	ppl.Bin,
	ppl.QuantityInBin,
	ppl.QuantityOnOrder,
	ppl.QuantityToPull,
	ppl.PartialFillFlag
FROM Production.Product p
INNER JOIN dbo.fnProductPullList() ppl
    ON p.ProductID = ppl.ProductID;
GO
