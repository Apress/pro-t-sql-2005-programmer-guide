-- Listing 3-16 from Chapter 3
USE AdventureWorks;
GO
-- Demonstrates NTILE function
WITH TotalSalesBySalesDate (TotalSales, OrderDate)
AS
(
    SELECT SUM(soh.SubTotal) AS TotalSales, soh.OrderDate
    FROM Sales.SalesOrderHeader soh
    WHERE soh.OrderDate >= '2001-01-01' 
        AND soh.OrderDate < '2002-01-01'
    GROUP BY soh.OrderDate
)
SELECT NTILE(4) OVER 
(
    ORDER BY TotalSales DESC
) 
AS 'Rank', TotalSales, OrderDate
FROM TotalSalesBySalesDate;
GO