-- Listing 14-SideBar1 from Chapter 14

-- Median calculation example
USE AdventureWorks;
GO

WITH CalcTotalDueMedian (Num, TotalDue)
AS
(
    SELECT ROW_NUMBER() OVER (ORDER BY TotalDue) AS Num, TotalDue
    FROM Sales.SalesOrderHeader
)
SELECT AVG(TotalDue) AS Median
FROM CalcTotalDueMedian
WHERE Num IN (
    SELECT MAX(Num + 1)/2
    FROM CalcTotalDueMedian
    UNION
    SELECT MAX(Num + 2)/2
    FROM CalcTotalDueMedian
);
GO
