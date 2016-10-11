-- Listing 12-5 from Chapter 12
USE AdventureWorks;
GO

SELECT DISTINCT soh.SalesPersonID AS N'SalesPerson/@ID',
    (
        SELECT soh2.SalesOrderID AS N'data()'
        FROM Sales.SalesOrderHeader soh2
        WHERE soh2.SalesPersonID = soh.SalesPersonID
        FOR XML PATH (N'')
    ) AS N'SalesPerson/@Orders',
    c.FirstName AS N'SalesPerson/Name/First',
    c.MiddleName AS N'SalesPerson/Name/Middle',
    c.LastName AS N'SalesPerson/Name/Last',
    c.EmailAddress AS N'SalesPerson/Email'
FROM Sales.SalesOrderHeader soh
INNER JOIN Person.Contact c
    ON c.ContactID = soh.SalesPersonID
WHERE soh.SalesPersonID IS NOT NULL
FOR XML PATH;
GO