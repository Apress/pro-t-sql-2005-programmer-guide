-- Listing 3-15 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates RANK function
WITH TotalSalesBySalesDate (TotalSales, OrderDate)
AS
(
    SELECT SUM(soh.SubTotal) AS TotalSales, soh.OrderDate
    FROM Sales.SalesOrderHeader soh
    WHERE soh.OrderDate >= '2001-01-01' 
        AND soh.OrderDate < '2002-01-01'
    GROUP BY soh.OrderDate
)
SELECT RANK() OVER 
(
    ORDER BY TotalSales DESC
) 
AS 'Rank', TotalSales, OrderDate
FROM TotalSalesBySalesDate;
GO