-- Listing 16-1 from Chapter 16
USE AdventureWorks;
GO

CREATE PROCEDURE Sales.GetSalespersonList
AS
BEGIN
    SELECT s.SalesPersonID,
        s.LastName + ', ' + s.FirstName + ' ' + 
            COALESCE(s.MiddleName, '') AS FullName
    FROM Sales.vSalesPerson s
    ORDER BY s.LastName, s.FirstName, s.MiddleName;
END;
GO
