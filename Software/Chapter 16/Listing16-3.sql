-- Listing 16-3 from Chapter 16
USE AdventureWorks;
GO

CREATE FUNCTION Sales.GetSalesTotal(@SalespersonID INT)
RETURNS MONEY
AS
BEGIN
    RETURN (
        SELECT SUM(soh.SubTotal)
        FROM Sales.SalesOrderHeader soh
        WHERE SalesPersonID = @SalespersonID
    );
END;
GO


