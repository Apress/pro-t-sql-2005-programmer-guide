-- Listing 16-2 from Chapter 16
USE AdventureWorks;
GO

CREATE PROCEDURE Sales.GetSalesPersonSales (@SalespersonID INT)
AS
BEGIN
    SELECT soh.SalesOrderID,
        soh.CustomerID,
        soh.OrderDate,
        soh.SubTotal
    FROM Sales.SalesOrderHeader soh
    WHERE soh.SalesPersonID = @SalespersonID
    ORDER BY soh.SalesOrderID;
END;
GO

