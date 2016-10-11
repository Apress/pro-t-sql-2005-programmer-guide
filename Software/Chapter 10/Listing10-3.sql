-- Listing 10-3 from Chapter 10
USE AdventureWorks;
GO
-- Dynamic SQL with string appended
DECLARE @product_name NVARCHAR(50);
SELECT @product_name = N'Mountain';
DECLARE @sql_stmt NVARCHAR(128);
SELECT @sql_stmt = N'SELECT ProductID, Name ' +
    N'FROM Production.Product ' +
    N'WHERE Name LIKE ''' +
    @product_name + N'%''';
EXECUTE (@sql_stmt);
GO